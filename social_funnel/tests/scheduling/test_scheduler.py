from datetime import date, datetime, timezone
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, Platform
from social_funnel.scheduling.service import SchedulerService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


class FakeEngine:
    def __init__(self):
        self.processed = []

    def process(self, job_id):
        self.processed.append(job_id)
        if hasattr(self, "on_process"):
            self.on_process()
        return True


def test_pause_prevents_next_job_without_interrupting_current(tmp_path):
    db = Database.open(tmp_path / "queue.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    jobs = expand_publication_jobs(manifest, (
        AccountConfig("tr-instagram", LocaleCode.TR, Platform.INSTAGRAM, AutomationMode.AUTOMATIC),
        AccountConfig("tr-facebook", LocaleCode.TR, Platform.FACEBOOK, AutomationMode.AUTOMATIC),
    ), date(2026, 10, 20))[:2]
    repository = JobRepository(db)
    repository.import_jobs(jobs)
    for job in jobs:
        repository.transition(job.id, JobState.DRAFT, JobState.NEEDS_REVIEW)
        repository.transition(job.id, JobState.NEEDS_REVIEW, JobState.APPROVED)
        repository.transition(job.id, JobState.APPROVED, JobState.SCHEDULED)
    engine = FakeEngine()
    scheduler = SchedulerService(db, repository, engine)
    scheduler.pause()
    assert scheduler.tick(datetime(2026, 10, 20, 9, tzinfo=timezone.utc)) == 0
    scheduler.resume()
    assert scheduler.tick(datetime(2026, 10, 20, 9, tzinfo=timezone.utc)) == 0
    scheduler.activate()
    assert scheduler.tick(datetime(2026, 10, 20, 9, tzinfo=timezone.utc)) == 2
    assert len(engine.processed) == 2
    db.close()


def test_pause_during_first_job_stops_next_claim(tmp_path):
    db = Database.open(tmp_path / "queue.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    accounts = (AccountConfig("tr-ig", LocaleCode.TR, Platform.INSTAGRAM),
                AccountConfig("tr-fb", LocaleCode.TR, Platform.FACEBOOK))
    jobs = expand_publication_jobs(manifest, accounts, date(2026, 10, 20))[:2]
    repository = JobRepository(db)
    repository.import_jobs(jobs)
    for job in jobs:
        repository.transition(job.id, JobState.DRAFT, JobState.NEEDS_REVIEW)
        repository.transition(job.id, JobState.NEEDS_REVIEW, JobState.APPROVED)
        repository.transition(job.id, JobState.APPROVED, JobState.SCHEDULED)
    engine = FakeEngine()
    scheduler = SchedulerService(db, repository, engine)
    scheduler.activate()
    engine.on_process = scheduler.pause
    assert scheduler.tick(datetime(2026, 10, 20, 9, tzinfo=timezone.utc)) == 1
    assert len(engine.processed) == 1
    db.close()


def test_campaign_activation_persists_and_pause_still_wins(tmp_path):
    db = Database.open(tmp_path / "queue.db")
    scheduler = SchedulerService(db, JobRepository(db), FakeEngine())
    assert not scheduler.active
    scheduler.activate()
    assert SchedulerService(db, JobRepository(db), FakeEngine()).active
    scheduler.pause()
    assert scheduler.active and scheduler.paused
    scheduler.deactivate()
    assert not scheduler.active
