from __future__ import annotations

from pathlib import Path
from types import SimpleNamespace

from social_funnel.windows.diagnostics import run_diagnostics


def completed(returncode=0, stdout=""):
    return SimpleNamespace(returncode=returncode, stdout=stdout, stderr="")


def test_diagnostics_accepts_unicode_workspace_and_capability_tests_ffmpeg(tmp_path):
    workspace = tmp_path / "Şirket İçerikleri"
    calls: list[list[str]] = []

    report = run_diagnostics(
        workspace=workspace,
        ffmpeg_runner=lambda command: calls.append(command) or completed(stdout="unexpected build label\n ... scale ..."),
        vault_probe=lambda: True,
        accounts=(),
    )

    assert report.ok
    assert workspace.is_dir()
    assert calls == [["ffmpeg", "-hide_banner", "-filters"]]


def test_diagnostics_reports_unwritable_workspace():
    report = run_diagnostics(
        workspace=Path("C:/not-writable"),
        writable_probe=lambda _: False,
        ffmpeg_runner=lambda _: completed(stdout="scale"),
        vault_probe=lambda: True,
        accounts=(),
    )

    assert not report.ok
    assert "Çalışma klasörüne yazılamıyor" in report.errors


def test_diagnostics_reports_unavailable_vault_and_incomplete_accounts(tmp_path):
    accounts = (
        {"id": "pt-br-instagram", "enabled": 1, "public_identity": "fasttrack.fasting.br", "vault_reference": None},
        {"id": "en-threads", "enabled": 1, "public_identity": None, "vault_reference": None},
        {"id": "tr-facebook", "enabled": 0, "public_identity": None, "vault_reference": None},
    )

    report = run_diagnostics(
        workspace=tmp_path,
        ffmpeg_runner=lambda _: completed(stdout="scale"),
        vault_probe=lambda: False,
        accounts=accounts,
    )

    assert not report.ok
    assert "Windows kimlik bilgisi kasası kullanılamıyor" in report.errors
    assert report.incomplete_accounts == ("en-threads", "pt-br-instagram")


def test_diagnostics_rejects_ffmpeg_without_required_filter(tmp_path):
    report = run_diagnostics(
        workspace=tmp_path,
        ffmpeg_runner=lambda _: completed(stdout="filters without required capability"),
        vault_probe=lambda: True,
        accounts=(),
    )

    assert not report.ok
    assert "FFmpeg ölçekleme özelliği kullanılamıyor" in report.errors

