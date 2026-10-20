"""Stable publication jobs from a reviewed campaign manifest."""

from dataclasses import dataclass
from datetime import date, datetime, time, timedelta, timezone
from hashlib import sha256
from zoneinfo import ZoneInfo

from social_funnel.domain.models import (
    AutomationMode, CampaignManifest, JobState, LocaleCode, Platform, PublicationJob,
)


@dataclass(frozen=True)
class AccountConfig:
    id: str
    locale: LocaleCode
    platform: Platform
    automation_mode: AutomationMode = AutomationMode.APPROVAL
    enabled: bool = True


def expand_publication_jobs(
    manifest: CampaignManifest, accounts: tuple[AccountConfig, ...], start_date: date,
    *, content_revision: int = 1, local_publish_time: time = time(12, 0),
) -> tuple[PublicationJob, ...]:
    """Convert each local campaign day to UTC after choosing that day's wall time."""
    if len({account.id for account in accounts}) != len(accounts):
        raise ValueError("account IDs must be unique")
    zone = ZoneInfo(manifest.timezone)
    jobs = []
    for idea in manifest.ideas:
        day = start_date + timedelta(days=idea.day - 1)
        scheduled = datetime.combine(day, local_publish_time, tzinfo=zone).astimezone(timezone.utc)
        for content in idea.localized:
            for account in accounts:
                if not account.enabled or account.locale != content.locale:
                    continue
                source = "|".join((manifest.slug, str(idea.day), content.locale.value,
                                   account.platform.value, account.id, str(content_revision)))
                key = sha256(source.encode("utf-8")).hexdigest()
                jobs.append(PublicationJob(
                    id=key[:32], campaign_slug=manifest.slug, day=idea.day,
                    locale=content.locale, platform=account.platform, account_id=account.id,
                    automation_mode=account.automation_mode, state=JobState.DRAFT,
                    scheduled_at=scheduled, idempotency_key=key,
                    content_revision=content_revision,
                ))
    return tuple(jobs)
