"""Validate, reconcile, and publish one job without duplicate sends."""

import re
from datetime import datetime, timedelta, timezone
from pathlib import Path
from typing import Mapping

from social_funnel.domain.models import (
    AutomationMode, CampaignManifest, JobState, LocalizedContent, MediaAsset, Platform, PublicationJob,
)
from social_funnel.domain.publishing import Publisher
from social_funnel.media.resolver import MediaResolver
from social_funnel.storage.repositories import JobRepository
from social_funnel.validation.service import validate_job


def _redact(message: str) -> str:
    message = re.sub(r"(?i)(access_token|client_secret|authorization)[=: ]+[^\s&]+", r"\1=[REDACTED]", message)
    message = re.sub(r"https?://[^\s]+\?[^\s]+", "[SIGNED_URL_REDACTED]", message)
    return message[:500]


class PublishingOrchestrator:
    def __init__(self, jobs: JobRepository, campaign: CampaignManifest,
                 publishers: Mapping[Platform | str, Publisher], media_root: Path, *, campaign_locked: bool = False,
                 max_attempts: int = 4, media_resolver: MediaResolver | None = None):
        self.jobs = jobs
        self.campaign = campaign
        self.publishers = publishers
        self.media_root = media_root
        self.campaign_locked = campaign_locked
        self.max_attempts = max_attempts
        self.media_resolver = media_resolver or MediaResolver(None, campaign, media_root)
        self._asset_cache: dict[str, MediaAsset | None] = {}

    def _publisher(self, job: PublicationJob) -> Publisher | None:
        return self.publishers.get(job.account_id) or self.publishers.get(job.platform)

    def _content(self, job: PublicationJob) -> LocalizedContent:
        return next(item for item in self.campaign.ideas[job.day - 1].localized if item.locale == job.locale)

    def _render(self, job: PublicationJob, content: LocalizedContent) -> MediaAsset | None:
        if job.id in self._asset_cache:
            return self._asset_cache[job.id]
        asset = self.media_resolver.resolve(job, content)
        self._asset_cache[job.id] = asset
        return asset

    def _valid(self, job: PublicationJob) -> bool:
        content = self._content(job)
        try:
            asset = self._render(job, content)
            issues = validate_job(job, content, asset)
        except (FileNotFoundError, ValueError) as exc:
            self.jobs.set_result(job.id, error=_redact(str(exc)))
            return False
        errors = [issue.message for issue in issues if issue.severity == "error"]
        if errors:
            self.jobs.set_result(job.id, error="; ".join(errors))
            return False
        return True

    def prepare(self, job_id: str) -> bool:
        job = self.jobs.get(job_id)
        if job.state != JobState.DRAFT or not self._valid(job):
            return False
        if not self.jobs.transition(job_id, JobState.DRAFT, JobState.NEEDS_REVIEW):
            return False
        if job.automation_mode == AutomationMode.AUTOMATIC and self.campaign_locked:
            return self.approve(job_id)
        return True

    def approve(self, job_id: str) -> bool:
        job = self.jobs.get(job_id)
        if job.state != JobState.NEEDS_REVIEW or not self._valid(job):
            return False
        return (self.jobs.transition(job_id, JobState.NEEDS_REVIEW, JobState.APPROVED)
                and self.jobs.transition(job_id, JobState.APPROVED, JobState.SCHEDULED))

    def process(self, job_id: str) -> bool:
        job = self.jobs.get(job_id)
        if job.state != JobState.SCHEDULED:
            return False
        if not self._valid(job):
            self.jobs.transition(job_id, JobState.SCHEDULED, JobState.DISABLED)
            return False
        if not self.jobs.transition(job_id, JobState.SCHEDULED, JobState.UPLOADING):
            return False
        publisher = self._publisher(job)
        if publisher is None:
            self.jobs.set_result(job_id, error="Destination is not connected")
            self.jobs.transition(job_id, JobState.UPLOADING, JobState.FAILED)
            return False
        try:
            existing = publisher.lookup_by_idempotency_key(job.idempotency_key)
            if existing and existing.status == "published" and existing.remote_id:
                self.jobs.set_result(job_id, remote_id=existing.remote_id)
                self.jobs.record_attempt(job_id, "reconciled", existing.remote_id, "existing remote post", 0)
                return self.jobs.transition(job_id, JobState.UPLOADING, JobState.PUBLISHED)
            if existing and existing.status in {"processing", "awaiting_creator_review"} and existing.remote_id:
                self.jobs.set_result(job_id, remote_id=existing.remote_id)
                return self.jobs.transition(job_id, JobState.UPLOADING, JobState.PROCESSING)
            content = self._content(job)
            asset = self._render(job, content)
            result = publisher.publish(job, asset.path if asset else None)
        except Exception as exc:
            # A lost publish response cannot be proved absent via a generic API lookup.
            # Fail closed: a human reconciles this job instead of risking a duplicate.
            diagnostic = "Unknown publish outcome; check the destination before retrying. " + _redact(str(exc))
            self.jobs.record_attempt(job_id, "unknown_outcome", None, diagnostic, self.jobs.attempt_count(job_id) + 1)
            self.jobs.set_result(job_id, error=diagnostic)
            self.jobs.transition(job_id, JobState.UPLOADING, JobState.FAILED)
            return False
        attempt = self.jobs.attempt_count(job_id) + 1
        diagnostic = _redact(result.message)
        self.jobs.record_attempt(job_id, result.status, result.remote_id, diagnostic, attempt)
        if result.status == "published" and result.remote_id:
            self.jobs.set_result(job_id, remote_id=result.remote_id)
            return self.jobs.transition(job_id, JobState.UPLOADING, JobState.PUBLISHED)
        if result.status in {"processing", "awaiting_creator_review"} and result.remote_id:
            self.jobs.set_result(job_id, remote_id=result.remote_id)
            return self.jobs.transition(job_id, JobState.UPLOADING, JobState.PROCESSING)
        if result.retryable and result.remote_id:
            self.jobs.set_result(job_id, remote_id=result.remote_id,
                                 error="Partial or pending remote publication; reconcile before retrying.")
            self.jobs.transition(job_id, JobState.UPLOADING, JobState.FAILED)
            return False
        if result.retryable:
            return self._retry(job_id, result.status, diagnostic, already_recorded=True)
        self.jobs.set_result(job_id, error=diagnostic or result.status)
        self.jobs.transition(job_id, JobState.UPLOADING, JobState.FAILED)
        return False

    def _retry(self, job_id: str, outcome: str, diagnostic: str, *, already_recorded: bool = False) -> bool:
        attempt = self.jobs.attempt_count(job_id) + (0 if already_recorded else 1)
        if not already_recorded:
            self.jobs.record_attempt(job_id, outcome, None, diagnostic, attempt)
        if attempt >= self.max_attempts:
            self.jobs.set_result(job_id, error=diagnostic)
            self.jobs.transition(job_id, JobState.UPLOADING, JobState.FAILED)
            return False
        delay = min(3600, 30 * (2 ** max(0, attempt - 1)))
        self.jobs.set_result(job_id, next_attempt_at=datetime.now(timezone.utc) + timedelta(seconds=delay),
                             error=diagnostic)
        self.jobs.transition(job_id, JobState.UPLOADING, JobState.SCHEDULED)
        return False

    def recover_inflight(self) -> None:
        """Reconcile interrupted sends before making them eligible for retry."""
        for job in self.jobs.list_inflight():
            publisher = self._publisher(job)
            if publisher is None:
                continue
            try:
                found = publisher.lookup_by_idempotency_key(job.idempotency_key)
            except Exception:
                continue
            if found and found.status == "published" and found.remote_id:
                self.jobs.set_result(job.id, remote_id=found.remote_id)
                self.jobs.transition(job.id, job.state, JobState.PUBLISHED)
            elif found and found.status in {"processing", "awaiting_creator_review"}:
                if job.state == JobState.UPLOADING:
                    self.jobs.transition(job.id, JobState.UPLOADING, JobState.PROCESSING)
            elif found and not found.retryable:
                diagnostic = _redact(found.message or found.status)
                self.jobs.set_result(job.id, remote_id=found.remote_id or job.remote_id, error=diagnostic)
                self.jobs.transition(job.id, job.state, JobState.FAILED)
            elif found is None:
                self.jobs.set_result(job.id, error="Interrupted publish; verify remote destination manually.")
                self.jobs.transition(job.id, job.state, JobState.FAILED)
