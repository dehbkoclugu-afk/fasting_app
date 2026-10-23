from pathlib import Path

from social_funnel.storage.database import Database
from social_funnel.storage.repositories import CampaignRevisionRepository


def test_campaign_revision_schema_is_additive_and_supports_rollback(tmp_path: Path) -> None:
    db = Database.open(tmp_path / "campaign.db")
    repo = CampaignRevisionRepository(db)
    repo.add("rev-one", "2026-11", "campaign-2026-11", "sha-one", "{}", "one.json")
    repo.add("rev-two", "2026-12", "campaign-2026-12", "sha-two", "{}", "two.json")
    repo.activate("rev-one")
    repo.activate("rev-two")
    assert repo.active()["id"] == "rev-two"
    assert repo.rollback()
    assert repo.active()["id"] == "rev-one"
    db.close()
    reopened = Database.open(tmp_path / "campaign.db")
    assert CampaignRevisionRepository(reopened).active()["id"] == "rev-one"


def test_revision_checksum_is_idempotent(tmp_path: Path) -> None:
    db = Database.open(tmp_path / "campaign.db")
    repo = CampaignRevisionRepository(db)
    repo.add("rev-one", "2026-11", "campaign-2026-11", "same", "{}", "one.json")
    repo.add("rev-two", "2026-11", "campaign-2026-11", "same", "{}", "two.json")
    assert len(repo.list()) == 1
    assert repo.find_by_checksum("same")["id"] == "rev-one"
