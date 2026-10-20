"""Small immutable contracts shared by campaign and publisher components."""

from datetime import datetime
from enum import StrEnum
from pathlib import Path

from pydantic import BaseModel, ConfigDict, Field


class LocaleCode(StrEnum):
    TR = "tr"
    EN = "en"
    PT_BR = "pt-BR"


class Platform(StrEnum):
    INSTAGRAM = "instagram"
    FACEBOOK = "facebook"
    TIKTOK = "tiktok"
    THREADS = "threads"


class AutomationMode(StrEnum):
    APPROVAL = "approval"
    AUTOMATIC = "automatic"


class JobState(StrEnum):
    DRAFT = "draft"
    NEEDS_REVIEW = "needs_review"
    APPROVED = "approved"
    SCHEDULED = "scheduled"
    UPLOADING = "uploading"
    PROCESSING = "processing"
    PUBLISHED = "published"
    REJECTED = "rejected"
    DISABLED = "disabled"
    FAILED = "failed"


ALLOWED_TRANSITIONS: dict[JobState, frozenset[JobState]] = {
    JobState.DRAFT: frozenset({JobState.NEEDS_REVIEW, JobState.DISABLED}),
    JobState.NEEDS_REVIEW: frozenset({JobState.APPROVED, JobState.REJECTED, JobState.DISABLED}),
    JobState.APPROVED: frozenset({JobState.SCHEDULED, JobState.DISABLED}),
    JobState.SCHEDULED: frozenset({JobState.UPLOADING, JobState.DISABLED}),
    JobState.UPLOADING: frozenset({JobState.PROCESSING, JobState.PUBLISHED, JobState.SCHEDULED, JobState.FAILED}),
    JobState.PROCESSING: frozenset({JobState.PUBLISHED, JobState.SCHEDULED, JobState.FAILED}),
    JobState.PUBLISHED: frozenset(),
    JobState.REJECTED: frozenset({JobState.NEEDS_REVIEW}),
    JobState.DISABLED: frozenset({JobState.NEEDS_REVIEW}),
    JobState.FAILED: frozenset({JobState.NEEDS_REVIEW, JobState.SCHEDULED}),
}


def can_transition(current: JobState, target: JobState) -> bool:
    return target in ALLOWED_TRANSITIONS[current]


class FrozenModel(BaseModel):
    model_config = ConfigDict(frozen=True, extra="forbid")


class LocalizedContent(FrozenModel):
    day: int = Field(ge=1, le=30)
    locale: LocaleCode
    hook: str = Field(min_length=1)
    body: str = Field(min_length=1)
    cta: str = Field(min_length=1)
    hashtags: tuple[str, ...] = ()
    safety_note: str = ""
    preferred_format: str = "image"
    platform_overrides: dict[Platform, str] = Field(default_factory=dict)


class ContentIdea(FrozenModel):
    day: int = Field(ge=1, le=30)
    funnel_stage: str
    theme: str
    purpose: str
    localized: tuple[LocalizedContent, ...]


class CampaignManifest(FrozenModel):
    slug: str = Field(min_length=1)
    title: str = Field(min_length=1)
    timezone: str = "Europe/Istanbul"
    ideas: tuple[ContentIdea, ...]


class PublicationJob(FrozenModel):
    id: str
    campaign_slug: str
    day: int = Field(ge=1, le=30)
    locale: LocaleCode
    platform: Platform
    account_id: str
    automation_mode: AutomationMode
    state: JobState
    scheduled_at: datetime
    idempotency_key: str = Field(min_length=1)
    content_revision: int = Field(ge=1)


class MediaAsset(FrozenModel):
    path: Path
    width: int = Field(gt=0)
    height: int = Field(gt=0)
    checksum: str
    mime_type: str
    alt_text: str = ""


class PublishResult(FrozenModel):
    remote_id: str | None = None
    status: str
    retryable: bool = False
    message: str = ""
