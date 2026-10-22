import copy
import json
from pathlib import Path

import pytest

from social_funnel.campaign.package import load_campaign_package, validate_campaign_package


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def package_data() -> dict:
    manifest = json.loads(CATALOG.read_text(encoding="utf-8"))
    manifest["slug"] = "fasttrack-campaign-2026-11"
    return {"month": "2026-11", "manifest": manifest}


def write_package(tmp_path: Path, data: dict) -> Path:
    path = tmp_path / "campaign.json"
    path.write_text(json.dumps(data, ensure_ascii=False), encoding="utf-8")
    return path


def test_loads_valid_monthly_campaign_package(tmp_path: Path) -> None:
    package = load_campaign_package(write_package(tmp_path, package_data()))
    validate_campaign_package(package)
    assert package.month == "2026-11"
    assert package.manifest.slug == "fasttrack-campaign-2026-11"


@pytest.mark.parametrize("month", ["2026-1", "11-2026", "2026-13", ""])
def test_rejects_invalid_target_month(tmp_path: Path, month: str) -> None:
    data = package_data()
    data["month"] = month
    with pytest.raises(ValueError, match="month"):
        load_campaign_package(write_package(tmp_path, data))


def test_rejects_slug_that_does_not_end_with_month(tmp_path: Path) -> None:
    data = package_data()
    data["manifest"]["slug"] = "fasttrack-campaign"
    package = load_campaign_package(write_package(tmp_path, data))
    with pytest.raises(ValueError, match="slug"):
        validate_campaign_package(package)


def test_rejects_mixed_formats_on_one_day(tmp_path: Path) -> None:
    data = package_data()
    data["manifest"]["ideas"][0]["localized"][0]["preferred_format"] = "image"
    package = load_campaign_package(write_package(tmp_path, data))
    with pytest.raises(ValueError, match="same format"):
        validate_campaign_package(package)


def test_rejects_missing_localization(tmp_path: Path) -> None:
    data = package_data()
    data["manifest"]["ideas"][0]["localized"].pop()
    package = load_campaign_package(write_package(tmp_path, data))
    with pytest.raises(ValueError, match="exactly tr, en, and pt-BR"):
        validate_campaign_package(package)


def test_rejects_any_count_other_than_ten_video_days(tmp_path: Path) -> None:
    data = package_data()
    for item in data["manifest"]["ideas"][0]["localized"]:
        item["preferred_format"] = "image"
    package = load_campaign_package(write_package(tmp_path, data))
    with pytest.raises(ValueError, match="10 video days"):
        validate_campaign_package(package)


@pytest.mark.parametrize(
    ("field", "value", "message"),
    [
        ("body", "This routine cures diabetes.", "medical_claim"),
        ("cta", "Open C:\\private\\campaign.txt", "local_path_leak"),
    ],
)
def test_rejects_unsafe_or_wrong_language_copy(
    tmp_path: Path, field: str, value: str, message: str,
) -> None:
    data = copy.deepcopy(package_data())
    data["manifest"]["ideas"][0]["localized"][0][field] = value
    package = load_campaign_package(write_package(tmp_path, data))
    with pytest.raises(ValueError, match=message):
        validate_campaign_package(package)


