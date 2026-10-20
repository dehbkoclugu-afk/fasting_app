from datetime import date, datetime, timezone
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, Platform
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def test_sqlite_import_is_idempotent_and_unicode_safe(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    assert db.connection.execute("PRAGMA foreign_keys").fetchone()[0] == 1
    manifest = load_campaign(CATALOG)
    accounts = tuple(AccountConfig(id=f"{loc.value}-{platform.value}", locale=loc,
                                   platform=platform, automation_mode=AutomationMode.APPROVAL)
                     for loc in LocaleCode for platform in Platform)
    jobs = expand_publication_jobs(manifest, accounts, date(2026, 10, 20))
    campaigns = CampaignRepository(db)
    repository = JobRepository(db)
    campaigns.import_manifest(manifest)
    repository.import_jobs(jobs)
    repository.import_jobs(jobs)
    assert repository.count() == 360
    assert repository.get(jobs[0].id).idempotency_key == jobs[0].idempotency_key
    assert "İlk haftanı sakin başlat" in campaigns.get_manifest(manifest.slug).ideas[0].localized[0].hook
    assert "Comece sua rotina com calma" in campaigns.get_manifest(manifest.slug).ideas[0].localized[2].hook
    assert not any("token" in row[1].lower() or "password" in row[1].lower()
                   for table in ("campaign", "publication_job", "publication_attempt")
                   for row in db.connection.execute(f"PRAGMA table_info({table})"))
    db.close()


def test_transition_is_compare_and_swap_and_due_query(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    job = expand_publication_jobs(manifest, (AccountConfig(id="tr-instagram", locale=LocaleCode.TR,
                     platform=Platform.INSTAGRAM, automation_mode=AutomationMode.APPROVAL),), date(2026, 10, 20))[0]
    repository = JobRepository(db)
    repository.import_jobs((job,))
    assert repository.transition(job.id, JobState.DRAFT, JobState.NEEDS_REVIEW)
    assert not repository.transition(job.id, JobState.DRAFT, JobState.APPROVED)
    assert repository.transition(job.id, JobState.NEEDS_REVIEW, JobState.APPROVED)
    assert repository.transition(job.id, JobState.APPROVED, JobState.SCHEDULED)
    assert repository.get_due_jobs(datetime(2026, 10, 20, 9, tzinfo=timezone.utc), 5)[0].id == job.id
    repository.record_attempt(job.id, "temporary_error", None, "network timeout", 1)
    assert repository.attempt_count(job.id) == 1
    db.close()
