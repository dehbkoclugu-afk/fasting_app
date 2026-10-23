from datetime import date, datetime, timezone
from pathlib import Path

from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, Platform
from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def accounts():
    return tuple(
        AccountConfig(id=f"{locale.value}-{platform.value}", locale=locale, platform=platform,
                      automation_mode=AutomationMode.AUTOMATIC if locale == LocaleCode.EN else AutomationMode.APPROVAL)
        for locale in LocaleCode for platform in Platform
    )


def test_expands_twelve_destinations_to_360_stable_jobs():
    manifest = load_campaign(CATALOG)
    first = expand_publication_jobs(manifest, accounts(), date(2026, 10, 20))
    second = expand_publication_jobs(manifest, accounts(), date(2026, 10, 20))
    assert len(first) == 360
    assert len({job.idempotency_key for job in first}) == 360
    assert [job.idempotency_key for job in first] == [job.idempotency_key for job in second]
    assert sum(job.automation_mode == AutomationMode.AUTOMATIC for job in first) == 120
    assert first[0].scheduled_at == datetime(2026, 10, 20, 17, 30, tzinfo=timezone.utc)
    english_day_one = next(
        job for job in first
        if job.locale == LocaleCode.EN and job.platform == Platform.INSTAGRAM and job.day == 1
    )
    brazil_day_one = next(
        job for job in first
        if job.locale == LocaleCode.PT_BR and job.platform == Platform.INSTAGRAM and job.day == 1
    )
    english_after_dst = next(
        job for job in first
        if job.locale == LocaleCode.EN and job.platform == Platform.INSTAGRAM and job.day == 30
    )
    assert english_day_one.scheduled_at == datetime(2026, 10, 20, 22, tzinfo=timezone.utc)
    assert brazil_day_one.scheduled_at == datetime(2026, 10, 20, 22, 30, tzinfo=timezone.utc)
    assert english_after_dst.scheduled_at == datetime(2026, 11, 18, 23, tzinfo=timezone.utc)
    assert sum(job.state == JobState.DISABLED for job in first) == 60
    assert all(
        job.state == (
            JobState.DRAFT
            if manifest.ideas[job.day - 1].localized[0].preferred_format == "video"
            else JobState.DISABLED
        )
        for job in first if job.platform == Platform.TIKTOK and job.locale == LocaleCode.TR
    )


def test_disabled_destination_does_not_expand():
    jobs = expand_publication_jobs(load_campaign(CATALOG), accounts()[:-1], date(2026, 10, 20))
    assert len(jobs) == 330
