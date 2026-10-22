from pathlib import Path

from social_funnel.content.loader import load_campaign
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, MediaImportRepository


CATALOG = Path(__file__).resolve().parents[2] / "content" / "fasttrack-30-day-launch.json"


def repository(tmp_path: Path) -> tuple[Database, MediaImportRepository]:
    db = Database.open(tmp_path / "campaign.db")
    CampaignRepository(db).import_manifest(load_campaign(CATALOG))
    return db, MediaImportRepository(db)


def test_existing_database_receives_media_tables_without_losing_state(tmp_path: Path) -> None:
    path = tmp_path / "campaign.db"
    db = Database.open(path)
    db.connection.execute("UPDATE application_state SET value='1' WHERE key='paused'")
    db.connection.commit()
    db.close()
    reopened = Database.open(path)
    names = {row[0] for row in reopened.connection.execute("SELECT name FROM sqlite_master WHERE type='table'")}
    assert {"media_import_batch", "media_import_file", "active_media_batch"} <= names
    assert reopened.connection.execute("SELECT value FROM application_state WHERE key='paused'").fetchone()[0] == "1"


def test_activation_and_rollback_preserve_previous_batch(tmp_path: Path) -> None:
    db, repo = repository(tmp_path)
    repo.create_batch("batch-1", "fasttrack-30-day-launch", "sha-1")
    repo.create_batch("batch-2", "fasttrack-30-day-launch", "sha-2")
    repo.activate("fasttrack-30-day-launch", "batch-1")
    repo.activate("fasttrack-30-day-launch", "batch-2")
    assert repo.active_batch("fasttrack-30-day-launch")["id"] == "batch-2"
    assert repo.rollback("fasttrack-30-day-launch")
    assert repo.active_batch("fasttrack-30-day-launch")["id"] == "batch-1"


def test_files_are_unique_per_logical_slot_and_queryable_from_active_batch(tmp_path: Path) -> None:
    db, repo = repository(tmp_path)
    repo.create_batch("batch-1", "fasttrack-30-day-launch", "sha-1")
    values = dict(day=1, locale="tr", kind="video", position=0, managed_path="x/video.mp4",
                  checksum="abc", width=1080, height=1920, duration_ms=24000, mime_type="video/mp4")
    repo.add_file("batch-1", **values)
    repo.add_file("batch-1", **values)
    repo.activate("fasttrack-30-day-launch", "batch-1")
    files = repo.active_files("fasttrack-30-day-launch")
    assert len(files) == 1
    assert files[0]["checksum"] == "abc"
