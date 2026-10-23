"""Persist validated monthly media as immutable import batches."""

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path
import shutil
from uuid import uuid4

from social_funnel.domain.models import CampaignManifest, LocaleCode
from social_funnel.media.importer import inspect_media_zip, stage_media_zip
from social_funnel.media.models import ImportReport
from social_funnel.media.probe import probe_image, probe_video
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
        archive_checksum = _file_checksum(archive)
        provisional_id = f"batch-{archive_checksum[:16]}"
        existing = self.repository.find_by_checksum(self.manifest.slug, archive_checksum)
        if existing is not None:
            return PreflightResult(existing["id"], inspect_media_zip(archive, self.manifest))
        imports_root = self.workspace / "media" / "imports"
        staging = imports_root / f".incoming-{uuid4().hex}"
        report = stage_media_zip(archive, self.manifest, staging, ffprobe=ffprobe)
        if not report.valid:
            return PreflightResult(provisional_id, report)
        identity = "\n".join(
            f"{item.slot.day}:{item.slot.locale.value}:{item.slot.kind}:{item.slot.position}:{item.checksum}"
            for item in report.files
        )
        checksum = sha256(identity.encode("utf-8")).hexdigest()
        batch_id = f"batch-{checksum[:16]}"
        existing = self.repository.find_by_checksum(self.manifest.slug, checksum)
        if existing is not None:
            shutil.rmtree(staging, ignore_errors=True)
            rows = {
                (row["day"], row["locale"], row["kind"], row["position"]): row
                for row in self.repository.batch_files(existing["id"])
            }
            first_row = next(iter(rows.values()), None)
            report = report.model_copy(update={
                "staging_directory": Path(first_row["managed_path"]).parents[2] if first_row else None,
                "files": tuple(item.model_copy(update={
                    "staged_path": Path(rows[(item.slot.day, item.slot.locale.value, item.slot.kind, item.slot.position)]["managed_path"]),
                }) for item in report.files),
            })
            return PreflightResult(existing["id"], report)
        destination = imports_root / batch_id
        if destination.exists():
            shutil.rmtree(staging, ignore_errors=True)
            raise FileExistsError(destination)
        staging.replace(destination)
        report = report.model_copy(update={
            "staging_directory": destination,
            "files": tuple(item.model_copy(update={
                "staged_path": destination / item.normalized_path,
            }) for item in report.files),
        })
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

    def replace_slot(
        self,
        source: Path,
        *,
        day: int,
        locale: str,
        kind: str,
        position: int = 0,
        ffprobe=None,
    ) -> str:
        """Clone the active batch with one validated file replaced, without activating it."""
        active = self.repository.active_batch(self.manifest.slug)
        if active is None:
            raise ValueError("Önce etkin bir medya paketi seçin.")
        if not 1 <= day <= len(self.manifest.ideas):
            raise ValueError("Geçersiz içerik alanı.")
        try:
            locale_code = LocaleCode(locale)
            localized = next(
                item for item in self.manifest.ideas[day - 1].localized if item.locale == locale_code
            )
        except (ValueError, IndexError, StopIteration):
            raise ValueError("Geçersiz içerik alanı.") from None
        expected_kind = "carousel_slide" if localized.preferred_format == "carousel" else localized.preferred_format
        expected_position = range(1, 4) if expected_kind == "carousel_slide" else (0,)
        if kind != expected_kind or position not in expected_position:
            raise ValueError("Dosya seçilen içerik alanıyla eşleşmiyor.")

        source = Path(source)
        metadata = probe_video(source, runner=ffprobe) if kind == "video" else probe_image(source)
        identity = f"{active['id']}:{day}:{locale_code.value}:{kind}:{position}:{metadata.checksum}"
        digest = sha256(identity.encode("utf-8")).hexdigest()
        batch_id = f"batch-{digest[:16]}"
        if self.repository.get_batch(batch_id) is not None:
            return batch_id

        destination = self.workspace / "media" / "imports" / batch_id
        temporary = destination.with_name(f".{batch_id}.tmp")
        if temporary.exists():
            shutil.rmtree(temporary)
        active_rows = self.repository.batch_files(active["id"])
        slot_key = (day, locale_code.value, kind, position)
        slot_exists = any(
            (row["day"], row["locale"], row["kind"], row["position"]) == slot_key
            for row in active_rows
        )
        try:
            for row in active_rows:
                relative = self._normalized_path(row["day"], row["locale"], row["kind"], row["position"])
                target = temporary / relative
                target.parent.mkdir(parents=True, exist_ok=True)
                if (row["day"], row["locale"], row["kind"], row["position"]) == slot_key:
                    shutil.copy2(source, target)
                else:
                    shutil.copy2(row["managed_path"], target)
            if not slot_exists:
                target = temporary / self._normalized_path(day, locale_code.value, kind, position)
                target.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(source, target)
            temporary.replace(destination)
            self.repository.create_batch(batch_id, self.manifest.slug, digest)
            for row in active_rows:
                replaced = (row["day"], row["locale"], row["kind"], row["position"]) == (
                    day, locale_code.value, kind, position,
                )
                self.repository.add_file(
                    batch_id, day=row["day"], locale=row["locale"], kind=row["kind"],
                    position=row["position"],
                    managed_path=str(destination / self._normalized_path(
                        row["day"], row["locale"], row["kind"], row["position"]
                    )),
                    checksum=metadata.checksum if replaced else row["checksum"],
                    width=metadata.width if replaced else row["width"],
                    height=metadata.height if replaced else row["height"],
                    duration_ms=metadata.duration_ms if replaced else row["duration_ms"],
                    mime_type=metadata.mime_type if replaced else row["mime_type"],
                )
            if not slot_exists:
                self.repository.add_file(
                    batch_id, day=day, locale=locale_code.value, kind=kind, position=position,
                    managed_path=str(destination / self._normalized_path(day, locale_code.value, kind, position)),
                    checksum=metadata.checksum, width=metadata.width, height=metadata.height,
                    duration_ms=metadata.duration_ms, mime_type=metadata.mime_type,
                )
        except Exception:
            shutil.rmtree(temporary, ignore_errors=True)
            shutil.rmtree(destination, ignore_errors=True)
            raise
        return batch_id

    @staticmethod
    def _normalized_path(day: int, locale: str, kind: str, position: int) -> Path:
        filename = {
            "video": "video.mp4",
            "image": "post.png",
            "carousel_slide": f"slide-{position:02d}.png",
        }[kind]
        return Path(f"day-{day:02d}") / locale / filename

    def rollback(self) -> bool:
        return self.repository.rollback(self.manifest.slug)
