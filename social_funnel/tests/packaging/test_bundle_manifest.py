from pathlib import Path
import json


ROOT = Path(__file__).resolve().parents[2]
PACKAGING = ROOT / "packaging"


def test_pyinstaller_manifest_declares_only_reviewed_application_assets() -> None:
    spec = (PACKAGING / "social-funnel.spec").read_text(encoding="utf-8")

    assert 'ENTRY_POINT = "social_funnel.windows.launcher:launch"' in spec
    assert '"src/social_funnel/web/templates"' in spec
    assert '"src/social_funnel/web/static"' in spec
    assert '"content/fasttrack-30-day-launch.json"' in spec
    assert '"assets/artwork"' in spec
    assert '"C:/Windows/Fonts/segoeui.ttf"' in spec
    assert 'collect_submodules("multipart")' in spec
    assert "campaign.db" not in spec
    assert "credentials" not in spec.casefold()
    assert "user media" not in spec.casefold()


def test_build_and_smoke_scripts_fail_fast_and_verify_the_packaged_executable() -> None:
    build = (PACKAGING / "build.ps1").read_text(encoding="utf-8")
    smoke = (PACKAGING / "smoke-test.ps1").read_text(encoding="utf-8")

    assert "$ErrorActionPreference = \"Stop\"" in build
    assert "python -m venv" in build
    assert "-m pytest" in build
    assert "PyInstaller" in build
    assert "Get-FileHash" in build
    assert "FASTTRACK_SMOKE_TEST" in smoke
    assert "FastTrack Social Funnel.exe" in smoke
    assert 'job_count -ne 360' in smoke
    assert 'localized_count -ne 90' in smoke
    assert 'idea_count -ne 30' in smoke
    assert 'health -ne "ok"' in smoke
    assert 'paused -ne $false' in smoke


def test_packaged_smoke_check_exercises_workspace_health_render_and_pause(tmp_path: Path) -> None:
    from social_funnel.windows.launcher import run_smoke_check

    report_path = tmp_path / "smoke-report.json"
    assert run_smoke_check(tmp_path / "Türkçe Paket Alanı", report_path) == 0

    report = json.loads(report_path.read_text(encoding="utf-8"))
    assert report == {
        "account_count": 12,
        "campaigns_page": True,
        "health": "ok",
        "idea_count": 30,
        "job_count": 360,
        "localized_count": 90,
        "paused": False,
        "rendered": True,
        "shutdown": "clean",
    }
