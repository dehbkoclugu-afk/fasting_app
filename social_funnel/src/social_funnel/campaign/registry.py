"""Resolve the campaign revision currently selected by the local workspace."""

from social_funnel.domain.models import CampaignManifest
from social_funnel.storage.database import Database


class CampaignRegistry:
    def __init__(self, database: Database, fallback: CampaignManifest):
        self.db = database
        self.fallback = fallback

    def active_manifest(self) -> CampaignManifest:
        row = self.db.connection.execute(
            """SELECT r.manifest_json FROM active_campaign_revision a
            JOIN campaign_revision r ON r.id=a.revision_id WHERE a.singleton=1"""
        ).fetchone()
        return CampaignManifest.model_validate_json(row[0]) if row else self.fallback

    def active_month(self) -> str | None:
        row = self.db.connection.execute(
            """SELECT r.target_month FROM active_campaign_revision a
            JOIN campaign_revision r ON r.id=a.revision_id WHERE a.singleton=1"""
        ).fetchone()
        return row[0] if row else None
