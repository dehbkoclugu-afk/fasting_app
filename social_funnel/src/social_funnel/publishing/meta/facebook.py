"""Facebook Page photo/video posting with local scheduling upstream."""

from collections.abc import Callable
from pathlib import Path

from social_funnel.domain.models import LocalizedContent, PublicationJob, PublishResult
from social_funnel.publishing.meta.errors import MetaApiError


class FacebookPagePublisher:
    def __init__(self, client, *, content_lookup: Callable[[PublicationJob], LocalizedContent]):
        self.client = client
        self.content_lookup = content_lookup
        self._published: dict[str, PublishResult] = {}

    def lookup_by_idempotency_key(self, key: str) -> PublishResult | None:
        return self._published.get(key)

    def capabilities(self, account_id: str) -> dict:
        return {"account_id": account_id, "page_role_required": True,
                "photo": True, "video": True, "scheduler": "local"}

    def publish(self, job: PublicationJob, asset_path: Path | None) -> PublishResult:
        prior = self.lookup_by_idempotency_key(job.idempotency_key)
        if prior:
            return prior
        content = self.content_lookup(job)
        caption = "\n\n".join((content.hook, content.body, content.cta, " ".join(content.hashtags)))
        try:
            if asset_path is None:
                payload = self.client.request("POST", f"{job.account_id}/feed", data={"message": caption})
            else:
                edge = "videos" if asset_path.suffix.lower() == ".mp4" else "photos"
                field = "source"
                with asset_path.open("rb") as source:
                    payload = self.client.request("POST", f"{job.account_id}/{edge}",
                                                  data={"description" if edge == "videos" else "caption": caption},
                                                  files={field: (asset_path.name, source)})
            result = PublishResult(remote_id=payload.get("post_id") or payload.get("id"), status="published")
            if not result.remote_id:
                return PublishResult(status="invalid_response", message="Page returned no post id")
            self._published[job.idempotency_key] = result
            return result
        except MetaApiError as exc:
            return PublishResult(status=exc.category, retryable=exc.retryable,
                                 message="Reconnect Page" if exc.reconnect_required else exc.category)
