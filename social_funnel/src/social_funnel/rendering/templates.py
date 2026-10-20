"""Shared campaign palette and source artwork routing."""

from pathlib import Path


ASSET_ROOT = Path(__file__).parents[3] / "assets"
ARTWORK = ASSET_ROOT / "artwork"
PALETTE = {"ink": "#20332B", "cream": "#F6F1E8", "sage": "#66806C", "coral": "#C98D78"}


def artwork_for_day(day: int) -> Path:
    stage = "awareness" if day <= 7 else "activation" if day <= 14 else "habit" if day <= 21 else "trust_conversion"
    return ARTWORK / f"{stage}.png"
