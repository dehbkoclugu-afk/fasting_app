"""Conservative TikTok review-upload and audited direct-post policy."""

from collections.abc import Callable
from datetime import datetime, timezone
from pathlib import Path
from urllib.parse import urlparse

from social_funnel.domain.models import LocalizedContent, PublicationJob, PublishResult
from social_funnel.publishing.tiktok.errors import TikTokApiError
from social_funnel.publishing.tiktok.uploads import upload_video_file


class TikTokPublisher:
    def __init__(self, client, *, content_lookup: Callable[[PublicationJob], LocalizedContent],
                 upload: Callable[[str, Path], None] | None = None,
                 media_url: Callable[[Path], str] | None = None,
                 verified_media_host: str | None = None, audited: bool = False,
                 direct_post: bool = False, privacy_level: str = "SELF_ONLY"):
        self.client = client
        self.content_lookup = content_lookup
        self.upload = upload or (lambda url, path: upload_video_file(client.http, url, path))
        self.media_url = media_url
        self.verified_media_host = verified_media_host
        self.audited = audited
        self.direct_post = direct_post
        self.privacy_level = privacy_level
        self._consent: dict[tuple[str, int], datetime] = {}
        self._sent: dict[str, str] = {}
        self._modes: dict[str, bool] = {}

    def record_consent(self, job_id: str, content_revision: int, at: datetime) -> None:
        if at.tzinfo is None:
            raise ValueError("Consent timestamp must be timezone-aware")
        self._consent[(job_id, content_revision)] = at

    def capabilities(self, account_id: str) -> dict:
        return {"account_id": account_id, "review_upload": True,
                "direct_public": self.audited and self.direct_post,
                "verified_photo_host": bool(self.verified_media_host)}

    def lookup_by_idempotency_key(self, key: str) -> PublishResult | None:
        publish_id = self._sent.get(key)
        if not publish_id:
            return None
        try:
            status = self.client.fetch_status(publish_id)
        except TikTokApiError as exc:
            return PublishResult(remote_id=publish_id, status=exc.category, retryable=exc.retryable)
        if status.get("status") == "PUBLISH_COMPLETE":
            ids = status.get("publicaly_available_post_id", [])
            return PublishResult(remote_id=str(ids[0]) if ids else publish_id, status="published")
        if status.get("status") == "SEND_TO_USER_INBOX":
            return PublishResult(remote_id=publish_id, status="awaiting_creator_review")
        if status.get("status") == "FAILED":
            return PublishResult(remote_id=publish_id, status="failed", message=status.get("fail_reason", "failed"))
        return PublishResult(remote_id=publish_id, status="processing")

    def publish(self, job: PublicationJob, asset_path: Path | None) -> PublishResult:
        if (job.id, job.content_revision) not in self._consent:
            return PublishResult(status="consent_required", message="Approve this exact TikTok content revision before upload")
        if asset_path is None or not asset_path.is_file():
            return PublishResult(status="missing_media", message="TikTok upload needs rendered media")
        existing = self.lookup_by_idempotency_key(job.idempotency_key)
        if existing:
            return existing
        direct = self.audited and self.direct_post
        if self.direct_post and not self.audited:
            return PublishResult(status="audit_required", message="Public direct posting requires TikTok client audit")
        creator = None
        if direct:
            try:
                creator = self.client.query_creator_info()
            except TikTokApiError as exc:
                return PublishResult(status=exc.category, retryable=exc.retryable, message=exc.category)
            if self.privacy_level not in creator.get("privacy_level_options", []):
                return PublishResult(status="privacy_unavailable", message="Re-select an allowed creator privacy option")
        content = self.content_lookup(job)
        caption = " ".join((content.hook, content.cta, *content.hashtags))
        post_info = {"title": caption[:2200], "privacy_level": self.privacy_level,
                     "disable_comment": bool(creator and creator.get("comment_disabled")),
                     "disable_duet": bool(creator and creator.get("duet_disabled")),
                     "disable_stitch": bool(creator and creator.get("stitch_disabled")),
                     "brand_organic_toggle": True, "is_aigc": True}
        try:
            if asset_path.suffix.lower() == ".mp4":
                size = asset_path.stat().st_size
                chunk_size = min(size, 10_000_000)
                source = {"source": "FILE_UPLOAD", "video_size": size,
                          "chunk_size": chunk_size, "total_chunk_count": (size + chunk_size - 1) // chunk_size}
                initialized = self.client.init_video(review=not direct, source_info=source, post_info=post_info)
                self._sent[job.idempotency_key] = initialized["publish_id"]
                self._modes[job.idempotency_key] = direct
                self.upload(initialized["upload_url"], asset_path)
            else:
                if self.media_url is None or not self.verified_media_host:
                    return PublishResult(status="unverified_media_host", message="Verify a public photo domain first")
                url = self.media_url(asset_path)
                parsed = urlparse(url)
                if parsed.scheme != "https" or parsed.hostname != self.verified_media_host:
                    return PublishResult(status="unverified_media_host", message="Photo URL is outside the verified domain")
                initialized = self.client.init_photo(review=not direct, photo_urls=(url,), post_info=post_info)
                self._sent[job.idempotency_key] = initialized["publish_id"]
                self._modes[job.idempotency_key] = direct
        except TikTokApiError as exc:
            return PublishResult(status=exc.category, retryable=exc.retryable, message=exc.category)
        return PublishResult(remote_id=initialized["publish_id"],
                             status="processing" if direct else "awaiting_creator_review")
