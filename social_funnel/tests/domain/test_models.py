from datetime import UTC, datetime

import pytest
from pydantic import ValidationError

from social_funnel.domain.models import (
    ALLOWED_TRANSITIONS,
    AutomationMode,
    JobState,
    LocaleCode,
    Platform,
    PublicationJob,
    can_transition,
)


def _job_payload() -> dict[str, object]:
    return {
        "id": "job-1",
        "campaign_slug": "fasttrack-30-day-launch",
        "day": 1,
        "locale": "tr",
        "platform": "instagram",
        "account_id": "instagram-tr",
        "automation_mode": "approval",
        "state": "draft",
        "scheduled_at": datetime(2026, 10, 21, 9, 0, tzinfo=UTC),
        "idempotency_key": "stable-key",
        "content_revision": 1,
    }


def test_supported_locales_are_fixed() -> None:
    assert [locale.value for locale in LocaleCode] == ["tr", "en", "pt-BR"]


def test_supported_platforms_are_fixed() -> None:
    assert [platform.value for platform in Platform] == [
        "instagram",
        "facebook",
        "tiktok",
        "threads",
    ]


def test_draft_cannot_transition_directly_to_published() -> None:
    assert JobState.PUBLISHED not in ALLOWED_TRANSITIONS[JobState.DRAFT]
    assert can_transition(JobState.DRAFT, JobState.PUBLISHED) is False


def test_publication_job_requires_idempotency_key() -> None:
    payload = _job_payload()
    payload.pop("idempotency_key")

    with pytest.raises(ValidationError):
        PublicationJob.model_validate(payload)


def test_publication_job_is_frozen() -> None:
    job = PublicationJob.model_validate(_job_payload())

    with pytest.raises(ValidationError):
        job.state = JobState.APPROVED


def test_automation_modes_are_explicit() -> None:
    assert {mode.value for mode in AutomationMode} == {"approval", "automatic"}
