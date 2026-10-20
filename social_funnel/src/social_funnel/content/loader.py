"""Load and check the complete campaign before it enters storage."""

import json
from pathlib import Path

from social_funnel.domain.models import CampaignManifest, LocaleCode


def load_campaign(path: Path) -> CampaignManifest:
    return CampaignManifest.model_validate(json.loads(path.read_text(encoding="utf-8")))


def validate_campaign_counts(manifest: CampaignManifest) -> None:
    if len(manifest.ideas) != 30:
        raise ValueError(f"expected 30 ideas, found {len(manifest.ideas)}")
    if [idea.day for idea in manifest.ideas] != list(range(1, 31)):
        raise ValueError("campaign days must be unique and ordered from 1 to 30")
    expected_stages = (["awareness"] * 7 + ["activation"] * 7 + ["habit"] * 7 + ["trust_conversion"] * 9)
    if [idea.funnel_stage for idea in manifest.ideas] != expected_stages:
        raise ValueError("funnel stages do not match the approved 7/7/7/9 sequence")
    for idea in manifest.ideas:
        if len(idea.localized) != 3 or {unit.locale for unit in idea.localized} != set(LocaleCode):
            raise ValueError(f"day {idea.day} needs exactly tr, en, and pt-BR")
        if any(unit.day != idea.day or not unit.hashtags for unit in idea.localized):
            raise ValueError(f"day {idea.day} has incomplete localization")
