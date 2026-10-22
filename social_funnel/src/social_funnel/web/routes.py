"""Review actions protected by a session CSRF token."""

from pathlib import Path
from secrets import token_urlsafe
import tempfile
from types import SimpleNamespace

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import FileResponse, HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates

from social_funnel.domain.models import CampaignManifest, JobState
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.media.service import MediaImportService
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.scheduling.service import SchedulerService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import JobRepository, MediaImportRepository


TEMPLATES = Jinja2Templates(directory=Path(__file__).with_name("templates"))


def make_router(db: Database, jobs: JobRepository, manifest: CampaignManifest, workspace: Path,
                scheduler: SchedulerService | None = None) -> APIRouter:
    router = APIRouter()
    scheduler = scheduler or SchedulerService(db, jobs, None)
    orchestrator = PublishingOrchestrator(jobs, manifest, {}, workspace / "media")
    media_repository = MediaImportRepository(db)
    media_service = MediaImportService(media_repository, manifest, workspace)

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
        active = media_repository.active_batch(manifest.slug)
        selected = media_repository.get_batch(batch_id) if batch_id else active
        files = media_repository.batch_files(selected["id"]) if selected else ()
        ready = len({(row["day"], row["locale"]) for row in files})
        coverage = {(row["day"], row["locale"]): row["kind"] for row in files}
        return {
            "csrf": csrf(request), "active": active, "selected": selected, "batches": media_repository.list_batches(manifest.slug),
            "ready": ready, "coverage": coverage, "issues": issues, "ideas": manifest.ideas,
        }

    @router.get("/", response_class=HTMLResponse)
    def dashboard(request: Request):
        rows = db.connection.execute("SELECT state,COUNT(*) AS n FROM publication_job GROUP BY state").fetchall()
        counts = {row["state"]: row["n"] for row in rows}
        accounts = db.connection.execute("SELECT id,platform,locale,public_identity FROM account_connection ORDER BY locale,platform").fetchall()
        return TEMPLATES.TemplateResponse(request, "dashboard.html", {
            "csrf": csrf(request), "counts": counts, "total": jobs.count(),
            "accounts": accounts, "paused": scheduler.paused, "ideas": manifest.ideas,
            "campaign_active": scheduler.active,
        })

    @router.get("/health")
    def health():
        return {"status": "ok", "jobs": jobs.count(), "paused": scheduler.paused}

    @router.get("/media", response_class=HTMLResponse)
    def media_workspace(request: Request, batch: str | None = None):
        return TEMPLATES.TemplateResponse(request, "media_import.html", media_context(request, batch_id=batch))

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
            result = media_service.preflight(path)
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
            media_service.activate(batch_id)
        except KeyError:
            raise HTTPException(404, "Media batch not found") from None
        return RedirectResponse("/media", status_code=303)

    @router.post("/media/rollback")
    async def rollback_media(request: Request):
        await check_csrf(request)
        media_service.rollback()
        return RedirectResponse("/media", status_code=303)

    @router.post("/campaign/activate")
    async def activate_campaign(request: Request):
        await check_csrf(request)
        expected = {
            (idea.day, item.locale.value)
            for idea in manifest.ideas for item in idea.localized
            if item.preferred_format == "video"
        }
        available = {
            (row["day"], row["locale"])
            for row in media_repository.active_files(manifest.slug)
            if row["kind"] == "video" and Path(row["managed_path"]).is_file()
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
        idea = manifest.ideas[day - 1]
        rows = db.connection.execute("SELECT id,locale,platform,state FROM publication_job WHERE day=? ORDER BY locale,platform", (day,)).fetchall()
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
        if job.state == JobState.DRAFT:
            orchestrator.prepare(job_id)
        if jobs.get(job_id).state == JobState.NEEDS_REVIEW:
            orchestrator.approve(job_id)
        return RedirectResponse(f"/days/{job.day}", status_code=303)

    @router.post("/jobs/{job_id}/disable")
    async def disable(request: Request, job_id: str):
        await check_csrf(request)
        job = jobs.get(job_id)
        jobs.transition(job_id, job.state, JobState.DISABLED)
        return RedirectResponse(f"/days/{job.day}", status_code=303)

    @router.post("/days/{day}/export")
    async def export_day(request: Request, day: int):
        await check_csrf(request)
        if not 1 <= day <= 30:
            raise HTTPException(404)
        ids = tuple(row[0] for row in db.connection.execute("SELECT id FROM publication_job WHERE day=? AND state!='disabled'", (day,)))
        destination = export_manual_pack(ids, workspace / "exports" / f"day-{day:02d}.zip", jobs, manifest,
                                         workspace / "media")
        return FileResponse(destination, media_type="application/zip", filename=destination.name)

    return router
