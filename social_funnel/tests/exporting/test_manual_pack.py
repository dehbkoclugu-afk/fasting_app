import json
import zipfile
from datetime import date
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import LocaleCode, Platform
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository, MediaImportRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def test_zip_has_localized_caption_media_and_no_secrets(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    jobs = expand_publication_jobs(manifest, (AccountConfig("tr-instagram", LocaleCode.TR, Platform.INSTAGRAM),), date(2026, 10, 20))
    JobRepository(db).import_jobs(jobs)
    job = next(item for item in jobs if item.day == 18)
    archive = export_manual_pack((job.id,), tmp_path / "export.zip", JobRepository(db), manifest, tmp_path / "media")
    with zipfile.ZipFile(archive) as bundle:
        names = bundle.namelist()
        assert "tr/instagram/day-18/caption.txt" in names
        assert "tr/instagram/day-18/alt-text.txt" in names
        assert any(name.endswith(".png") for name in names)
        caption = bundle.read("tr/instagram/day-18/caption.txt").decode("utf-8")
        assert "Arkadaş yemeği" in caption
        meta = json.loads(bundle.read("manifest.json"))
        assert meta["jobs"][0]["account_id"] == "tr-instagram"
        assert "access_token" not in str(meta) and "C:\\Users" not in str(meta)
    db.close()


def test_zip_uses_exact_active_imported_video(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    jobs = expand_publication_jobs(manifest, (AccountConfig("tr-instagram", LocaleCode.TR, Platform.INSTAGRAM),), date(2026, 10, 20))
    repository = JobRepository(db)
    repository.import_jobs(jobs)
    job = next(item for item in jobs if item.day == 1)
    video = tmp_path / "approved.mp4"
    video.write_bytes(b"exact-approved-video")
    import hashlib
    digest = hashlib.sha256(video.read_bytes()).hexdigest()
    imports = MediaImportRepository(db)
    imports.create_batch("batch", manifest.slug, "archive")
    imports.add_file("batch", day=1, locale="tr", kind="video", position=0,
                     managed_path=str(video), checksum=digest, width=1080, height=1920,
                     duration_ms=24000, mime_type="video/mp4")
    imports.activate(manifest.slug, "batch")
    archive = export_manual_pack((job.id,), tmp_path / "export.zip", repository, manifest, tmp_path / "media")
    with zipfile.ZipFile(archive) as bundle:
        media_name = next(name for name in bundle.namelist() if name.endswith("approved.mp4"))
        assert bundle.read(media_name) == b"exact-approved-video"
