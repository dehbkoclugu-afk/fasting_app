"""Pre-flight checks for the local Windows application."""

from __future__ import annotations

from collections.abc import Callable, Iterable, Mapping
from dataclasses import dataclass
from pathlib import Path
import subprocess
import tempfile


@dataclass(frozen=True)
class DiagnosticReport:
    errors: tuple[str, ...]
    incomplete_accounts: tuple[str, ...] = ()

    @property
    def ok(self) -> bool:
        return not self.errors


def _workspace_is_writable(path: Path) -> bool:
    try:
        path.mkdir(parents=True, exist_ok=True)
        with tempfile.NamedTemporaryFile(dir=path, prefix=".fasttrack-", delete=True):
            pass
        return True
    except OSError:
        return False


def _run_ffmpeg(command: list[str]):
    return subprocess.run(command, capture_output=True, text=True, check=False,
                          creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0))


def _vault_is_available() -> bool:
    try:
        import keyring
        return float(getattr(keyring.get_keyring(), "priority", 0)) > 0
    except Exception:
        return False


def run_diagnostics(
    *,
    workspace: Path,
    ffmpeg_runner: Callable[[list[str]], object] = _run_ffmpeg,
    vault_probe: Callable[[], bool] = _vault_is_available,
    writable_probe: Callable[[Path], bool] = _workspace_is_writable,
    accounts: Iterable[Mapping[str, object]] = (),
) -> DiagnosticReport:
    errors: list[str] = []
    if not writable_probe(workspace):
        errors.append("Çalışma klasörüne yazılamıyor")

    try:
        result = ffmpeg_runner(["ffmpeg", "-hide_banner", "-filters"])
        output = f"{getattr(result, 'stdout', '')}\n{getattr(result, 'stderr', '')}".lower()
        if getattr(result, "returncode", 1) != 0:
            errors.append("FFmpeg çalıştırılamıyor")
        elif "scale" not in output:
            errors.append("FFmpeg ölçekleme özelliği kullanılamıyor")
    except OSError:
        errors.append("FFmpeg bulunamadı")

    if not vault_probe():
        errors.append("Windows kimlik bilgisi kasası kullanılamıyor")

    incomplete = tuple(sorted(
        str(account["id"])
        for account in accounts
        if bool(account.get("enabled", True))
        and (not account.get("public_identity") or not account.get("vault_reference"))
    ))
    return DiagnosticReport(tuple(errors), incomplete)

