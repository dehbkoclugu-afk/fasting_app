"""Create an idempotent local workspace from the reviewed campaign catalog."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date
from pathlib import Path
import json
import sys

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign, validate_campaign_counts
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.setup.accounts import EXPECTED_PUBLIC_IDENTITIES
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository, CampaignRepository, JobRepository


@dataclass(frozen=True)
class SetupSummary:
    workspace: Path
    idea_count: int
    localized_count: int
    account_count: int
    job_count: int


def default_catalog() -> Path:
    if getattr(sys, "frozen", False):
        return Path(sys._MEIPASS) / "content" / "fasttrack-30-day-launch.json"
    return Path(__file__).resolve().parents[3] / "content" / "fasttrack-30-day-launch.json"


def _accounts() -> tuple[AccountConfig, ...]:
    return tuple(
        AccountConfig(
            id=f"{locale.value}-{platform.value}",
            locale=locale,
            platform=platform,
            automation_mode=AutomationMode.APPROVAL,
        )
        for locale in LocaleCode
        for platform in Platform
    )


def initialize_workspace(
    path: Path,
    *,
    catalog: Path | None = None,
    start_date: date | None = None,
) -> SetupSummary:
    """Initialize campaign storage without duplicating data on later launches."""
    workspace = Path(path)
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "media").mkdir(exist_ok=True)
    (workspace / "exports").mkdir(exist_ok=True)
    config_dir = workspace / "config"
    config_dir.mkdir(exist_ok=True)

    catalog = Path(catalog) if catalog is not None else default_catalog()
    manifest = load_campaign(catalog)
    validate_campaign_counts(manifest)
    launch_date = start_date or date.today()
    accounts = _accounts()
    expanded = expand_publication_jobs(manifest, accounts, launch_date)

    database = Database.open(workspace / "campaign.db")
    try:
        CampaignRepository(database).import_manifest(manifest)
        jobs = JobRepository(database)
        jobs.import_jobs(expanded)
        AccountConnectionRepository(database).seed_public_identities(EXPECTED_PUBLIC_IDENTITIES)
        job_count = jobs.count()
        account_count = database.connection.execute(
            "SELECT COUNT(*) FROM account_connection"
        ).fetchone()[0]
    finally:
        database.close()

    settings_path = config_dir / "settings.json"
    if not settings_path.exists():
        settings_path.write_text(
            json.dumps(
                {
                    "backup_format_version": 1,
                    "campaign": manifest.slug,
                    "start_date": launch_date.isoformat(),
                },
                ensure_ascii=False,
                indent=2,
                sort_keys=True,
            ),
            encoding="utf-8",
        )

    return SetupSummary(
        workspace=workspace,
        idea_count=len(manifest.ideas),
        localized_count=sum(len(idea.localized) for idea in manifest.ideas),
        account_count=account_count,
        job_count=job_count,
    )
