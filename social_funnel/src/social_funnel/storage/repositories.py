"""Small transactional repositories; secrets never enter this database."""

from datetime import datetime, timezone

from social_funnel.domain.models import CampaignManifest, JobState, PublicationJob, can_transition
from social_funnel.storage.database import Database


class CampaignRepository:
    def __init__(self, database: Database):
        self.db = database

    def import_manifest(self, manifest: CampaignManifest) -> None:
        with self.db.connection:
            self.db.connection.execute(
                "INSERT OR IGNORE INTO campaign(slug,title,timezone,manifest_json,created_at) VALUES(?,?,?,?,?)",
                (manifest.slug, manifest.title, manifest.timezone,
                 manifest.model_dump_json(), datetime.now(timezone.utc).isoformat()),
            )

    def get_manifest(self, slug: str) -> CampaignManifest:
        row = self.db.connection.execute("SELECT manifest_json FROM campaign WHERE slug=?", (slug,)).fetchone()
        if row is None:
            raise KeyError(slug)
        return CampaignManifest.model_validate_json(row[0])


class JobRepository:
    def __init__(self, database: Database):
        self.db = database

    def import_jobs(self, jobs: tuple[PublicationJob, ...]) -> None:
        with self.db.connection:
            for job in jobs:
                self.db.connection.execute(
                    "INSERT OR IGNORE INTO account_connection(id,platform,locale) VALUES(?,?,?)",
                    (job.account_id, job.platform.value, job.locale.value),
                )
                self.db.connection.execute(
                    """INSERT OR IGNORE INTO publication_job
                    (id,campaign_slug,day,locale,platform,account_id,automation_mode,state,
                     scheduled_at,idempotency_key,content_revision)
                    VALUES(?,?,?,?,?,?,?,?,?,?,?)""",
                    (job.id, job.campaign_slug, job.day, job.locale.value, job.platform.value,
                     job.account_id, job.automation_mode.value, job.state.value,
                     job.scheduled_at.isoformat(), job.idempotency_key, job.content_revision),
                )

    def count(self) -> int:
        return self.db.connection.execute("SELECT COUNT(*) FROM publication_job").fetchone()[0]

    def get(self, job_id: str) -> PublicationJob:
        row = self.db.connection.execute("SELECT * FROM publication_job WHERE id=?", (job_id,)).fetchone()
        if row is None:
            raise KeyError(job_id)
        return PublicationJob.model_validate(dict(row))

    def get_due_jobs(self, now: datetime, limit: int) -> tuple[PublicationJob, ...]:
        rows = self.db.connection.execute(
            """SELECT * FROM publication_job WHERE state='scheduled'
            AND scheduled_at<=? AND (next_attempt_at IS NULL OR next_attempt_at<=?)
            ORDER BY scheduled_at, id LIMIT ?""",
            (now.isoformat(), now.isoformat(), limit),
        ).fetchall()
        return tuple(PublicationJob.model_validate(dict(row)) for row in rows)

    def transition(self, job_id: str, expected_state: JobState, new_state: JobState) -> bool:
        if not can_transition(expected_state, new_state):
            return False
        with self.db.connection:
            cursor = self.db.connection.execute(
                "UPDATE publication_job SET state=? WHERE id=? AND state=?",
                (new_state.value, job_id, expected_state.value),
            )
        return cursor.rowcount == 1

    def set_result(self, job_id: str, *, remote_id: str | None = None,
                   next_attempt_at: datetime | None = None, error: str | None = None) -> None:
        with self.db.connection:
            self.db.connection.execute(
                "UPDATE publication_job SET remote_id=?,next_attempt_at=?,last_error=? WHERE id=?",
                (remote_id, next_attempt_at.isoformat() if next_attempt_at else None, error, job_id),
            )

    def record_attempt(self, job_id: str, outcome: str, remote_id: str | None,
                       diagnostic: str, retry_count: int) -> None:
        with self.db.connection:
            self.db.connection.execute(
                """INSERT INTO publication_attempt
                (job_id,attempted_at,outcome,remote_id,diagnostic,retry_count) VALUES(?,?,?,?,?,?)""",
                (job_id, datetime.now(timezone.utc).isoformat(), outcome, remote_id,
                 diagnostic[:500], retry_count),
            )

    def attempt_count(self, job_id: str) -> int:
        return self.db.connection.execute(
            "SELECT COUNT(*) FROM publication_attempt WHERE job_id=?", (job_id,),
        ).fetchone()[0]
