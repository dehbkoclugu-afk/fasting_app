"""Return every actionable preflight issue in one pass."""

from dataclasses import dataclass
from pathlib import Path

from social_funnel.domain.models import LocalizedContent, MediaAsset, Platform, PublicationJob
from social_funnel.validation.rules import CLAIM_PATTERNS, LANGUAGE_MARKERS


@dataclass(frozen=True)
class ValidationIssue:
    code: str
    severity: str
    message: str
    field: str


def validate_job(
    job: PublicationJob, content: LocalizedContent, asset: MediaAsset | None,
    *, screenshot_path: Path | None = None, font_path: Path | None = None,
    recently_published_hashes: set[str] | None = None,
) -> tuple[ValidationIssue, ...]:
    issues: list[ValidationIssue] = []

    def add(code: str, message: str, field: str, severity: str = "error") -> None:
        issues.append(ValidationIssue(code, severity, message, field))

    if content.locale != job.locale or content.day != job.day:
        add("wrong_locale", "Content locale/day does not match the destination.", "locale")
    all_copy = " ".join((content.hook, content.body, content.cta))
    for code, pattern in CLAIM_PATTERNS.items():
        if pattern.search(all_copy):
            add(code, f"Review prohibited or private wording: {code}.", "body")
    if not content.cta.strip():
        add("empty_cta", "Add a clear call to action.", "cta")
    if not LANGUAGE_MARKERS[content.locale].search(content.body):
        add("wrong_language", "Copy does not show expected language markers; review translation.", "body")
    if screenshot_path is not None and not screenshot_path.is_file():
        add("missing_screenshot", f"Screenshot not found: {screenshot_path.name}", "screenshot")
    if font_path is not None and not font_path.is_file():
        add("missing_font", f"Font not found: {font_path.name}", "font")
    if asset is None or not asset.path.is_file():
        if job.platform != Platform.THREADS:
            add("missing_media", "Render or attach media before publishing.", "media")
    else:
        if job.platform in {Platform.INSTAGRAM, Platform.FACEBOOK, Platform.THREADS} and not asset.alt_text.strip():
            add("missing_alt_text", "Add accessible media alt text.", "alt_text")
        ratio = asset.width / asset.height
        supported = (0.55 <= ratio <= 0.60) if job.platform == Platform.TIKTOK else (0.74 <= ratio <= 1.92)
        if not supported:
            add("unsupported_ratio", "Media aspect ratio is not supported for this destination.", "media")
        if asset.checksum in (recently_published_hashes or set()):
            add("duplicate_cooldown", "Identical media was recently published to this account.", "media")
    return tuple(issues)
