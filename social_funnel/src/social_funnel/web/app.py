"""FastAPI app factory for the Windows-local workspace."""

from dataclasses import dataclass
from datetime import date
from pathlib import Path
from secrets import token_urlsafe

from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from starlette.middleware.sessions import SessionMiddleware

from social_funnel.auth.tiktok_connection import TikTokConnectionService
from social_funnel.auth.vault import CredentialVault
from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.campaign.registry import CampaignRegistry
from social_funnel.content.loader import load_campaign, validate_campaign_counts
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.setup.accounts import EXPECTED_PUBLIC_IDENTITIES
from social_funnel.scheduling.service import SchedulerService
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


def create_app(settings: WebSettings, *, tiktok_connection=None) -> FastAPI:
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
    app = FastAPI(title="FastTrack Social Funnel")
    app.add_middleware(SessionMiddleware, secret_key=token_urlsafe(32), same_site="strict")
    app.state.database = db
    app.state.registry = CampaignRegistry(db, manifest)
    app.state.manifest = app.state.registry.active_manifest()
    app.state.settings = settings
    app.state.media_imports = MediaImportRepository(db)
    app.state.scheduler = SchedulerService(db, jobs, None)
    app.state.tiktok_connection = tiktok_connection or TikTokConnectionService(
        db, CredentialVault(),
    )
    app.include_router(make_router(
        db, jobs, manifest, settings.workspace, app.state.scheduler, registry=app.state.registry,
        tiktok_connection=app.state.tiktok_connection,
    ))
    app.mount("/static", StaticFiles(directory=Path(__file__).with_name("static")), name="static")
    return app
