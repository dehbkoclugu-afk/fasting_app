from pathlib import Path

import pytest

from social_funnel.content.loader import load_campaign, validate_campaign_counts
from social_funnel.domain.models import LocaleCode


CATALOG = Path(__file__).resolve().parents[2] / "content" / "fasttrack-30-day-launch.json"


def test_catalog_has_thirty_unique_days_and_ninety_localized_units() -> None:
    campaign = load_campaign(CATALOG)
    validate_campaign_counts(campaign)

    assert [idea.day for idea in campaign.ideas] == list(range(1, 31))
    assert sum(len(idea.localized) for idea in campaign.ideas) == 90
    assert [idea.funnel_stage for idea in campaign.ideas] == (
        ["awareness"] * 7
        + ["activation"] * 7
        + ["habit"] * 7
        + ["trust_conversion"] * 9
    )


def test_each_day_has_three_usable_localizations() -> None:
    campaign = load_campaign(CATALOG)
    for idea in campaign.ideas:
        assert {unit.locale for unit in idea.localized} == set(LocaleCode)
        for unit in idea.localized:
            assert unit.day == idea.day
            assert unit.hook.strip() and unit.body.strip() and unit.cta.strip()
            assert unit.hashtags


def test_first_day_is_native_in_turkish_and_brazilian_portuguese() -> None:
    campaign = load_campaign(CATALOG)
    first = {unit.locale: unit for unit in campaign.ideas[0].localized}

    assert first[LocaleCode.TR].hook == "İlk haftanı sakin başlat"
    assert first[LocaleCode.PT_BR].hook == "Comece sua rotina com calma"


def test_missing_locale_is_rejected(tmp_path: Path) -> None:
    import json

    payload = json.loads(CATALOG.read_text(encoding="utf-8"))
    payload["ideas"][0]["localized"].pop()
    broken = tmp_path / "campaign.json"
    broken.write_text(json.dumps(payload, ensure_ascii=False), encoding="utf-8")

    with pytest.raises(ValueError, match="day 1"):
        validate_campaign_counts(load_campaign(broken))
