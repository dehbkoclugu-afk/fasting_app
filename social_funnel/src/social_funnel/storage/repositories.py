"""Small transactional repositories; secrets never enter this database."""

from datetime import datetime, timezone
import json

from social_funnel.domain.models import CampaignManifest, JobState, PublicationJob, can_transition
from social_funnel.storage.database import Database


class AccountConnectionRepository:
    def __init__(self, database: Database):
        self.db = database

    def get(self, account_id: str):
        row = self.db.connection.execute(
            "SELECT * FROM account_connection WHERE id=?", (account_id,),
        ).fetchone()
        if row is None:
            raise KeyError(account_id)
        return row

    def list(self) -> tuple:
        return tuple(self.db.connection.execute(
            "SELECT * FROM account_connection ORDER BY locale,platform"
        ).fetchall())

    def seed_public_identities(self, identities: dict[str, str]) -> None:
        with self.db.connection:
            for account_id, public_identity in identities.items():
                self.db.connection.execute(
                    """UPDATE account_connection SET
                    public_identity=COALESCE(public_identity,?),
                    enabled=CASE WHEN vault_reference IS NULL THEN 0 ELSE enabled END
                    WHERE id=?""",
                    (public_identity, account_id),
                )

    def mark_connected(self, account_id: str, *, provider_identity: str,
                       public_identity: str, vault_reference: str,
                       capabilities: dict) -> None:
        self.get(account_id)
        with self.db.connection:
            self.db.connection.execute(
                """UPDATE account_connection SET provider_identity=?,public_identity=?,
                vault_reference=?,capabilities_json=?,enabled=1,last_verified_at=? WHERE id=?""",
                (provider_identity, public_identity, vault_reference,
                 json.dumps(capabilities, sort_keys=True, separators=(",", ":")),
                 datetime.now(timezone.utc).isoformat(), account_id),
            )

    def disconnect(self, account_id: str) -> None:
        self.get(account_id)
        with self.db.connection:
            self.db.connection.execute(
                """UPDATE account_connection SET provider_identity=NULL,vault_reference=NULL,
                capabilities_json='{}',enabled=0,last_verified_at=NULL WHERE id=?""",
                (account_id,),
            )


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


class CampaignRevisionRepository:
    def __init__(self, database: Database):
        self.db = database

    def add(self, revision_id: str, month: str, campaign_slug: str, checksum: str,
            manifest_json: str, managed_path: str) -> None:
        with self.db.connection:
            self.db.connection.execute(
                """INSERT OR IGNORE INTO campaign_revision
                (id,target_month,campaign_slug,checksum,manifest_json,managed_path,created_at)
                VALUES(?,?,?,?,?,?,?)""",
                (revision_id, month, campaign_slug, checksum, manifest_json, managed_path,
                 datetime.now(timezone.utc).isoformat()),
            )

    def get(self, revision_id: str):
        row = self.db.connection.execute(
            "SELECT * FROM campaign_revision WHERE id=?", (revision_id,),
        ).fetchone()
        if row is None:
            raise KeyError(revision_id)
        return row

    def find_by_checksum(self, checksum: str):
        return self.db.connection.execute(
            "SELECT * FROM campaign_revision WHERE checksum=?", (checksum,),
        ).fetchone()

    def list(self) -> tuple:
        return tuple(self.db.connection.execute(
            "SELECT * FROM campaign_revision ORDER BY created_at DESC",
        ).fetchall())

    def activate(self, revision_id: str) -> None:
        self.get(revision_id)
        current = self.db.connection.execute(
            "SELECT revision_id FROM active_campaign_revision WHERE singleton=1"
        ).fetchone()
        previous = current[0] if current and current[0] != revision_id else None
        with self.db.connection:
            self.db.connection.execute(
                """INSERT INTO active_campaign_revision(singleton,revision_id,previous_revision_id)
                VALUES(1,?,?) ON CONFLICT(singleton) DO UPDATE SET
                previous_revision_id=CASE
                  WHEN active_campaign_revision.revision_id!=excluded.revision_id
                  THEN active_campaign_revision.revision_id
                  ELSE active_campaign_revision.previous_revision_id END,
                revision_id=excluded.revision_id""",
                (revision_id, previous),
            )

    def active(self):
        return self.db.connection.execute(
            """SELECT r.* FROM active_campaign_revision a
            JOIN campaign_revision r ON r.id=a.revision_id WHERE a.singleton=1"""
        ).fetchone()

    def rollback(self) -> bool:
        row = self.db.connection.execute(
            "SELECT revision_id,previous_revision_id FROM active_campaign_revision WHERE singleton=1"
        ).fetchone()
        if row is None or row["previous_revision_id"] is None:
            return False
        with self.db.connection:
            self.db.connection.execute(
                """UPDATE active_campaign_revision SET revision_id=?,previous_revision_id=?
                WHERE singleton=1""",
                (row["previous_revision_id"], row["revision_id"]),
            )
        return True


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

    def list_inflight(self) -> tuple[PublicationJob, ...]:
        rows = self.db.connection.execute(
            "SELECT * FROM publication_job WHERE state IN ('uploading','processing')",
        ).fetchall()
        return tuple(PublicationJob.model_validate(dict(row)) for row in rows)


