import json
from pathlib import Path

import pytest

from social_funnel.campaign.expansion import AccountConfig
from social_funnel.campaign.service import CampaignRefreshService
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRevisionRepository, JobRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def package_file(tmp_path: Path, month: str = "2026-11", *, suffix: str = "", indent=None) -> Path:
    manifest = json.loads(CATALOG.read_text(encoding="utf-8"))
    manifest["slug"] = f"fasttrack{suffix}-{month}"
    data = {"month": month, "manifest": manifest}
    path = tmp_path / f"campaign{suffix or '-one'}.json"
    path.write_text(json.dumps(data, ensure_ascii=False, indent=indent), encoding="utf-8")
    return path


def accounts() -> tuple[AccountConfig, ...]:
    return tuple(
        AccountConfig(id=f"{locale.value}-{platform.value}", locale=locale, platform=platform,
                      automation_mode=AutomationMode.APPROVAL)
        for locale in LocaleCode for platform in Platform
    )


def service(tmp_path: Path):
    db = Database.open(tmp_path / "campaign.db")
    return db, CampaignRefreshService(db, tmp_path / "workspace")


def test_preflight_is_immutable_and_semantically_idempotent(tmp_path: Path) -> None:
    db, refresh = service(tmp_path)
    first = refresh.preflight(package_file(tmp_path, indent=None))
    second = refresh.preflight(package_file(tmp_path, indent=2))
    assert first.revision_id == second.revision_id
    assert len(CampaignRevisionRepository(db).list()) == 1
    managed = Path(CampaignRevisionRepository(db).get(first.revision_id)["managed_path"])
    assert managed.is_file()
    assert managed.parent.name == first.revision_id


def test_activation_creates_jobs_persists_and_deactivates_publishing(tmp_path: Path) -> None:
    db, refresh = service(tmp_path)
    revision = refresh.preflight(package_file(tmp_path)).revision_id
    db.connection.execute("UPDATE application_state SET value='1' WHERE key='campaign_active'")
    refresh.activate(revision, accounts())
    assert CampaignRevisionRepository(db).active()["id"] == revision
    assert JobRepository(db).count() == 360
    assert db.connection.execute(
        "SELECT value FROM application_state WHERE key='campaign_active'"
    ).fetchone()[0] == "0"
    db.close()
    reopened = Database.open(tmp_path / "campaign.db")
    assert CampaignRevisionRepository(reopened).active()["id"] == revision


def test_failed_activation_preserves_previous_revision_and_jobs(tmp_path: Path) -> None:
    db, refresh = service(tmp_path)
    first = refresh.preflight(package_file(tmp_path, suffix="-one"))
    refresh.activate(first.revision_id, accounts())
    original_count = JobRepository(db).count()

    conflicting = json.loads(package_file(tmp_path, suffix="-one").read_text(encoding="utf-8"))
    conflicting["manifest"]["title"] = "Different content, same slug"
    conflict_path = tmp_path / "conflict.json"
    conflict_path.write_text(json.dumps(conflicting, ensure_ascii=False), encoding="utf-8")
    second = refresh.preflight(conflict_path)
    with pytest.raises(ValueError, match="slug"):
        refresh.activate(second.revision_id, accounts())
    assert CampaignRevisionRepository(db).active()["id"] == first.revision_id
    assert JobRepository(db).count() == original_count


def test_rollback_selects_previous_revision_without_deleting_jobs(tmp_path: Path) -> None:
    db, refresh = service(tmp_path)
    first = refresh.preflight(package_file(tmp_path, "2026-11", suffix="-one"))
    second = refresh.preflight(package_file(tmp_path, "2026-12", suffix="-two"))
    refresh.activate(first.revision_id, accounts())
    refresh.activate(second.revision_id, accounts())
    assert JobRepository(db).count() == 720
    assert refresh.rollback()
    assert CampaignRevisionRepository(db).active()["id"] == first.revision_id
    assert JobRepository(db).count() == 720
