"""Resolve the exact reviewed asset used by preview, export, and publishing."""

from hashlib import sha256
from pathlib import Path

from social_funnel.domain.models import CampaignManifest, LocalizedContent, MediaAsset, Platform, PublicationJob
from social_funnel.rendering.images import RenderRequest, render_asset
from social_funnel.storage.repositories import MediaImportRepository


def _checksum(path: Path) -> str:
    return sha256(path.read_bytes()).hexdigest()


class MediaResolver:
    def __init__(self, repository: MediaImportRepository | None, campaign: CampaignManifest, media_root: Path):
        self.repository = repository
        self.campaign = campaign
        self.media_root = Path(media_root)

    def _imported(self, job: PublicationJob, content: LocalizedContent) -> MediaAsset | None:
        if self.repository is None:
            return None
        rows = self.repository.active_slot_files(self.campaign.slug, job.day, job.locale.value)
        expected = "video" if content.preferred_format == "video" else (
            "carousel_slide" if content.preferred_format == "carousel" else "image"
        )
        rows = tuple(row for row in rows if row["kind"] == expected)
        if not rows:
            return None
        if expected == "carousel_slide" and [row["position"] for row in rows] != [1, 2, 3]:
            return None
        paths = tuple(Path(row["managed_path"]) for row in rows)
        for row, path in zip(rows, paths, strict=True):
            if not path.is_file() or _checksum(path) != row["checksum"]:
                raise ValueError(f"Imported media checksum mismatch: day {job.day} {job.locale.value}")
        first = rows[0]
        return MediaAsset(
            path=paths[0], additional_paths=paths[1:], width=first["width"], height=first["height"],
            checksum=first["checksum"], mime_type=first["mime_type"],
            alt_text=f"FastTrack day {job.day}: {content.hook}",
        )

    def resolve(self, job: PublicationJob, content: LocalizedContent) -> MediaAsset | None:
        if job.platform == Platform.THREADS:
            return None
        if job.platform == Platform.TIKTOK and content.preferred_format != "video":
            return None
        imported = self._imported(job, content)
        if imported is not None:
            return imported
        if content.preferred_format == "video":
            return None
        destination = self.media_root / f"day-{job.day:02d}" / job.locale.value / job.platform.value
        kind = "carousel" if content.preferred_format == "carousel" else "image"
        return render_asset(RenderRequest(content, destination, format=kind))
