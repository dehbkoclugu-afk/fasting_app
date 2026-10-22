from hashlib import sha256
from pathlib import Path

from PIL import Image

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.media.resolver import MediaResolver
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRepository, MediaImportRepository


CATALOG = Path(__file__).resolve().parents[2] / "content" / "fasttrack-30-day-launch.json"


def job_for(manifest, day: int, platform: Platform):
    jobs = expand_publication_jobs(manifest, (AccountConfig(f"tr-{platform.value}", LocaleCode.TR, platform, AutomationMode.APPROVAL),), __import__("datetime").date(2026, 10, 20))
    return next(job for job in jobs if job.day == day)


def test_imported_video_is_authoritative_and_checksum_verified(tmp_path: Path) -> None:
    manifest = load_campaign(CATALOG)
    db = Database.open(tmp_path / "db.sqlite")
    CampaignRepository(db).import_manifest(manifest)
    repo = MediaImportRepository(db)
    video = tmp_path / "video.mp4"
    video.write_bytes(b"approved-video")
    digest = sha256(video.read_bytes()).hexdigest()
    repo.create_batch("b1", manifest.slug, "archive")
    repo.add_file("b1", day=1, locale="tr", kind="video", position=0, managed_path=str(video),
                  checksum=digest, width=1080, height=1920, duration_ms=24000, mime_type="video/mp4")
    repo.activate(manifest.slug, "b1")
    resolver = MediaResolver(repo, manifest, tmp_path / "generated")
    content = manifest.ideas[0].localized[0]
    asset = resolver.resolve(job_for(manifest, 1, Platform.INSTAGRAM), content)
    assert asset.path == video
    assert asset.checksum == digest
    video.write_bytes(b"tampered")
    try:
        resolver.resolve(job_for(manifest, 1, Platform.FACEBOOK), content)
        raise AssertionError("tampered media was accepted")
    except ValueError as error:
        assert "checksum" in str(error)


def test_video_never_falls_back_but_images_and_carousels_do(tmp_path: Path) -> None:
    manifest = load_campaign(CATALOG)
    resolver = MediaResolver(None, manifest, tmp_path / "generated")
    video_content = manifest.ideas[0].localized[0]
    assert resolver.resolve(job_for(manifest, 1, Platform.INSTAGRAM), video_content) is None
    image_content = manifest.ideas[3].localized[0]
    assert resolver.resolve(job_for(manifest, 4, Platform.INSTAGRAM), image_content).path.is_file()
    carousel_content = manifest.ideas[1].localized[0]
    carousel = resolver.resolve(job_for(manifest, 2, Platform.FACEBOOK), carousel_content)
    assert carousel.path.is_file() and len(carousel.additional_paths) == 2


def test_threads_are_text_only_and_non_video_tiktok_is_disabled(tmp_path: Path) -> None:
    manifest = load_campaign(CATALOG)
    resolver = MediaResolver(None, manifest, tmp_path / "generated")
    assert resolver.resolve(job_for(manifest, 4, Platform.THREADS), manifest.ideas[3].localized[0]) is None
    assert resolver.resolve(job_for(manifest, 4, Platform.TIKTOK), manifest.ideas[3].localized[0]) is None
