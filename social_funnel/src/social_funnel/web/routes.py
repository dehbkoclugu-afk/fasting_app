"""Review actions protected by a session CSRF token."""

from pathlib import Path
from secrets import token_urlsafe
from urllib.parse import parse_qs

from fastapi import APIRouter, HTTPException, Request
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.templating import Jinja2Templates

from social_funnel.domain.models import CampaignManifest, JobState
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.scheduling.service import SchedulerService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import JobRepository


TEMPLATES = Jinja2Templates(directory=Path(__file__).with_name("templates"))


def make_router(db: Database, jobs: JobRepository, manifest: CampaignManifest, workspace: Path) -> APIRouter:
    router = APIRouter()
    scheduler = SchedulerService(db, jobs, None)
    orchestrator = PublishingOrchestrator(jobs, manifest, {}, workspace / "media")

    def csrf(request: Request) -> str:
        if "csrf" not in request.session:
            request.session["csrf"] = token_urlsafe(24)
        return request.session["csrf"]

    async def check_csrf(request: Request) -> dict[str, str]:
        body = parse_qs((await request.body()).decode("utf-8"), keep_blank_values=True)
        values = {key: value[0] for key, value in body.items()}
        if not request.session.get("csrf") or values.get("csrf") != request.session["csrf"]:
            raise HTTPException(403, "Invalid CSRF token")
        return values

    @router.get("/", response_class=HTMLResponse)
    def dashboard(request: Request):
        rows = db.connection.execute("SELECT state,COUNT(*) AS n FROM publication_job GROUP BY state").fetchall()
        counts = {row["state"]: row["n"] for row in rows}
        accounts = db.connection.execute("SELECT id,platform,locale,public_identity FROM account_connection ORDER BY locale,platform").fetchall()
        return TEMPLATES.TemplateResponse(request, "dashboard.html", {
            "csrf": csrf(request), "counts": counts, "total": jobs.count(),
            "accounts": accounts, "paused": scheduler.paused, "ideas": manifest.ideas,
        })

    @router.get("/health")
    def health():
        return {"status": "ok", "jobs": jobs.count(), "paused": scheduler.paused}

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
        ids = tuple(row[0] for row in db.connection.execute("SELECT id FROM publication_job WHERE day=? AND state!='disabled'", (day,)))
        export_manual_pack(ids, workspace / "exports" / f"day-{day:02d}.zip", jobs, manifest, workspace / "media")
        return RedirectResponse(f"/days/{day}", status_code=303)

    return router
