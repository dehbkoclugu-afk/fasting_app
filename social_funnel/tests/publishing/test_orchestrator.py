from datetime import date, datetime, timezone
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, Platform, PublishResult
from social_funnel.publishing.orchestrator import PublishingOrchestrator
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


class FakePublisher:
    def __init__(self, result=None, existing=None):
        self.result = result or PublishResult(remote_id="remote-1", status="published")
        self.existing = existing
        self.calls = 0
        self.lookups = 0

    def lookup_by_idempotency_key(self, key):
        self.lookups += 1
        return self.existing

    def publish(self, job, asset_path):
        self.calls += 1
        return self.result


def setup(tmp_path, mode=AutomationMode.APPROVAL):
    db = Database.open(tmp_path / "queue.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    expanded = expand_publication_jobs(manifest, (AccountConfig("tr-instagram", LocaleCode.TR, Platform.INSTAGRAM, mode),), date(2026, 10, 20))
    job = next(item for item in expanded if item.day == 18)
    repository = JobRepository(db)
    repository.import_jobs((job,))
    return db, repository, manifest, job


def test_approval_mode_never_publishes_unapproved(tmp_path):
    db, repository, manifest, job = setup(tmp_path)
    publisher = FakePublisher()
    engine = PublishingOrchestrator(repository, manifest, {Platform.INSTAGRAM: publisher}, tmp_path / "media")
    assert not engine.process(job.id)
    assert publisher.calls == 0
    assert engine.prepare(job.id)
    assert repository.get(job.id).state == JobState.NEEDS_REVIEW
    assert engine.approve(job.id)
    assert engine.process(job.id)
    assert repository.get(job.id).state == JobState.PUBLISHED
    assert publisher.calls == 1
    db.close()


def test_automatic_mode_validates_and_reconciles_before_retry(tmp_path):
    db, repository, manifest, job = setup(tmp_path, AutomationMode.AUTOMATIC)
    publisher = FakePublisher(existing=PublishResult(remote_id="already-there", status="published"))
    engine = PublishingOrchestrator(repository, manifest, {Platform.INSTAGRAM: publisher}, tmp_path / "media", campaign_locked=True)
    assert engine.prepare(job.id)
    assert repository.get(job.id).state == JobState.SCHEDULED
    assert engine.process(job.id)
    assert publisher.lookups == 1
    assert publisher.calls == 0
    assert repository.get(job.id).remote_id == "already-there"
    db.close()


def test_retryable_failure_backoff_and_auth_error_no_retry(tmp_path):
    db, repository, manifest, job = setup(tmp_path, AutomationMode.AUTOMATIC)
    publisher = FakePublisher(PublishResult(status="rate_limit", retryable=True, message="try later"))
    engine = PublishingOrchestrator(repository, manifest, {Platform.INSTAGRAM: publisher}, tmp_path / "media", campaign_locked=True)
    engine.prepare(job.id)
    assert not engine.process(job.id)
    assert repository.get(job.id).state == JobState.SCHEDULED
    assert repository.get(job.id).next_attempt_at > datetime.now(timezone.utc)
    publisher.result = PublishResult(status="auth_error", retryable=False, message="reconnect")
    repository.set_result(job.id)
    assert not engine.process(job.id)
    assert repository.get(job.id).state == JobState.FAILED
    db.close()


def test_tiktok_review_upload_is_not_mistaken_for_public_post(tmp_path):
    db, repository, manifest, job = setup(tmp_path, AutomationMode.AUTOMATIC)
    publisher = FakePublisher(PublishResult(remote_id="publish-id", status="awaiting_creator_review"))
    engine = PublishingOrchestrator(repository, manifest, {Platform.INSTAGRAM: publisher}, tmp_path / "media", campaign_locked=True)
    engine.prepare(job.id)
    assert engine.process(job.id)
    assert repository.get(job.id).state == JobState.PROCESSING
    assert repository.get(job.id).remote_id == "publish-id"
    db.close()


def test_exact_account_publisher_wins_over_platform_fallback(tmp_path):
    db, repository, manifest, job = setup(tmp_path, AutomationMode.AUTOMATIC)
    exact = FakePublisher()
    wrong_locale = FakePublisher()
    engine = PublishingOrchestrator(
        repository, manifest,
        {job.account_id: exact, Platform.INSTAGRAM: wrong_locale},
        tmp_path / "media", campaign_locked=True,
    )

    engine.prepare(job.id)
    assert engine.process(job.id)
    assert exact.calls == 1
    assert wrong_locale.calls == 0
    db.close()
