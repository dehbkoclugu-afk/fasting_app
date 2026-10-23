"""Checksum-validated backups that deliberately exclude credential-vault secrets."""

from __future__ import annotations

from datetime import datetime, timezone
from hashlib import sha256
from pathlib import Path, PurePosixPath
from tempfile import TemporaryDirectory
from uuid import uuid4
from zipfile import ZIP_DEFLATED, BadZipFile, ZipFile
import json
import os
import shutil
import sqlite3


BACKUP_FORMAT_VERSION = 1
_SECRET_KEY_PARTS = (
    "password",
    "secret",
    "token",
    "credential",
    "api_key",
    "access_key",
    "refresh_key",
    "private_key",
)


class BackupValidationError(ValueError):
    """The archive cannot be safely restored."""


def _default_workspace() -> Path:
    root = Path(os.environ.get("LOCALAPPDATA", str(Path.home())))
    return root / "FastTrack Social Funnel"


def _digest(data: bytes) -> str:
    return sha256(data).hexdigest()


def _sanitize(value):
    if isinstance(value, dict):
        return {
            key: _sanitize(item)
            for key, item in value.items()
            if not any(part in key.casefold() for part in _SECRET_KEY_PARTS)
        }
    if isinstance(value, list):
        return [_sanitize(item) for item in value]
    return value


def _sqlite_snapshot(source: Path, destination: Path) -> None:
    source_db = sqlite3.connect(source)
    target_db = sqlite3.connect(destination)
    try:
        source_db.backup(target_db)
    finally:
        target_db.close()
        source_db.close()


def _destination_path(destination: Path) -> Path:
    destination = Path(destination)
    if destination.suffix.casefold() == ".zip":
        destination.parent.mkdir(parents=True, exist_ok=True)
        return destination
    destination.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    return destination / f"fasttrack-backup-{stamp}.zip"


def create_backup(destination: Path, *, workspace: Path | None = None) -> Path:
    """Create a portable archive without reading from the operating-system vault."""
    workspace = Path(workspace) if workspace is not None else _default_workspace()
    database_path = workspace / "campaign.db"
    config_path = workspace / "config" / "settings.json"
    if not database_path.is_file() or not config_path.is_file():
        raise FileNotFoundError("workspace must contain campaign.db and config/settings.json")

    output = _destination_path(destination)
    with TemporaryDirectory(prefix="fasttrack-backup-") as temporary:
        snapshot = Path(temporary) / "campaign.db"
        _sqlite_snapshot(database_path, snapshot)
        files: dict[str, bytes] = {"campaign.db": snapshot.read_bytes()}

        config = json.loads(config_path.read_text(encoding="utf-8"))
        files["config/settings.json"] = json.dumps(
            _sanitize(config), ensure_ascii=False, indent=2, sort_keys=True
        ).encode("utf-8")

        media_entries = []
        media_root = workspace / "media"
        if media_root.exists():
            for media_path in sorted(path for path in media_root.rglob("*") if path.is_file()):
                relative = media_path.relative_to(workspace).as_posix()
                data = media_path.read_bytes()
                files[relative] = data
                media_entries.append({"path": relative, "sha256": _digest(data), "size": len(data)})
        files["media-manifest.json"] = json.dumps(
            {"files": media_entries}, ensure_ascii=False, indent=2, sort_keys=True
        ).encode("utf-8")

        manifest = {
            "backup_format_version": BACKUP_FORMAT_VERSION,
            "created_at": datetime.now(timezone.utc).isoformat(),
            "files": {name: _digest(data) for name, data in sorted(files.items())},
        }
        with ZipFile(output, "w", ZIP_DEFLATED) as archive:
            for name, data in sorted(files.items()):
                archive.writestr(name, data)
            archive.writestr(
                "backup-manifest.json",
                json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True),
            )
    return output


