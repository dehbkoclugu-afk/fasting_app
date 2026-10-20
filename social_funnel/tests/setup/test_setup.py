from datetime import date
from pathlib import Path
import sqlite3

from social_funnel.setup.service import initialize_workspace


def test_first_run_imports_complete_campaign_into_unicode_workspace(tmp_path: Path) -> None:
    workspace = tmp_path / "İçerik Çalışma Alanı"

    summary = initialize_workspace(workspace, start_date=date(2026, 10, 20))

    assert summary.idea_count == 30
    assert summary.localized_count == 90
    assert summary.job_count == 360
    assert summary.account_count == 12
    assert summary.workspace == workspace
    assert (workspace / "campaign.db").is_file()
    assert (workspace / "config" / "settings.json").is_file()
    assert (workspace / "media").is_dir()


def test_first_run_is_idempotent(tmp_path: Path) -> None:
    workspace = tmp_path / "workspace"

    first = initialize_workspace(workspace, start_date=date(2026, 10, 20))
    second = initialize_workspace(workspace, start_date=date(2026, 10, 20))

    assert second == first
    with sqlite3.connect(workspace / "campaign.db") as connection:
        assert connection.execute("SELECT COUNT(*) FROM campaign").fetchone()[0] == 1
        assert connection.execute("SELECT COUNT(*) FROM account_connection").fetchone()[0] == 12
        assert connection.execute("SELECT COUNT(*) FROM publication_job").fetchone()[0] == 360
