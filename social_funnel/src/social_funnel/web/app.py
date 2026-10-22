"""FastAPI app factory for the Windows-local workspace."""

from contextlib import asynccontextmanager
from dataclasses import dataclass
from datetime import date
from pathlib import Path
from secrets import token_urlsafe

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from starlette.middleware.sessions import SessionMiddleware

from social_funnel.auth.tiktok_connection import TikTokConnectionService
from social_funnel.auth.meta_connection import MetaConnectionService
from social_funnel.auth.threads_connection import ThreadsConnectionService
from social_funnel.auth.vault import CredentialVault
from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.campaign.registry import CampaignRegistry
from social_funnel.content.loader import load_campaign, validate_campaign_counts
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.hosting.connection import MediaHostingService
from social_funnel.media.resolver import MediaResolver
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.publishing.runtime import build_account_publishers
from social_funnel.setup.accounts import EXPECTED_PUBLIC_IDENTITIES
from social_funnel.scheduling.service import SchedulerService
from social_funnel.scheduling.runner import SchedulerRunner
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import (
    AccountConnectionRepository, CampaignRepository, JobRepository, MediaImportRepository,
)
from social_funnel.web.routes import make_router


@dataclass(frozen=True)
class WebSettings:
    workspace: Path
    catalog: Path
    start_date: date


def create_app(settings: WebSettings, *, tiktok_connection=None, meta_connection=None,
               threads_connection=None, media_hosting=None) -> FastAPI:
    manifest = load_campaign(settings.catalog)
    validate_campaign_counts(manifest)
    db = Database.open(settings.workspace / "campaign.db")
    CampaignRepository(db).import_manifest(manifest)
    accounts = tuple(AccountConfig(id=f"{locale.value}-{platform.value}", locale=locale,
                                   platform=platform, automation_mode=AutomationMode.APPROVAL)
                     for locale in LocaleCode for platform in Platform)
    jobs = JobRepository(db)
    jobs.import_jobs(expand_publication_jobs(manifest, accounts, settings.start_date))
    AccountConnectionRepository(db).seed_public_identities(EXPECTED_PUBLIC_IDENTITIES)
    @asynccontextmanager
    async def lifespan(application):
        application.state.scheduler_runner.start()
        try:
            yield
        finally:
            application.state.scheduler_runner.shutdown()

    app = FastAPI(title="FastTrack Social Funnel", lifespan=lifespan)
    app.add_middleware(SessionMiddleware, secret_key=token_urlsafe(32), same_site="strict")
    app.state.database = db
    app.state.registry = CampaignRegistry(db, manifest)
    app.state.manifest = app.state.registry.active_manifest()
    app.state.settings = settings
    app.state.media_imports = MediaImportRepository(db)
    vault = CredentialVault()
    app.state.tiktok_connection = tiktok_connection or TikTokConnectionService(db, vault)
    app.state.meta_connection = meta_connection or MetaConnectionService(db, vault)
    app.state.threads_connection = threads_connection or ThreadsConnectionService(db, vault)
    app.state.media_hosting = media_hosting or MediaHostingService(vault)

    def current_orchestrator() -> PublishingOrchestrator:
        campaign = app.state.registry.active_manifest()
        try:
            media_url = (
                app.state.media_hosting.url_for
                if app.state.media_hosting.configured() else None
            )
        except (ValueError, OSError):
            media_url = None
        publishers = build_account_publishers(
            db, campaign,
            meta_tokens=app.state.meta_connection,
            threads_tokens=app.state.threads_connection,
            tiktok_tokens=app.state.tiktok_connection,
            media_url=media_url,
        )
        return PublishingOrchestrator(
            jobs, campaign, publishers, settings.workspace / "media",
            media_resolver=MediaResolver(
                app.state.media_imports, campaign, settings.workspace / "media",
            ),
        )

    app.state.orchestrator_factory = current_orchestrator
    app.state.scheduler = SchedulerService(db, jobs, current_orchestrator)
    if app.state.scheduler.active:
        jobs.schedule_reviewed_campaign(app.state.registry.active_manifest().slug)
    app.state.scheduler_runner = SchedulerRunner(app.state.scheduler)
    app.include_router(make_router(
        db, jobs, manifest, settings.workspace, app.state.scheduler, registry=app.state.registry,
        tiktok_connection=app.state.tiktok_connection,
        meta_connection=app.state.meta_connection,
        threads_connection=app.state.threads_connection,
        media_hosting=app.state.media_hosting,
        orchestrator_factory=current_orchestrator,
    ))
    app.mount("/static", StaticFiles(directory=Path(__file__).with_name("static")), name="static")
    return app
