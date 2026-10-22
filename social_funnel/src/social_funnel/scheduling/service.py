"""Single-process queue tick and durable global pause."""

from datetime import datetime

from social_funnel.storage.database import Database
from social_funnel.storage.repositories import JobRepository


class SchedulerService:
    def __init__(self, database: Database, jobs: JobRepository, orchestrator):
        self.db = database
        self.jobs = jobs
        self.orchestrator = orchestrator

    @property
    def paused(self) -> bool:
        return self.db.connection.execute("SELECT value FROM application_state WHERE key='paused'").fetchone()[0] == "1"

    @property
    def active(self) -> bool:
        return self.db.connection.execute(
            "SELECT value FROM application_state WHERE key='campaign_active'"
        ).fetchone()[0] == "1"

    def pause(self) -> None:
        with self.db.connection:
            self.db.connection.execute("UPDATE application_state SET value='1' WHERE key='paused'")

    def resume(self) -> None:
        with self.db.connection:
            self.db.connection.execute("UPDATE application_state SET value='0' WHERE key='paused'")

    def activate(self) -> None:
        with self.db.connection:
            self.db.connection.execute("UPDATE application_state SET value='1' WHERE key='campaign_active'")

    def deactivate(self) -> None:
        with self.db.connection:
            self.db.connection.execute("UPDATE application_state SET value='0' WHERE key='campaign_active'")

    def tick(self, now: datetime, limit: int = 12) -> int:
        if not self.active:
            return 0
        completed = 0
        for job in self.jobs.get_due_jobs(now, limit):
            if self.paused:
                break
            self.orchestrator.process(job.id)
            completed += 1
        return completed
