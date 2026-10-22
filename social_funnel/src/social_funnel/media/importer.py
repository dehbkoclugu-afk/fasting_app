"""Inspect monthly media ZIPs without trusting archive names or metadata."""

from pathlib import Path, PurePosixPath
import re
import shutil
from stat import S_IFMT, S_IFLNK
import tempfile
from zipfile import BadZipFile, ZipFile, ZipInfo

from social_funnel.domain.models import CampaignManifest, LocaleCode
from social_funnel.media.models import ImportedFile, ImportIssue, ImportReport, MediaSlot
from social_funnel.media.probe import probe_image, probe_video


DEFAULT_MAX_ENTRIES = 500
DEFAULT_MAX_EXPANDED_BYTES = 2 * 1024 * 1024 * 1024
_DAY = re.compile(r"day-(\d{2})$", re.IGNORECASE)
_SLIDE = re.compile(r"slide-(\d{2})\.png$", re.IGNORECASE)


def _unsafe(name: str) -> bool:
    normalized = name.replace("\\", "/")
    path = PurePosixPath(normalized)
    return (
        not normalized
        or normalized.startswith("/")
        or bool(re.match(r"^[A-Za-z]:/", normalized))
        or ".." in path.parts
    )


def _symlink(info: ZipInfo) -> bool:
    return info.create_system == 3 and S_IFMT(info.external_attr >> 16) == S_IFLNK


def _strip_shared_root(names: list[str]) -> list[str]:
    parts = [PurePosixPath(name).parts for name in names]
    if parts and all(len(item) >= 4 for item in parts):
        first = parts[0][0]
        if all(item[0] == first for item in parts) and not _DAY.fullmatch(first):
            return [PurePosixPath(*item[1:]).as_posix() for item in parts]
    return [PurePosixPath(*item).as_posix() for item in parts]


def _slot(path: str, manifest: CampaignManifest) -> MediaSlot | None:
    parts = PurePosixPath(path).parts
    if len(parts) != 3:
        return None
    match = _DAY.fullmatch(parts[0])
    if match is None:
        return None
    day = int(match.group(1))
    if not 1 <= day <= len(manifest.ideas):
        return None
    try:
        locale = LocaleCode(parts[1])
    except ValueError:
        return None
    filename = parts[2].lower()
    expected = next(item for item in manifest.ideas[day - 1].localized if item.locale == locale).preferred_format
    if filename == "video.mp4" and expected == "video":
        return MediaSlot(day=day, locale=locale, kind="video")
    if filename == "post.png" and expected == "image":
        return MediaSlot(day=day, locale=locale, kind="image")
    slide = _SLIDE.fullmatch(filename)
    if slide and expected == "carousel" and 1 <= int(slide.group(1)) <= 3:
        return MediaSlot(day=day, locale=locale, kind="carousel_slide", position=int(slide.group(1)))
    return None


def inspect_media_zip(
    archive: Path,
    manifest: CampaignManifest,
    ffprobe=None,
    *,
    max_entries: int = DEFAULT_MAX_ENTRIES,
    max_expanded_bytes: int = DEFAULT_MAX_EXPANDED_BYTES,
) -> ImportReport:
    del ffprobe  # Reserved for the extraction/probe phase.
    archive = Path(archive)
    issues: list[ImportIssue] = []
    files: list[ImportedFile] = []
    try:
        with ZipFile(archive) as bundle:
            entries = [item for item in bundle.infolist() if not item.is_dir()]
            if len(entries) > max_entries:
                issues.append(ImportIssue(code="too_many_entries", message="Archive has too many files."))
            if sum(item.file_size for item in entries) > max_expanded_bytes:
                issues.append(ImportIssue(code="archive_too_large", message="Expanded archive is too large."))
            safe_entries: list[ZipInfo] = []
            for item in entries:
                if _unsafe(item.filename):
                    issues.append(ImportIssue(code="unsafe_path", message="Unsafe archive path.", path=item.filename))
                elif _symlink(item):
                    issues.append(ImportIssue(code="symlink", message="Archive links are not allowed.", path=item.filename))
                else:
                    safe_entries.append(item)
            normalized = _strip_shared_root([item.filename.replace("\\", "/") for item in safe_entries])
            seen: set[tuple[int, str, str, int]] = set()
            for item, name in zip(safe_entries, normalized, strict=True):
                slot = _slot(name, manifest)
                if slot is None:
                    issues.append(ImportIssue(code="unexpected_file", message="File does not match a campaign slot.", path=name))
                    continue
                key = (slot.day, slot.locale.value, slot.kind, slot.position)
                if key in seen:
                    issues.append(ImportIssue(code="duplicate_slot", message="More than one file targets this slot.", path=name))
                    continue
                seen.add(key)
                files.append(ImportedFile(archive_path=item.filename, normalized_path=name, slot=slot, size=item.file_size))
    except (BadZipFile, OSError):
        issues.append(ImportIssue(code="invalid_zip", message="The selected file is not a readable ZIP archive."))
    files.sort(key=lambda item: (item.slot.day, item.slot.locale.value, item.slot.kind, item.slot.position))
    return ImportReport(archive=archive, files=tuple(files), issues=tuple(issues))


def stage_media_zip(
    archive: Path,
    manifest: CampaignManifest,
    destination: Path,
    ffprobe=None,
    *,
    max_entries: int = DEFAULT_MAX_ENTRIES,
    max_expanded_bytes: int = DEFAULT_MAX_EXPANDED_BYTES,
) -> ImportReport:
    report = inspect_media_zip(archive, manifest, max_entries=max_entries,
                               max_expanded_bytes=max_expanded_bytes)
    if not report.valid:
        return report
    destination = Path(destination)
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = Path(tempfile.mkdtemp(prefix="media-import-", dir=destination.parent))
    files: list[ImportedFile] = []
    issues = list(report.issues)
    try:
        with ZipFile(archive) as bundle:
            total = 0
            for item in report.files:
                target = temporary / PurePosixPath(item.normalized_path)
                target.parent.mkdir(parents=True, exist_ok=True)
                with bundle.open(item.archive_path) as source, target.open("wb") as output:
                    while block := source.read(1024 * 1024):
                        total += len(block)
                        if total > max_expanded_bytes:
                            raise ValueError("Expanded archive exceeds the configured limit.")
                        output.write(block)
                try:
                    metadata = probe_video(target, runner=ffprobe) if item.slot.kind == "video" else probe_image(target)
                except (FileNotFoundError, ValueError) as exc:
                    issues.append(ImportIssue(code="invalid_media", message=str(exc), path=item.normalized_path))
                    continue
                files.append(item.model_copy(update={
                    "staged_path": target,
                    "checksum": metadata.checksum,
                    "width": metadata.width,
                    "height": metadata.height,
                    "duration_ms": metadata.duration_ms,
                    "mime_type": metadata.mime_type,
                }))
        if issues:
            shutil.rmtree(temporary, ignore_errors=True)
            return ImportReport(archive=Path(archive), files=tuple(files), issues=tuple(issues))
        if destination.exists():
            raise FileExistsError(destination)
        temporary.replace(destination)
        final_files = tuple(item.model_copy(update={
            "staged_path": destination / PurePosixPath(item.normalized_path),
        }) for item in files)
        return ImportReport(archive=Path(archive), files=final_files, staging_directory=destination)
    except Exception:
        shutil.rmtree(temporary, ignore_errors=True)
        raise
