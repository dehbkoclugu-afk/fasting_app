"""Validated, immutable monthly campaign package contracts."""

import json
from pathlib import Path

from pydantic import BaseModel, ConfigDict, Field

from social_funnel.content.loader import validate_campaign_counts
from social_funnel.domain.models import CampaignManifest
from social_funnel.validation.rules import CLAIM_PATTERNS


class CampaignPackage(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")

    month: str = Field(pattern=r"^\d{4}-(0[1-9]|1[0-2])$")
    manifest: CampaignManifest


def load_campaign_package(path: Path) -> CampaignPackage:
    try:
        payload = json.loads(Path(path).read_text(encoding="utf-8"))
        return CampaignPackage.model_validate(payload)
    except (OSError, json.JSONDecodeError, ValueError) as exc:
        raise ValueError(f"Invalid campaign package month or JSON: {exc}") from None


def validate_campaign_package(package: CampaignPackage) -> None:
    manifest = package.manifest
    validate_campaign_counts(manifest)
    if not manifest.slug.endswith(package.month):
        raise ValueError("Campaign slug must end with the package month.")

    video_days = 0
    allowed_formats = {"video", "image", "carousel"}
    for idea in manifest.ideas:
        formats = {item.preferred_format for item in idea.localized}
        if len(formats) != 1 or not formats <= allowed_formats:
            raise ValueError(f"Day {idea.day} locales must use the same format.")
        if formats == {"video"}:
            video_days += 1
        for item in idea.localized:
            copy = " ".join((item.hook, item.body, item.cta))
            for code, pattern in CLAIM_PATTERNS.items():
                if pattern.search(copy):
                    raise ValueError(f"{code}: prohibited campaign copy on day {idea.day}.")
    if video_days != 10:
        raise ValueError(f"Campaign must contain exactly 10 video days; found {video_days}.")
