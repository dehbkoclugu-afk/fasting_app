"""Review actions protected by a session CSRF token."""

from datetime import datetime, timezone
from pathlib import Path
from secrets import token_urlsafe
from hashlib import sha256
import tempfile
from types import SimpleNamespace
from zoneinfo import ZoneInfo

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import FileResponse, HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates

from social_funnel.auth.tiktok_connection import TikTokConnectionService
from social_funnel.auth.meta_connection import MetaConnectionService
from social_funnel.auth.threads_connection import ThreadsConnectionService
from social_funnel.domain.models import CampaignManifest, JobState
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.campaign.expansion import AccountConfig, MARKET_SCHEDULES
from social_funnel.campaign.registry import CampaignRegistry
from social_funnel.campaign.service import CampaignRefreshService
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.media.service import MediaImportService
from social_funnel.media.resolver import MediaResolver
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.scheduling.service import SchedulerService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import (
    AccountConnectionRepository, CampaignRevisionRepository, JobRepository, MediaImportRepository,
    TikTokStateRepository,
)


TEMPLATES = Jinja2Templates(directory=Path(__file__).with_name("templates"))
JOB_STATE_LABELS = {
    "draft": "Taslak",
    "needs_review": "İnceleme bekliyor",
    "approved": "Onaylandı",
    "scheduled": "Planlandı",
    "uploading": "Yükleniyor",
    "processing": "İşleniyor",
    "published": "Yayınlandı",
    "failed": "İşlem gerekli",
    "disabled": "Kapalı",
}


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
                registry: CampaignRegistry | None = None,
                tiktok_connection: TikTokConnectionService | None = None,
                meta_connection: MetaConnectionService | None = None,
                threads_connection: ThreadsConnectionService | None = None,
                media_hosting=None,
                orchestrator_factory=None) -> APIRouter:
    router = APIRouter()
    scheduler = scheduler or SchedulerService(db, jobs, None)
    registry = registry or CampaignRegistry(db, manifest)
    media_repository = MediaImportRepository(db)
    revision_repository = CampaignRevisionRepository(db)
    campaign_refresh = CampaignRefreshService(db, workspace)
    account_repository = AccountConnectionRepository(db)
    tiktok_state = TikTokStateRepository(db)
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
        if orchestrator_factory is not None:
            return orchestrator_factory()
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

    def oauth_redirect_uri(request: Request) -> str:
        return str(request.url_for("tiktok_callback"))

    def meta_redirect_uri(request: Request) -> str:
        return str(request.url_for("meta_callback"))

    def threads_redirect_uri(request: Request) -> str:
        return str(request.url_for("threads_callback"))

    @router.get("/accounts", response_class=HTMLResponse)
    def account_connections(request: Request, notice: str | None = None,
                            error: str | None = None):
        configured = False
        if tiktok_connection is not None:
            try:
                configured = tiktok_connection.configured()
            except Exception:
                configured = False
        meta_configured = False
        if meta_connection is not None:
            try:
                meta_configured = meta_connection.configured()
            except Exception:
                meta_configured = False
        threads_configured = False
        if threads_connection is not None:
            try:
                threads_configured = threads_connection.configured()
            except Exception:
                threads_configured = False
        hosting_configured = False
        if media_hosting is not None:
            try:
                hosting_configured = media_hosting.configured()
            except Exception:
                hosting_configured = False
        messages = {
            "configured": "TikTok geliştirici bağlantısı güvenli kasaya kaydedildi.",
            "connected": "TikTok hesabı doğrulandı ve bağlandı.",
            "disconnected": "Hesap bağlantısı kaldırıldı; kampanya durduruldu.",
            "meta-configured": "Meta geliştirici bağlantısı güvenli kasaya kaydedildi.",
            "meta-connected": "Facebook Sayfası ve Instagram hesabı doğrulandı.",
            "meta-disconnected": "Facebook ve Instagram bağlantısı kaldırıldı; kampanya durduruldu.",
            "threads-configured": "Threads geliştirici bağlantısı güvenli kasaya kaydedildi.",
            "threads-connected": "Threads hesabı doğrulandı ve bağlandı.",
            "threads-disconnected": "Threads bağlantısı kaldırıldı; kampanya durduruldu.",
            "hosting-configured": "Medya barındırma güvenli kasaya kaydedildi.",
            "hosting-disconnected": "Medya barındırma kaldırıldı; kampanya durduruldu.",
        }
        errors = {
            "oauth": "TikTok bağlantısı tamamlanamadı. Lütfen yeniden deneyin.",
            "config": "TikTok geliştirici bilgileri kaydedilemedi.",
            "meta-oauth": "Meta bağlantısı tamamlanamadı. Hesap eşleşmesini ve izinleri kontrol edin.",
            "meta-config": "Meta geliştirici bilgileri kaydedilemedi.",
            "threads-oauth": "Threads bağlantısı tamamlanamadı. Lütfen yeniden deneyin.",
            "threads-config": "Threads geliştirici bilgileri kaydedilemedi.",
            "hosting-config": "Medya barındırma bilgileri kaydedilemedi.",
        }
        return TEMPLATES.TemplateResponse(request, "account_connections.html", {
            "csrf": csrf(request), "accounts": account_repository.list(),
            "tiktok_configured": configured, "meta_configured": meta_configured,
            "threads_configured": threads_configured,
            "hosting_configured": hosting_configured,
            "tiktok_callback_url": oauth_redirect_uri(request),
            "meta_callback_url": meta_redirect_uri(request),
            "threads_callback_url": threads_redirect_uri(request),
            "notice": messages.get(notice),
            "error": errors.get(error),
        })

    @router.post("/accounts/hosting/configure")
    async def configure_hosting(request: Request):
        form = await check_csrf(request)
        if media_hosting is None:
            return RedirectResponse("/accounts?error=hosting-config", status_code=303)
        try:
            media_hosting.configure(
                endpoint_url=str(form.get("endpoint_url", "")),
                bucket=str(form.get("bucket", "")),
                public_base_url=str(form.get("public_base_url", "")),
                access_key_id=str(form.get("access_key_id", "")),
                secret_access_key=str(form.get("secret_access_key", "")),
                region=str(form.get("region", "auto")),
            )
        except (ValueError, OSError):
            return RedirectResponse("/accounts?error=hosting-config", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=hosting-configured", status_code=303)

    @router.post("/accounts/hosting/disconnect")
    async def disconnect_hosting(request: Request):
        await check_csrf(request)
        if media_hosting is None:
            return RedirectResponse("/accounts?error=hosting-config", status_code=303)
        try:
            media_hosting.disconnect()
        except (ValueError, OSError):
            return RedirectResponse("/accounts?error=hosting-config", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=hosting-disconnected", status_code=303)

    @router.post("/accounts/tiktok/configure")
    async def configure_tiktok(request: Request):
        form = await check_csrf(request)
        if tiktok_connection is None:
            return RedirectResponse("/accounts?error=config", status_code=303)
        try:
            tiktok_connection.save_developer_credentials(
                str(form.get("client_key", "")), str(form.get("client_secret", "")),
            )
        except (ValueError, OSError):
            return RedirectResponse("/accounts?error=config", status_code=303)
        return RedirectResponse("/accounts?notice=configured", status_code=303)

    @router.post("/accounts/meta/configure")
    async def configure_meta(request: Request):
        form = await check_csrf(request)
        if meta_connection is None:
            return RedirectResponse("/accounts?error=meta-config", status_code=303)
        try:
            meta_connection.save_developer_credentials(
                str(form.get("app_id", "")), str(form.get("app_secret", "")),
            )
        except (ValueError, OSError):
            return RedirectResponse("/accounts?error=meta-config", status_code=303)
        return RedirectResponse("/accounts?notice=meta-configured", status_code=303)

    @router.post("/accounts/{locale}/meta/connect")
    async def connect_meta(request: Request, locale: str):
        await check_csrf(request)
        if meta_connection is None:
            return RedirectResponse("/accounts?error=meta-config", status_code=303)
        state = token_urlsafe(32)
        request.session["meta_oauth"] = {"locale": locale, "state": state}
        try:
            start = meta_connection.begin(
                locale, redirect_uri=meta_redirect_uri(request), state=state,
            )
        except (KeyError, ValueError, OSError):
            request.session.pop("meta_oauth", None)
            return RedirectResponse("/accounts?error=meta-oauth", status_code=303)
        return RedirectResponse(start.authorization_url, status_code=303)

    @router.get("/oauth/meta/callback", name="meta_callback")
    def meta_callback(request: Request, code: str | None = None,
                      state: str | None = None, error: str | None = None):
        pending = request.session.pop("meta_oauth", None)
        if (
            meta_connection is None or error or not code or not state or
            not pending or state != pending.get("state")
        ):
            return RedirectResponse("/accounts?error=meta-oauth", status_code=303)
        try:
            meta_connection.complete(
                pending["locale"], redirect_uri=meta_redirect_uri(request), code=code,
            )
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=meta-oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=meta-connected", status_code=303)

    @router.post("/accounts/{locale}/meta/disconnect")
    async def disconnect_meta(request: Request, locale: str):
        await check_csrf(request)
        try:
            if meta_connection is None:
                raise ValueError("Meta connection is unavailable")
            meta_connection.disconnect(locale)
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=meta-oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=meta-disconnected", status_code=303)

    @router.post("/accounts/threads/configure")
    async def configure_threads(request: Request):
        form = await check_csrf(request)
        if threads_connection is None:
            return RedirectResponse("/accounts?error=threads-config", status_code=303)
        try:
            threads_connection.save_developer_credentials(
                str(form.get("app_id", "")), str(form.get("app_secret", "")),
            )
        except (ValueError, OSError):
            return RedirectResponse("/accounts?error=threads-config", status_code=303)
        return RedirectResponse("/accounts?notice=threads-configured", status_code=303)

    @router.post("/accounts/{account_id}/threads/connect")
    async def connect_threads(request: Request, account_id: str):
        await check_csrf(request)
        if threads_connection is None:
            return RedirectResponse("/accounts?error=threads-config", status_code=303)
        state = token_urlsafe(32)
        request.session["threads_oauth"] = {"account_id": account_id, "state": state}
        try:
            start = threads_connection.begin(
                account_id, redirect_uri=threads_redirect_uri(request), state=state,
            )
        except (KeyError, ValueError, OSError):
            request.session.pop("threads_oauth", None)
            return RedirectResponse("/accounts?error=threads-oauth", status_code=303)
        return RedirectResponse(start.authorization_url, status_code=303)

    @router.get("/oauth/threads/callback", name="threads_callback")
    def threads_callback(request: Request, code: str | None = None,
                         state: str | None = None, error: str | None = None):
        pending = request.session.pop("threads_oauth", None)
        if (
            threads_connection is None or error or not code or not state or
            not pending or state != pending.get("state")
        ):
            return RedirectResponse("/accounts?error=threads-oauth", status_code=303)
        try:
            threads_connection.complete(
                pending["account_id"], redirect_uri=threads_redirect_uri(request), code=code,
            )
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=threads-oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=threads-connected", status_code=303)

    @router.post("/accounts/{account_id}/threads/disconnect")
    async def disconnect_threads(request: Request, account_id: str):
        await check_csrf(request)
        try:
            if threads_connection is None:
                raise ValueError("Threads connection is unavailable")
            threads_connection.disconnect(account_id)
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=threads-oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=threads-disconnected", status_code=303)

    @router.post("/accounts/{account_id}/tiktok/connect")
    async def connect_tiktok(request: Request, account_id: str):
        await check_csrf(request)
        if tiktok_connection is None:
            return RedirectResponse("/accounts?error=config", status_code=303)
        state = token_urlsafe(32)
        verifier = token_urlsafe(64)
        request.session["tiktok_oauth"] = {
            "account_id": account_id, "state": state, "verifier": verifier,
        }
        try:
            start = tiktok_connection.begin(
                account_id, redirect_uri=oauth_redirect_uri(request),
                state=state, verifier=verifier,
            )
        except (KeyError, ValueError, OSError):
            request.session.pop("tiktok_oauth", None)
            return RedirectResponse("/accounts?error=oauth", status_code=303)
        return RedirectResponse(start.authorization_url, status_code=303)

    @router.get("/oauth/tiktok/callback", name="tiktok_callback")
    def tiktok_callback(request: Request, code: str | None = None,
                        state: str | None = None, error: str | None = None):
        pending = request.session.pop("tiktok_oauth", None)
        if (
            tiktok_connection is None or error or not code or not state or
            not pending or state != pending.get("state")
        ):
            return RedirectResponse("/accounts?error=oauth", status_code=303)
        try:
            tiktok_connection.complete(
                pending["account_id"], redirect_uri=oauth_redirect_uri(request),
                code=code, verifier=pending["verifier"],
            )
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=connected", status_code=303)

    @router.post("/accounts/{account_id}/disconnect")
    async def disconnect_account(request: Request, account_id: str):
        await check_csrf(request)
        try:
            account = account_repository.get(account_id)
            if account["platform"] != "tiktok" or tiktok_connection is None:
                raise ValueError("Unsupported account provider")
            tiktok_connection.disconnect(account_id)
        except (KeyError, ValueError, OSError):
            return RedirectResponse("/accounts?error=oauth", status_code=303)
        scheduler.deactivate()
        return RedirectResponse("/accounts?notice=disconnected", status_code=303)

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
        missing_accounts = db.connection.execute(
            """SELECT COUNT(*) FROM account_connection
            WHERE enabled!=1 OR (
              public_identity IS NULL OR trim(public_identity)='' OR
              provider_identity IS NULL OR trim(provider_identity)='' OR
              vault_reference IS NULL OR trim(vault_reference)=''
            )"""
        ).fetchone()[0]
        if missing_accounts:
            issue = SimpleNamespace(
                code="missing_accounts",
                message=f"Kampanyayı etkinleştirmek için {missing_accounts} hesap bağlantısı eksik.",
            )
            return TEMPLATES.TemplateResponse(
                request, "media_import.html", media_context(request, issues=(issue,)), status_code=409,
            )
        try:
            hosting_ready = media_hosting is not None and media_hosting.configured()
        except (ValueError, OSError):
            hosting_ready = False
        if not hosting_ready:
            issue = SimpleNamespace(
                code="missing_hosting",
                message="Instagram yayını için Hesaplar bölümünde medya barındırma kurulmalı.",
            )
            return TEMPLATES.TemplateResponse(
                request, "media_import.html", media_context(request, issues=(issue,)), status_code=409,
            )
        jobs.schedule_reviewed_campaign(manifest.slug)
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
        raw_rows = db.connection.execute(
            """SELECT id,locale,platform,state,scheduled_at,remote_id,last_error FROM publication_job
            WHERE campaign_slug=? AND day=? ORDER BY locale,platform""", (manifest.slug, day),
        ).fetchall()
        rows = []
        for row in raw_rows:
            item = dict(row)
            zone_name = MARKET_SCHEDULES[LocaleCode(item["locale"])][0]
            local_time = datetime.fromisoformat(item["scheduled_at"]).astimezone(ZoneInfo(zone_name))
            item["scheduled_label"] = f"{local_time:%d.%m.%Y %H:%M} {zone_name}"
            rows.append(item)
        return TEMPLATES.TemplateResponse(request, "content_detail.html", {
            "csrf": csrf(request), "idea": idea, "jobs": rows,
            "state_labels": JOB_STATE_LABELS,
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
        form = await check_csrf(request)
        job = jobs.get(job_id)
        if job.campaign_slug != current_manifest().slug:
            raise HTTPException(404)
        if job.platform == Platform.TIKTOK and form.get("tiktok_consent") != "1":
            raise HTTPException(400, "TikTok upload requires explicit consent")
        orchestrator = current_orchestrator()
        if job.state == JobState.DRAFT:
            orchestrator.prepare(job_id)
        if jobs.get(job_id).state == JobState.NEEDS_REVIEW:
            if job.platform == Platform.TIKTOK:
                tiktok_state.record_consent(
                    job.id, job.content_revision, datetime.now(timezone.utc),
                )
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
