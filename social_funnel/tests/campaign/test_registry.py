import json
from datetime import date
from pathlib import Path

from fastapi.testclient import TestClient

from social_funnel.campaign.expansion import AccountConfig
from social_funnel.campaign.registry import CampaignRegistry
from social_funnel.campaign.service import CampaignRefreshService
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRevisionRepository, MediaImportRepository
from social_funnel.web.app import WebSettings, create_app


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def accounts() -> tuple[AccountConfig, ...]:
    return tuple(
        AccountConfig(id=f"{locale.value}-{platform.value}", locale=locale, platform=platform,
                      automation_mode=AutomationMode.APPROVAL)
        for locale in LocaleCode for platform in Platform
    )


def monthly_package(tmp_path: Path) -> Path:
    manifest = json.loads(CATALOG.read_text(encoding="utf-8"))
    manifest["slug"] = "fasttrack-november-2026-11"
    manifest["title"] = "FastTrack November Campaign"
    path = tmp_path / "november.json"
    path.write_text(json.dumps({"month": "2026-11", "manifest": manifest}, ensure_ascii=False), encoding="utf-8")
    return path


def test_registry_uses_fallback_then_restores_active_revision_after_restart(tmp_path: Path) -> None:
    db = Database.open(tmp_path / "campaign.db")
    fallback = load_campaign(CATALOG)
    registry = CampaignRegistry(db, fallback)
    assert registry.active_manifest().slug == fallback.slug
    result = CampaignRefreshService(db, tmp_path).preflight(monthly_package(tmp_path))
    CampaignRefreshService(db, tmp_path).activate(result.revision_id, accounts())
    db.close()

    reopened = Database.open(tmp_path / "campaign.db")
    restored = CampaignRegistry(reopened, fallback)
    assert restored.active_manifest().slug == "fasttrack-november-2026-11"
    assert restored.active_month() == "2026-11"


def test_web_and_media_workspace_follow_active_campaign_scope(tmp_path: Path) -> None:
    app = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    old_slug = app.state.registry.active_manifest().slug
    media = MediaImportRepository(app.state.database)
    media.create_batch("old-media", old_slug, "old-checksum")
    media.activate(old_slug, "old-media")
    result = CampaignRefreshService(app.state.database, tmp_path).preflight(monthly_package(tmp_path))
    CampaignRefreshService(app.state.database, tmp_path).activate(result.revision_id, accounts())

    restarted = create_app(WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)))
    client = TestClient(restarted)
    assert "FastTrack November Campaign" in client.get("/").text
    media_page = client.get("/media").text
    assert "old-media" not in media_page
    assert restarted.state.registry.active_manifest().slug == "fasttrack-november-2026-11"
    assert CampaignRevisionRepository(restarted.state.database).active()["target_month"] == "2026-11"
