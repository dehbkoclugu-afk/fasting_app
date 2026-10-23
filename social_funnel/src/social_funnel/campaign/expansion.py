"""Stable publication jobs from a reviewed campaign manifest."""

from dataclasses import dataclass
from datetime import date, datetime, time, timedelta, timezone
from hashlib import sha256
from zoneinfo import ZoneInfo

from social_funnel.domain.models import (
    AutomationMode, CampaignManifest, JobState, LocaleCode, Platform, PublicationJob,
)

MARKET_SCHEDULES = {
    LocaleCode.TR: ("Europe/Istanbul", time(20, 30)),
    LocaleCode.EN: ("America/New_York", time(18, 0)),
    LocaleCode.PT_BR: ("America/Sao_Paulo", time(19, 30)),
}


@dataclass(frozen=True)
class AccountConfig:
    id: str
    locale: LocaleCode
    platform: Platform
    automation_mode: AutomationMode = AutomationMode.APPROVAL
    enabled: bool = True
    timezone: str | None = None
    publish_time: time | None = None


def expand_publication_jobs(
    manifest: CampaignManifest, accounts: tuple[AccountConfig, ...], start_date: date,
    *, content_revision: int = 1, local_publish_time: time | None = None,
) -> tuple[PublicationJob, ...]:
    """Convert each local campaign day to UTC after choosing that day's wall time."""
    if len({account.id for account in accounts}) != len(accounts):
        raise ValueError("account IDs must be unique")
    jobs = []
    for idea in manifest.ideas:
        day = start_date + timedelta(days=idea.day - 1)
        for content in idea.localized:
            for account in accounts:
                if not account.enabled or account.locale != content.locale:
                    continue
                default_zone, default_time = MARKET_SCHEDULES[content.locale]
                zone = ZoneInfo(account.timezone or default_zone)
                wall_time = account.publish_time or local_publish_time or default_time
                scheduled = datetime.combine(day, wall_time, tzinfo=zone).astimezone(timezone.utc)
                source = "|".join((manifest.slug, str(idea.day), content.locale.value,
                                   account.platform.value, account.id, str(content_revision)))
                key = sha256(source.encode("utf-8")).hexdigest()
                initial_state = (
                    JobState.DISABLED
                    if account.platform == Platform.TIKTOK and content.preferred_format != "video"
                    else JobState.DRAFT
                )
                jobs.append(PublicationJob(
                    id=key[:32], campaign_slug=manifest.slug, day=idea.day,
                    locale=content.locale, platform=account.platform, account_id=account.id,
                    automation_mode=account.automation_mode, state=initial_state,
                    scheduled_at=scheduled, idempotency_key=key,
                    content_revision=content_revision,
                ))
    return tuple(jobs)
