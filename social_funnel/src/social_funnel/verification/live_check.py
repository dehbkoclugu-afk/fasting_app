"""Prepare one exact destination for review without performing a live send."""

from __future__ import annotations

from dataclasses import dataclass
import json

from social_funnel.domain.models import JobState, LocaleCode, MediaAsset, Platform
from social_funnel.storage.repositories import CampaignRepository, JobRepository
from social_funnel.validation.service import ValidationIssue, validate_job


class LiveCheckError(ValueError):
    """Raised when a job is unsafe or ambiguous for a live verification."""


@dataclass(frozen=True)
class LiveCheckSummary:
    job_id: str
    account_id: str
    public_identity: str | None
    platform: Platform
    locale: LocaleCode
    content_revision: int
    capabilities: dict[str, object]
    validation_issues: tuple[ValidationIssue, ...]
    destination_count: int = 1
    requires_confirmation: bool = True
    confirmation_timing: str = "immediately_before_send"
    send_performed: bool = False


def prepare_live_check(
    job_id: str,
    account_id: str,
    *,
    jobs: JobRepository,
    campaigns: CampaignRepository,
    asset: MediaAsset | None,
) -> LiveCheckSummary:
    """Validate a draft and pin one destination; never invoke a publisher."""
    if not isinstance(account_id, str) or not account_id.strip():
        raise LiveCheckError("A live check must select exactly one destination account")

    job = jobs.get(job_id)
    if job.state != JobState.DRAFT:
        raise LiveCheckError("Only a draft job can start a live check")
    if job.account_id != account_id:
        raise LiveCheckError("Selected account does not match the job destination")

    row = jobs.db.connection.execute(
        """SELECT id, platform, locale, public_identity, capabilities_json, enabled
        FROM account_connection WHERE id=?""",
        (account_id,),
    ).fetchone()
    if row is None or not row["enabled"]:
        raise LiveCheckError("Selected destination account is missing or disabled")
    if row["platform"] != job.platform.value or row["locale"] != job.locale.value:
        raise LiveCheckError("Selected account does not match the job platform and locale")

    manifest = campaigns.get_manifest(job.campaign_slug)
    content = next(
        (
            localized
            for idea in manifest.ideas
            if idea.day == job.day
            for localized in idea.localized
            if localized.locale == job.locale
        ),
        None,
    )
    if content is None:
        raise LiveCheckError("The exact localized content revision cannot be resolved")

    issues = validate_job(job, content, asset)
    if any(issue.severity == "error" for issue in issues):
        codes = ", ".join(issue.code for issue in issues)
        raise LiveCheckError(f"Live-check validation failed: {codes}")

    try:
        capabilities = json.loads(row["capabilities_json"])
    except (TypeError, json.JSONDecodeError) as exc:
        raise LiveCheckError("Destination capabilities are unreadable") from exc

    return LiveCheckSummary(
        job_id=job.id,
        account_id=row["id"],
        public_identity=row["public_identity"],
        platform=job.platform,
        locale=job.locale,
        content_revision=job.content_revision,
        capabilities=capabilities,
        validation_issues=issues,
    )
