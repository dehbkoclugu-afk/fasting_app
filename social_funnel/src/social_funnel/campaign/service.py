"""Import and activate immutable monthly campaign revisions."""

from dataclasses import dataclass
from datetime import date
from hashlib import sha256
import json
from pathlib import Path
import shutil
from uuid import uuid4

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.campaign.package import CampaignPackage, load_campaign_package, validate_campaign_package
from social_funnel.domain.models import CampaignManifest
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRevisionRepository


@dataclass(frozen=True)
class CampaignPreflightResult:
    revision_id: str
    package: CampaignPackage


def _canonical(package: CampaignPackage) -> str:
    return json.dumps(package.model_dump(mode="json"), ensure_ascii=False, sort_keys=True,
                      separators=(",", ":"))


class CampaignRefreshService:
    def __init__(self, database: Database, workspace: Path):
        self.db = database
        self.workspace = Path(workspace)
        self.revisions = CampaignRevisionRepository(database)

    def preflight(self, source: Path) -> CampaignPreflightResult:
        package = load_campaign_package(source)
        validate_campaign_package(package)
        canonical = _canonical(package)
        checksum = sha256(canonical.encode("utf-8")).hexdigest()
        existing = self.revisions.find_by_checksum(checksum)
        if existing is not None:
            return CampaignPreflightResult(existing["id"], package)
        revision_id = f"campaign-{checksum[:16]}"
        root = self.workspace / "campaigns" / "imports"
        destination = root / revision_id
        temporary = root / f".incoming-{uuid4().hex}"
        try:
            temporary.mkdir(parents=True)
            (temporary / "campaign.json").write_text(canonical, encoding="utf-8")
            temporary.replace(destination)
            self.revisions.add(
                revision_id, package.month, package.manifest.slug, checksum,
                package.manifest.model_dump_json(), str(destination / "campaign.json"),
            )
        except Exception:
            shutil.rmtree(temporary, ignore_errors=True)
            shutil.rmtree(destination, ignore_errors=True)
            raise
        return CampaignPreflightResult(revision_id, package)

    def activate(self, revision_id: str, accounts: tuple[AccountConfig, ...]) -> None:
        revision = self.revisions.get(revision_id)
        manifest = CampaignManifest.model_validate_json(revision["manifest_json"])
        existing = self.db.connection.execute(
            "SELECT manifest_json FROM campaign WHERE slug=?", (manifest.slug,),
        ).fetchone()
        if existing is not None:
            stored = CampaignManifest.model_validate_json(existing[0])
            if stored != manifest:
                raise ValueError("Campaign slug already belongs to different content.")
        start_date = date.fromisoformat(f"{revision['target_month']}-01")
        jobs = expand_publication_jobs(manifest, accounts, start_date)
        current = self.db.connection.execute(
            "SELECT revision_id FROM active_campaign_revision WHERE singleton=1"
        ).fetchone()
        previous = current[0] if current and current[0] != revision_id else None
        with self.db.connection:
            self.db.connection.execute(
                "INSERT OR IGNORE INTO campaign(slug,title,timezone,manifest_json,created_at) VALUES(?,?,?,?,datetime('now'))",
                (manifest.slug, manifest.title, manifest.timezone, manifest.model_dump_json()),
            )
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
            self.db.connection.execute(
                "UPDATE application_state SET value='0' WHERE key='campaign_active'"
            )

    def rollback(self) -> bool:
        with self.db.connection:
            changed = self.revisions.rollback()
            if changed:
                self.db.connection.execute(
                    "UPDATE application_state SET value='0' WHERE key='campaign_active'"
                )
        return changed
