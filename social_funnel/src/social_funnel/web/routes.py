"""Review actions protected by a session CSRF token."""

from pathlib import Path
from secrets import token_urlsafe
from hashlib import sha256
import tempfile
from types import SimpleNamespace

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import FileResponse, HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates

from social_funnel.domain.models import CampaignManifest, JobState
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.campaign.expansion import AccountConfig
from social_funnel.campaign.registry import CampaignRegistry
from social_funnel.campaign.service import CampaignRefreshService
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.media.service import MediaImportService
from social_funnel.media.resolver import MediaResolver
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.scheduling.service import SchedulerService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRevisionRepository, JobRepository, MediaImportRepository


TEMPLATES = Jinja2Templates(directory=Path(__file__).with_name("templates"))


def _checksum(path: Path) -> str:
    digest = sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _verified_file(row) -> bool:
    path = Path(row["managed_path"])
    try:
        return path.is_file() and _checksum(path) == row["checksum"]
    except OSError:
        return False


def make_router(db: Database, jobs: JobRepository, manifest: CampaignManifest, workspace: Path,
                scheduler: SchedulerService | None = None,
                registry: CampaignRegistry | None = None) -> APIRouter:
    router = APIRouter()
    scheduler = scheduler or SchedulerService(db, jobs, None)
    registry = registry or CampaignRegistry(db, manifest)
    media_repository = MediaImportRepository(db)
    revision_repository = CampaignRevisionRepository(db)
    campaign_refresh = CampaignRefreshService(db, workspace)
    campaign_accounts = tuple(
        AccountConfig(id=f"{locale.value}-{platform.value}", locale=locale, platform=platform,
                      automation_mode=AutomationMode.APPROVAL)
        for locale in LocaleCode for platform in Platform
    )

    def current_manifest() -> CampaignManifest:
        return registry.active_manifest()

    def current_media_service() -> MediaImportService:
        return MediaImportService(media_repository, current_manifest(), workspace)

    def current_orchestrator() -> PublishingOrchestrator:
        campaign = current_manifest()
        resolver = MediaResolver(media_repository, campaign, workspace / "media")
        return PublishingOrchestrator(
            jobs, campaign, {}, workspace / "media", media_resolver=resolver,
        )

    def campaign_context(request: Request, *, revision_id: str | None = None, issues=()):
        active = revision_repository.active()
        try:
            selected = revision_repository.get(revision_id) if revision_id else active
        except KeyError:
            selected = None
        selected_manifest = (
            CampaignManifest.model_validate_json(selected["manifest_json"]) if selected else None
        )
        format_counts = {"video": 0, "image": 0, "carousel": 0}
        if selected_manifest:
            for idea in selected_manifest.ideas:
                for item in idea.localized:
                    format_counts[item.preferred_format] += 1
        return {
            "csrf": csrf(request), "active": active, "selected": selected,
            "selected_manifest": selected_manifest, "revisions": revision_repository.list(),
            "format_counts": format_counts, "issues": issues,
        }

    def csrf(request: Request) -> str:
        if "csrf" not in request.session:
            request.session["csrf"] = token_urlsafe(24)
        return request.session["csrf"]

    async def check_csrf(request: Request):
        values = await request.form()
        if not request.session.get("csrf") or values.get("csrf") != request.session["csrf"]:
            raise HTTPException(403, "Invalid CSRF token")
        return values

    def media_context(request: Request, *, batch_id: str | None = None, issues=()):
        manifest = current_manifest()
        active = media_repository.active_batch(manifest.slug)
        selected = media_repository.get_batch(batch_id) if batch_id else active
        if selected is not None and selected["campaign_slug"] != manifest.slug:
            selected = None
        files = media_repository.batch_files(selected["id"]) if selected else ()
        coverage = {
            (idea.day, item.locale.value): "otomatik"
            for idea in manifest.ideas for item in idea.localized
            if item.preferred_format != "video"
        }
        for row in files:
            coverage[(row["day"], row["locale"])] = row["kind"]
        previews: dict[tuple[int, str], list] = {}
        for row in files:
            previews.setdefault((row["day"], row["locale"]), []).append(row)
        ready = len(coverage)
        return {
            "csrf": csrf(request), "active": active, "selected": selected, "batches": media_repository.list_batches(manifest.slug),
            "ready": ready, "coverage": coverage, "previews": previews,
            "issues": issues, "ideas": manifest.ideas,
        }

    @router.get("/", response_class=HTMLResponse)
    def dashboard(request: Request):
        manifest = current_manifest()
        rows = db.connection.execute(
            "SELECT state,COUNT(*) AS n FROM publication_job WHERE campaign_slug=? GROUP BY state",
            (manifest.slug,),
        ).fetchall()
        counts = {row["state"]: row["n"] for row in rows}
        accounts = db.connection.execute("SELECT id,platform,locale,public_identity FROM account_connection ORDER BY locale,platform").fetchall()
        return TEMPLATES.TemplateResponse(request, "dashboard.html", {
            "csrf": csrf(request), "counts": counts, "total": sum(counts.values()),
            "accounts": accounts, "paused": scheduler.paused, "ideas": manifest.ideas,
            "campaign_active": scheduler.active, "campaign_title": manifest.title,
            "campaign_month": registry.active_month(),
        })

    @router.get("/health")
    def health():
        manifest = current_manifest()
        count = db.connection.execute(
            "SELECT COUNT(*) FROM publication_job WHERE campaign_slug=?", (manifest.slug,),
        ).fetchone()[0]
        return {"status": "ok", "jobs": count, "paused": scheduler.paused}

    @router.get("/campaigns", response_class=HTMLResponse)
    def campaign_workspace(request: Request, revision: str | None = None):
        return TEMPLATES.TemplateResponse(
            request, "campaign_import.html", campaign_context(request, revision_id=revision),
        )

    @router.post("/campaigns/preflight")
    async def campaign_preflight(request: Request):
        form = await check_csrf(request)
        upload = form.get("package")
        if upload is None or not getattr(upload, "filename", "").lower().endswith(".json"):
            issue = SimpleNamespace(message="Lütfen bir JSON kampanya paketi seçin.")
            return TEMPLATES.TemplateResponse(
                request, "campaign_import.html", campaign_context(request, issues=(issue,)), status_code=400,
            )
        temporary_dir = workspace / "tmp"
        temporary_dir.mkdir(parents=True, exist_ok=True)
        handle = tempfile.NamedTemporaryFile(delete=False, suffix=".json", dir=temporary_dir)
        path = Path(handle.name)
        total = 0
        try:
            with handle:
                while chunk := await upload.read(1024 * 1024):
                    total += len(chunk)
                    if total > 5 * 1024 * 1024:
                        raise HTTPException(413, "Kampanya paketi çok büyük")
                    handle.write(chunk)
            try:
                result = campaign_refresh.preflight(path)
            except ValueError:
                issue = SimpleNamespace(message="Kampanya paketi doğrulanamadı.")
                return TEMPLATES.TemplateResponse(
                    request, "campaign_import.html", campaign_context(request, issues=(issue,)), status_code=400,
                )
            return RedirectResponse(f"/campaigns?revision={result.revision_id}", status_code=303)
        finally:
            path.unlink(missing_ok=True)

    @router.post("/campaigns/{revision_id}/activate")
    async def activate_campaign_revision(request: Request, revision_id: str):
        await check_csrf(request)
        try:
            campaign_refresh.activate(revision_id, campaign_accounts)
        except KeyError:
            raise HTTPException(404, "Campaign revision not found") from None
        except ValueError:
            issue = SimpleNamespace(message="Kampanya sürümü etkinleştirilemedi.")
            return TEMPLATES.TemplateResponse(
                request, "campaign_import.html",
                campaign_context(request, revision_id=revision_id, issues=(issue,)), status_code=409,
            )
        return RedirectResponse("/campaigns", status_code=303)

    @router.post("/campaigns/rollback")
    async def rollback_campaign_revision(request: Request):
        await check_csrf(request)
        campaign_refresh.rollback()
        return RedirectResponse("/campaigns", status_code=303)

    @router.get("/media", response_class=HTMLResponse)
    def media_workspace(request: Request, batch: str | None = None):
        return TEMPLATES.TemplateResponse(request, "media_import.html", media_context(request, batch_id=batch))

    @router.get("/media/files/{file_id}")
    def preview_media(file_id: int):
        manifest = current_manifest()
        row = media_repository.get_file(manifest.slug, file_id)
        if row is None:
            raise HTTPException(404)
        path = Path(row["managed_path"])
        if not path.is_file():
            raise HTTPException(404)
        if _checksum(path) != row["checksum"]:
            raise HTTPException(409, "Media checksum mismatch")
        return FileResponse(path, media_type=row["mime_type"])

    @router.post("/media/preflight")
    async def media_preflight(request: Request):
        form = await check_csrf(request)
        upload = form.get("archive")
        if upload is None or not getattr(upload, "filename", "").lower().endswith(".zip"):
            return TEMPLATES.TemplateResponse(request, "media_import.html", media_context(
                request, issues=(type("Issue", (), {"code": "invalid_zip", "message": "Lütfen bir ZIP dosyası seçin."})(),)
            ), status_code=400)
        temporary_dir = workspace / "tmp"
        temporary_dir.mkdir(parents=True, exist_ok=True)
        handle = tempfile.NamedTemporaryFile(delete=False, suffix=".zip", dir=temporary_dir)
        path = Path(handle.name)
        total = 0
        try:
            with handle:
                while chunk := await upload.read(1024 * 1024):
                    total += len(chunk)
                    if total > 2 * 1024 * 1024 * 1024:
                        raise HTTPException(413, "ZIP dosyası çok büyük")
                    handle.write(chunk)
            result = current_media_service().preflight(path)
            if not result.report.valid:
                return TEMPLATES.TemplateResponse(request, "media_import.html", media_context(
                    request, issues=result.report.issues
                ), status_code=400)
            return RedirectResponse(f"/media?batch={result.batch_id}", status_code=303)
        finally:
            path.unlink(missing_ok=True)

    @router.post("/media/{batch_id}/activate")
    async def activate_media(request: Request, batch_id: str):
        await check_csrf(request)
        try:
            current_media_service().activate(batch_id)
        except KeyError:
            raise HTTPException(404, "Media batch not found") from None
        scheduler.deactivate()
        return RedirectResponse("/media", status_code=303)

    @router.post("/media/replace")
    async def replace_media(request: Request):
        form = await check_csrf(request)
        upload = form.get("file")
        try:
            day = int(form.get("day", ""))
            position = int(form.get("position", "0"))
            locale = str(form.get("locale", ""))
            kind = str(form.get("kind", ""))
        except ValueError:
            raise HTTPException(400, "Geçersiz içerik alanı") from None
        if upload is None or not getattr(upload, "filename", ""):
            raise HTTPException(400, "Dosya seçilmedi")
        suffix = ".mp4" if kind == "video" else ".png"
        temporary_dir = workspace / "tmp"
        temporary_dir.mkdir(parents=True, exist_ok=True)
        handle = tempfile.NamedTemporaryFile(delete=False, suffix=suffix, dir=temporary_dir)
        path = Path(handle.name)
        total = 0
        try:
            with handle:
                while chunk := await upload.read(1024 * 1024):
                    total += len(chunk)
                    if total > 500 * 1024 * 1024:
                        raise HTTPException(413, "Dosya çok büyük")
                    handle.write(chunk)
            try:
                batch_id = current_media_service().replace_slot(
                    path, day=day, locale=locale, kind=kind, position=position,
                )
            except (FileNotFoundError, ValueError) as exc:
                issue = SimpleNamespace(code="invalid_media", message=str(exc))
                return TEMPLATES.TemplateResponse(
                    request, "media_import.html", media_context(request, issues=(issue,)), status_code=400,
                )
            return RedirectResponse(f"/media?batch={batch_id}", status_code=303)
        finally:
            path.unlink(missing_ok=True)

    @router.post("/media/rollback")
    async def rollback_media(request: Request):
        await check_csrf(request)
        current_media_service().rollback()
        scheduler.deactivate()
        return RedirectResponse("/media", status_code=303)

    @router.post("/campaign/activate")
    async def activate_campaign(request: Request):
        await check_csrf(request)
        manifest = current_manifest()
        expected = {
            (idea.day, item.locale.value)
            for idea in manifest.ideas for item in idea.localized
            if item.preferred_format == "video"
        }
        available = {
            (row["day"], row["locale"])
            for row in media_repository.active_files(manifest.slug)
            if row["kind"] == "video" and _verified_file(row)
        }
        missing = expected - available
        if missing:
            issue = SimpleNamespace(code="missing_videos", message=f"Kampanyayı etkinleştirmek için 30 video gerekli; {len(missing)} video eksik.")
            return TEMPLATES.TemplateResponse(request, "media_import.html", media_context(request, issues=(issue,)), status_code=409)
        scheduler.activate()
        return RedirectResponse("/", status_code=303)

    @router.post("/campaign/deactivate")
    async def deactivate_campaign(request: Request):
        await check_csrf(request)
        scheduler.deactivate()
        return RedirectResponse("/", status_code=303)

    @router.get("/days/{day}", response_class=HTMLResponse)
    def day_detail(request: Request, day: int):
        if not 1 <= day <= 30:
            raise HTTPException(404)
        manifest = current_manifest()
        idea = manifest.ideas[day - 1]
        rows = db.connection.execute(
            """SELECT id,locale,platform,state FROM publication_job
            WHERE campaign_slug=? AND day=? ORDER BY locale,platform""", (manifest.slug, day),
        ).fetchall()
        return TEMPLATES.TemplateResponse(request, "content_detail.html", {
            "csrf": csrf(request), "idea": idea, "jobs": rows,
        })

    @router.post("/pause")
    async def pause(request: Request):
        await check_csrf(request)
        scheduler.pause()
        return RedirectResponse("/", status_code=303)

    @router.post("/resume")
    async def resume(request: Request):
        await check_csrf(request)
        scheduler.resume()
        return RedirectResponse("/", status_code=303)

    @router.post("/jobs/{job_id}/approve")
    async def approve(request: Request, job_id: str):
        await check_csrf(request)
        job = jobs.get(job_id)
        if job.campaign_slug != current_manifest().slug:
            raise HTTPException(404)
        orchestrator = current_orchestrator()
        if job.state == JobState.DRAFT:
            orchestrator.prepare(job_id)
        if jobs.get(job_id).state == JobState.NEEDS_REVIEW:
            orchestrator.approve(job_id)
        return RedirectResponse(f"/days/{job.day}", status_code=303)

    @router.post("/jobs/{job_id}/disable")
    async def disable(request: Request, job_id: str):
        await check_csrf(request)
        job = jobs.get(job_id)
        if job.campaign_slug != current_manifest().slug:
            raise HTTPException(404)
        jobs.transition(job_id, job.state, JobState.DISABLED)
        return RedirectResponse(f"/days/{job.day}", status_code=303)

    @router.post("/days/{day}/export")
    async def export_day(request: Request, day: int):
        await check_csrf(request)
        if not 1 <= day <= 30:
            raise HTTPException(404)
        manifest = current_manifest()
        ids = tuple(row[0] for row in db.connection.execute(
            """SELECT id FROM publication_job
            WHERE campaign_slug=? AND day=? AND state!='disabled'""", (manifest.slug, day),
        ))
        destination = export_manual_pack(
            ids, workspace / "exports" / manifest.slug / f"day-{day:02d}.zip",
            jobs, manifest, workspace / "media",
        )
        return FileResponse(destination, media_type="application/zip", filename=destination.name)

    return router