def _safe_member(name: str) -> PurePosixPath:
    path = PurePosixPath(name)
    if path.is_absolute() or ".." in path.parts or not path.parts:
        raise BackupValidationError(f"unsafe backup path: {name}")
    return path


def _validated_entries(archive_path: Path) -> tuple[dict[str, bytes], dict]:
    try:
        with ZipFile(archive_path) as archive:
            names = archive.namelist()
            if len(names) != len(set(names)):
                raise BackupValidationError("backup contains duplicate paths")
            for name in names:
                _safe_member(name)
            try:
                manifest = json.loads(archive.read("backup-manifest.json"))
            except (KeyError, json.JSONDecodeError) as error:
                raise BackupValidationError("backup manifest is missing or invalid") from error
            version = manifest.get("backup_format_version")
            if not isinstance(version, int):
                raise BackupValidationError("backup schema version is invalid")
            if version > BACKUP_FORMAT_VERSION:
                raise BackupValidationError("newer backup schema is not supported")
            if version < 1:
                raise BackupValidationError("backup schema version is invalid")
            expected = manifest.get("files")
            if not isinstance(expected, dict):
                raise BackupValidationError("backup checksum table is invalid")
            required = {"campaign.db", "config/settings.json", "media-manifest.json"}
            if not required <= set(expected):
                raise BackupValidationError("backup is missing required workspace files")
            entries = {}
            for name, expected_digest in expected.items():
                _safe_member(name)
                try:
                    data = archive.read(name)
                except KeyError as error:
                    raise BackupValidationError(f"backup file is missing: {name}") from error
                if _digest(data) != expected_digest:
                    raise BackupValidationError(f"checksum mismatch for {name}")
                entries[name] = data
    except BadZipFile as error:
        raise BackupValidationError("backup is not a valid zip archive") from error
    return entries, manifest


def _validate_staged_workspace(stage: Path) -> None:
    connection = None
    try:
        json.loads((stage / "config" / "settings.json").read_text(encoding="utf-8"))
        media_manifest = json.loads((stage / "media-manifest.json").read_text(encoding="utf-8"))
        if not isinstance(media_manifest.get("files"), list):
            raise ValueError
        connection = sqlite3.connect(stage / "campaign.db")
        result = connection.execute("PRAGMA integrity_check").fetchone()[0]
        if result != "ok":
            raise BackupValidationError("database integrity check failed")
        connection.execute("SELECT 1 FROM campaign LIMIT 1").fetchone()
    except (OSError, ValueError, json.JSONDecodeError, sqlite3.DatabaseError) as error:
        if isinstance(error, BackupValidationError):
            raise
        raise BackupValidationError("restored workspace failed validation") from error
    finally:
        if connection is not None:
            connection.close()


def restore_backup(path: Path, *, workspace: Path | None = None) -> Path | None:
    """Validate into a sibling directory, then swap while retaining the previous workspace."""
    archive_path = Path(path)
    target = Path(workspace) if workspace is not None else _default_workspace()
    entries, _ = _validated_entries(archive_path)
    target.parent.mkdir(parents=True, exist_ok=True)
    stage = target.parent / f".{target.name}.restore-{uuid4().hex}"
    previous = target.parent / (
        f"{target.name}.previous-" + datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    )
    stage.mkdir()
    try:
        for name, data in entries.items():
            destination = stage.joinpath(*PurePosixPath(name).parts)
            destination.parent.mkdir(parents=True, exist_ok=True)
            destination.write_bytes(data)
        _validate_staged_workspace(stage)

        had_workspace = target.exists()
        if had_workspace:
            if previous.exists():
                previous = previous.with_name(f"{previous.name}-{uuid4().hex[:8]}")
            target.replace(previous)
        try:
            stage.replace(target)
        except Exception:
            if had_workspace and previous.exists() and not target.exists():
                previous.replace(target)
            raise
        return previous if had_workspace else None
    finally:
        if stage.exists():
            shutil.rmtree(stage)
