import json
import zipfile
from datetime import date
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import LocaleCode, Platform
from social_funnel.exporting.manual_pack import export_manual_pack
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, JobRepository


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def test_zip_has_localized_caption_media_and_no_secrets(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    manifest = load_campaign(CATALOG)
    CampaignRepository(db).import_manifest(manifest)
    jobs = expand_publication_jobs(manifest, (AccountConfig("tr-instagram", LocaleCode.TR, Platform.INSTAGRAM),), date(2026, 10, 20))
    JobRepository(db).import_jobs(jobs)
    archive = export_manual_pack((jobs[0].id,), tmp_path / "export.zip", JobRepository(db), manifest, tmp_path / "media")
    with zipfile.ZipFile(archive) as bundle:
        names = bundle.namelist()
        assert "tr/instagram/day-01/caption.txt" in names
        assert "tr/instagram/day-01/alt-text.txt" in names
        assert any(name.endswith(".mp4") for name in names)
        caption = bundle.read("tr/instagram/day-01/caption.txt").decode("utf-8")
        assert "İlk haftanı sakin başlat" in caption
        meta = json.loads(bundle.read("manifest.json"))
        assert meta["jobs"][0]["account_id"] == "tr-instagram"
        assert "access_token" not in str(meta) and "C:\\Users" not in str(meta)
    db.close()
