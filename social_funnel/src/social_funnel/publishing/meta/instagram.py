"""Instagram professional-account container publishing."""

from collections.abc import Callable
from pathlib import Path

from PIL import Image

from social_funnel.domain.models import LocalizedContent, PublicationJob, PublishResult
from social_funnel.publishing.meta.errors import MetaApiError


class InstagramPublisher:
    def __init__(self, client, *, content_lookup: Callable[[PublicationJob], LocalizedContent],
                 media_url: Callable[[Path], str]):
        self.client = client
        self.content_lookup = content_lookup
        self.media_url = media_url
        self._containers: dict[str, str] = {}
        self._published: dict[str, PublishResult] = {}

    def lookup_by_idempotency_key(self, key: str) -> PublishResult | None:
        # Graph has no universal client idempotency lookup. Unknown cross-process
        # outcomes remain blocked by the orchestrator until a human checks.
        return self._published.get(key)

    def capabilities(self, account_id: str) -> dict:
        return {"account_id": account_id, "requires_professional_account": True,
                "public_media_url": True, "image": True, "reel": True, "carousel": True}

    @staticmethod
    def _jpeg(path: Path) -> Path:
        if path.suffix.lower() in {".jpg", ".jpeg"}:
            return path
        target = path.with_suffix(".jpg")
        with Image.open(path) as source:
            source.convert("RGB").save(target, "JPEG", quality=92)
        return target

    def publish(self, job: PublicationJob, asset_path: Path | None) -> PublishResult:
        if asset_path is None:
            return PublishResult(status="missing_media", message="Instagram requires media")
        prior = self.lookup_by_idempotency_key(job.idempotency_key)
        if prior:
            return prior
        content = self.content_lookup(job)
        caption = "\n\n".join((content.hook, content.body, content.cta, " ".join(content.hashtags)))
        try:
            container = self._containers.get(job.idempotency_key)
            if container is None:
                if asset_path.suffix.lower() == ".mp4":
                    payload = {"media_type": "REELS", "video_url": self.media_url(asset_path),
                               "caption": caption, "share_to_feed": "true"}
                elif content.preferred_format == "carousel":
                    slide_paths = sorted(asset_path.parent.glob("slide-*.png"))
                    if not 2 <= len(slide_paths) <= 10:
                        return PublishResult(status="invalid_carousel", message="Carousel needs 2–10 slides")
                    children = []
                    for slide in slide_paths:
                        child = self.client.request("POST", f"{job.account_id}/media", data={
                            "image_url": self.media_url(self._jpeg(slide)), "is_carousel_item": "true",
                            "alt_text": content.hook,
                        })
                        children.append(child["id"])
                    payload = {"media_type": "CAROUSEL", "children": ",".join(children), "caption": caption}
                else:
                    payload = {"image_url": self.media_url(self._jpeg(asset_path)),
                               "caption": caption, "alt_text": content.hook}
                container = self.client.request("POST", f"{job.account_id}/media", data=payload)["id"]
                self._containers[job.idempotency_key] = container
            self.client.poll_container(container)
            remote_id = self.client.request("POST", f"{job.account_id}/media_publish",
                                            data={"creation_id": container})["id"]
            result = PublishResult(remote_id=remote_id, status="published")
            self._published[job.idempotency_key] = result
            return result
        except MetaApiError as exc:
            return PublishResult(status=exc.category, retryable=exc.retryable,
                                 message="Reconnect account" if exc.reconnect_required else exc.category)
