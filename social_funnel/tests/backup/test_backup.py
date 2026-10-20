from datetime import date
from pathlib import Path
from zipfile import ZIP_DEFLATED, ZipFile
import json

import pytest

from social_funnel.backup.service import (
    BACKUP_FORMAT_VERSION,
    BackupValidationError,
    create_backup,
    restore_backup,
)
from social_funnel.setup.service import initialize_workspace


def _rewrite_json_entry(archive: Path, entry: str, mutate) -> None:
    with ZipFile(archive) as source:
        entries = {name: source.read(name) for name in source.namelist()}
    payload = json.loads(entries[entry])
    mutate(payload)
    entries[entry] = json.dumps(payload, ensure_ascii=False, sort_keys=True).encode()
    with ZipFile(archive, "w", ZIP_DEFLATED) as target:
        for name, data in entries.items():
            target.writestr(name, data)


def _workspace(tmp_path: Path) -> Path:
    workspace = tmp_path / "Kaynak Çalışma Alanı"
    initialize_workspace(workspace, start_date=date(2026, 10, 20))
    (workspace / "media" / "görsel.txt").write_text("media", encoding="utf-8")
    (workspace / "config" / "settings.json").write_text(
        json.dumps({"theme": "dark", "access_token": "do-not-export"}), encoding="utf-8"
    )
    return workspace


def test_backup_contains_database_sanitized_config_and_media_manifest(tmp_path: Path) -> None:
    workspace = _workspace(tmp_path)

    archive = create_backup(tmp_path / "exports", workspace=workspace)

    with ZipFile(archive) as backup:
        names = set(backup.namelist())
        assert {"campaign.db", "config/settings.json", "media-manifest.json", "backup-manifest.json"} <= names
        assert "media/görsel.txt" in names
        serialized = b"\n".join(backup.read(name) for name in names)
        config = json.loads(backup.read("config/settings.json"))
    assert b"do-not-export" not in serialized
    assert config == {"theme": "dark"}


def test_restore_is_transactional_and_keeps_previous_workspace(tmp_path: Path) -> None:
    source = _workspace(tmp_path)
    archive = create_backup(tmp_path / "backup.zip", workspace=source)
    target = tmp_path / "Hedef Alan"
    target.mkdir()
    (target / "old-marker.txt").write_text("recover me", encoding="utf-8")

    previous = restore_backup(archive, workspace=target)

    assert (target / "campaign.db").is_file()
    assert (target / "media" / "görsel.txt").read_text(encoding="utf-8") == "media"
    assert not (target / "old-marker.txt").exists()
    assert (previous / "old-marker.txt").read_text(encoding="utf-8") == "recover me"


def test_checksum_mismatch_blocks_restore_without_touching_workspace(tmp_path: Path) -> None:
    source = _workspace(tmp_path)
    archive = create_backup(tmp_path / "backup.zip", workspace=source)
    with ZipFile(archive) as backup:
        entries = {name: backup.read(name) for name in backup.namelist()}
    entries["campaign.db"] = b"tampered"
    with ZipFile(archive, "w", ZIP_DEFLATED) as backup:
        for name, data in entries.items():
            backup.writestr(name, data)
    target = tmp_path / "current"
    target.mkdir()
    marker = target / "marker.txt"
    marker.write_text("untouched", encoding="utf-8")

    with pytest.raises(BackupValidationError, match="checksum"):
        restore_backup(archive, workspace=target)

    assert marker.read_text(encoding="utf-8") == "untouched"


def test_newer_backup_schema_is_rejected_without_touching_workspace(tmp_path: Path) -> None:
    source = _workspace(tmp_path)
    archive = create_backup(tmp_path / "backup.zip", workspace=source)
    _rewrite_json_entry(
        archive,
        "backup-manifest.json",
        lambda payload: payload.update(backup_format_version=BACKUP_FORMAT_VERSION + 1),
    )
    target = tmp_path / "current"
    target.mkdir()
    marker = target / "marker.txt"
    marker.write_text("untouched", encoding="utf-8")

    with pytest.raises(BackupValidationError, match="newer backup schema"):
        restore_backup(archive, workspace=target)

    assert marker.read_text(encoding="utf-8") == "untouched"
