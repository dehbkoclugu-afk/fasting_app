"""Threads text/media posts and ordered replies."""

from collections.abc import Callable
from pathlib import Path

from social_funnel.domain.models import LocalizedContent, PublicationJob, PublishResult
from social_funnel.publishing.meta.errors import MetaApiError


class ThreadsPublisher:
    def __init__(self, client, *, content_lookup: Callable[[PublicationJob], LocalizedContent],
                 media_url: Callable[[Path], str] | None = None,
                 sequence_lookup: Callable[[PublicationJob], tuple[str, ...]] | None = None):
        self.client = client
        self.content_lookup = content_lookup
        self.media_url = media_url
        self.sequence_lookup = sequence_lookup
        self._containers: dict[tuple[str, int], str] = {}
        self._parts: dict[str, list[str]] = {}
        self._published: dict[str, PublishResult] = {}

    def lookup_by_idempotency_key(self, key: str) -> PublishResult | None:
        return self._published.get(key)

    def capabilities(self, account_id: str) -> dict:
        return {"account_id": account_id, "text": True, "image": self.media_url is not None,
                "video": self.media_url is not None, "sequence": True}

    def publish(self, job: PublicationJob, asset_path: Path | None) -> PublishResult:
        prior = self.lookup_by_idempotency_key(job.idempotency_key)
        if prior:
            return prior
        content = self.content_lookup(job)
        text = content.platform_overrides.get(job.platform) or f"{content.hook}\n\n{content.cta}"
        parts = self.sequence_lookup(job) if self.sequence_lookup else (text[:500],)
        if not 1 <= len(parts) <= 4 or any(len(part) > 500 for part in parts):
            return PublishResult(status="invalid_thread", message="Threads sequence needs 1–4 posts of at most 500 characters")
        published = self._parts.setdefault(job.idempotency_key, [])
        try:
            for index in range(len(published), len(parts)):
                key = (job.idempotency_key, index)
                container = self._containers.get(key)
                if container is None:
                    payload = {"text": parts[index], "media_type": "TEXT"}
                    if published:
                        payload["reply_to_id"] = published[-1]
                    if index == 0 and asset_path is not None:
                        if self.media_url is None:
                            return PublishResult(status="hosting_unavailable", message="Threads media needs public hosting")
                        media_type = "VIDEO" if asset_path.suffix.lower() == ".mp4" else "IMAGE"
                        payload["media_type"] = media_type
                        payload["video_url" if media_type == "VIDEO" else "image_url"] = self.media_url(asset_path)
                        payload["alt_text"] = content.hook
                    container = self.client.request("POST", f"{job.account_id}/threads", data=payload)["id"]
                    self._containers[key] = container
                if index == 0 and asset_path is not None:
                    self.client.poll_container(container)
                remote = self.client.request("POST", f"{job.account_id}/threads_publish",
                                             data={"creation_id": container})["id"]
                published.append(remote)
            result = PublishResult(remote_id=published[0], status="published")
            self._published[job.idempotency_key] = result
            return result
        except MetaApiError as exc:
            return PublishResult(remote_id=published[0] if published else None,
                                 status=exc.category, retryable=exc.retryable,
                                 message="Reconnect Threads" if exc.reconnect_required else exc.category)
