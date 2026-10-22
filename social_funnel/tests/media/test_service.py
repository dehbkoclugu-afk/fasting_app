from io import BytesIO
from pathlib import Path
from zipfile import ZipFile

from PIL import Image

from social_funnel.content.loader import load_campaign
from social_funnel.media.service import MediaImportService
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, MediaImportRepository


CATALOG = Path(__file__).resolve().parents[2] / "content" / "fasttrack-30-day-launch.json"


def make_zip(tmp_path: Path, name: str = "day-04/tr/post.png") -> Path:
    data = BytesIO()
    Image.new("RGB", (1080, 1350), "white").save(data, "PNG")
    path = tmp_path / "media.zip"
    with ZipFile(path, "w") as bundle:
        bundle.writestr(name, data.getvalue())
    return path


def service(tmp_path: Path) -> tuple[Database, MediaImportService, MediaImportRepository]:
    db = Database.open(tmp_path / "campaign.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    repo = MediaImportRepository(db)
    return db, MediaImportService(repo, manifest, tmp_path / "workspace"), repo


def test_invalid_preflight_does_not_change_database_or_managed_media(tmp_path: Path) -> None:
    db, imports, repo = service(tmp_path)
    result = imports.preflight(make_zip(tmp_path, "../escape.png"))
    assert not result.report.valid
    assert repo.list_batches("fasttrack-30-day-launch") == ()
    assert not (tmp_path / "workspace" / "media" / "imports").exists()


def test_preflight_is_idempotent_and_activation_survives_restart(tmp_path: Path) -> None:
    db, imports, repo = service(tmp_path)
    first = imports.preflight(make_zip(tmp_path))
    second = imports.preflight(make_zip(tmp_path))
    assert first.batch_id == second.batch_id
    assert len(repo.list_batches("fasttrack-30-day-launch")) == 1
    imports.activate(first.batch_id)
    db.close()
    reopened = Database.open(tmp_path / "campaign.db")
    active = MediaImportRepository(reopened).active_batch("fasttrack-30-day-launch")
    assert active["id"] == first.batch_id
    assert Path(MediaImportRepository(reopened).active_files("fasttrack-30-day-launch")[0]["managed_path"]).is_file()
