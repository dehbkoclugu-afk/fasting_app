"""Persist validated monthly media as immutable import batches."""

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path

from social_funnel.domain.models import CampaignManifest
from social_funnel.media.importer import inspect_media_zip, stage_media_zip
from social_funnel.media.models import ImportReport
from social_funnel.storage.repositories import MediaImportRepository


@dataclass(frozen=True)
class PreflightResult:
    batch_id: str
    report: ImportReport


def _file_checksum(path: Path) -> str:
    digest = sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


class MediaImportService:
    def __init__(self, repository: MediaImportRepository, manifest: CampaignManifest, workspace: Path):
        self.repository = repository
        self.manifest = manifest
        self.workspace = Path(workspace)

    def preflight(self, archive: Path, *, ffprobe=None) -> PreflightResult:
        archive = Path(archive)
        checksum = _file_checksum(archive)
        batch_id = f"batch-{checksum[:16]}"
        existing = self.repository.find_by_checksum(self.manifest.slug, checksum)
        if existing is not None:
            return PreflightResult(existing["id"], inspect_media_zip(archive, self.manifest))
        destination = self.workspace / "media" / "imports" / batch_id
        report = stage_media_zip(archive, self.manifest, destination, ffprobe=ffprobe)
        if not report.valid:
            return PreflightResult(batch_id, report)
        self.repository.create_batch(batch_id, self.manifest.slug, checksum)
        for item in report.files:
            self.repository.add_file(
                batch_id, day=item.slot.day, locale=item.slot.locale.value, kind=item.slot.kind,
                position=item.slot.position, managed_path=str(item.staged_path), checksum=item.checksum,
                width=item.width or 0, height=item.height or 0, duration_ms=item.duration_ms,
                mime_type=item.mime_type,
            )
        return PreflightResult(batch_id, report)

    def activate(self, batch_id: str) -> None:
        self.repository.activate(self.manifest.slug, batch_id)

    def rollback(self) -> bool:
        return self.repository.rollback(self.manifest.slug)
