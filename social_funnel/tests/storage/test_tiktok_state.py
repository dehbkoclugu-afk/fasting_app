from datetime import date, datetime, timezone
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import LocaleCode, Platform
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository, TikTokStateRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def test_tiktok_consent_and_submission_survive_repository_recreation(tmp_path):
    database = Database.open(tmp_path / "state.db")
    campaign = load_campaign(CATALOG)
    CampaignRepository(database).import_manifest(campaign)
    job = expand_publication_jobs(
        campaign,
        (AccountConfig("en-tiktok", LocaleCode.EN, Platform.TIKTOK),),
        date(2026, 10, 20),
    )[0]
    JobRepository(database).import_jobs((job,))
    consented_at = datetime(2026, 10, 22, 12, 0, tzinfo=timezone.utc)
    state = TikTokStateRepository(database)

    state.record_consent(job.id, job.content_revision, consented_at)
    state.record_submission(job.idempotency_key, "publish-123", direct=False)

    reopened = TikTokStateRepository(database)
    assert reopened.has_consent(job.id, job.content_revision)
    assert not reopened.has_consent(job.id, job.content_revision + 1)
    submission = reopened.get_submission(job.idempotency_key)
    assert submission["publish_id"] == "publish-123"
    assert submission["direct"] == 0
    database.close()