class MediaImportRepository:
    def __init__(self, database: Database):
        self.db = database

    def create_batch(self, batch_id: str, campaign_slug: str, archive_checksum: str) -> None:
        with self.db.connection:
            self.db.connection.execute(
                "INSERT OR IGNORE INTO media_import_batch(id,campaign_slug,archive_checksum,created_at) VALUES(?,?,?,?)",
                (batch_id, campaign_slug, archive_checksum, datetime.now(timezone.utc).isoformat()),
            )

    def find_by_checksum(self, campaign_slug: str, archive_checksum: str):
        return self.db.connection.execute(
            "SELECT * FROM media_import_batch WHERE campaign_slug=? AND archive_checksum=?",
            (campaign_slug, archive_checksum),
        ).fetchone()

    def list_batches(self, campaign_slug: str) -> tuple:
        return tuple(self.db.connection.execute(
            "SELECT * FROM media_import_batch WHERE campaign_slug=? ORDER BY created_at DESC", (campaign_slug,),
        ).fetchall())

    def get_batch(self, batch_id: str):
        return self.db.connection.execute("SELECT * FROM media_import_batch WHERE id=?", (batch_id,)).fetchone()

    def add_file(self, batch_id: str, *, day: int, locale: str, kind: str, position: int,
                 managed_path: str, checksum: str, width: int, height: int,
                 duration_ms: int | None, mime_type: str) -> None:
        with self.db.connection:
            self.db.connection.execute(
                """INSERT OR IGNORE INTO media_import_file
                (batch_id,day,locale,kind,position,managed_path,checksum,width,height,duration_ms,mime_type)
                VALUES(?,?,?,?,?,?,?,?,?,?,?)""",
                (batch_id, day, locale, kind, position, managed_path, checksum,
                 width, height, duration_ms, mime_type),
            )

    def activate(self, campaign_slug: str, batch_id: str) -> None:
        batch = self.db.connection.execute(
            "SELECT id FROM media_import_batch WHERE id=? AND campaign_slug=?", (batch_id, campaign_slug),
        ).fetchone()
        if batch is None:
            raise KeyError(batch_id)
        current = self.db.connection.execute(
            "SELECT batch_id FROM active_media_batch WHERE campaign_slug=?", (campaign_slug,),
        ).fetchone()
        previous = current[0] if current and current[0] != batch_id else None
        with self.db.connection:
            self.db.connection.execute(
                """INSERT INTO active_media_batch(campaign_slug,batch_id,previous_batch_id) VALUES(?,?,?)
                ON CONFLICT(campaign_slug) DO UPDATE SET
                previous_batch_id=CASE WHEN active_media_batch.batch_id!=excluded.batch_id THEN active_media_batch.batch_id ELSE active_media_batch.previous_batch_id END,
                batch_id=excluded.batch_id""",
                (campaign_slug, batch_id, previous),
            )

    def active_batch(self, campaign_slug: str):
        return self.db.connection.execute(
            """SELECT b.* FROM active_media_batch a JOIN media_import_batch b ON b.id=a.batch_id
            WHERE a.campaign_slug=?""", (campaign_slug,),
        ).fetchone()

    def active_files(self, campaign_slug: str) -> tuple:
        return tuple(self.db.connection.execute(
            """SELECT f.* FROM active_media_batch a JOIN media_import_file f ON f.batch_id=a.batch_id
            WHERE a.campaign_slug=? ORDER BY f.day,f.locale,f.kind,f.position""", (campaign_slug,),
        ).fetchall())

    def active_slot_files(self, campaign_slug: str, day: int, locale: str) -> tuple:
        return tuple(self.db.connection.execute(
            """SELECT f.* FROM active_media_batch a JOIN media_import_file f ON f.batch_id=a.batch_id
            WHERE a.campaign_slug=? AND f.day=? AND f.locale=? ORDER BY f.position""",
            (campaign_slug, day, locale),
        ).fetchall())

    def batch_files(self, batch_id: str) -> tuple:
        return tuple(self.db.connection.execute(
            "SELECT * FROM media_import_file WHERE batch_id=? ORDER BY day,locale,kind,position", (batch_id,),
        ).fetchall())

    def get_file(self, campaign_slug: str, file_id: int):
        return self.db.connection.execute(
            """SELECT f.* FROM media_import_file f
            JOIN media_import_batch b ON b.id=f.batch_id
            WHERE f.id=? AND b.campaign_slug=?""",
            (file_id, campaign_slug),
        ).fetchone()

    def rollback(self, campaign_slug: str) -> bool:
        row = self.db.connection.execute(
            "SELECT batch_id,previous_batch_id FROM active_media_batch WHERE campaign_slug=?", (campaign_slug,),
        ).fetchone()
        if row is None or row["previous_batch_id"] is None:
            return False
        with self.db.connection:
            self.db.connection.execute(
                "UPDATE active_media_batch SET batch_id=?,previous_batch_id=? WHERE campaign_slug=?",
                (row["previous_batch_id"], row["batch_id"], campaign_slug),
            )
        return True
