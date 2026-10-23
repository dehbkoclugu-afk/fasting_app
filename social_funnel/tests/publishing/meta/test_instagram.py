from datetime import datetime, timezone
from pathlib import Path

from PIL import Image

from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, LocalizedContent, Platform, PublicationJob
from social_funnel.publishing.meta.errors import MetaApiError
from social_funnel.publishing.meta.instagram import InstagramPublisher


class FakeClient:
    def __init__(self):
        self.calls = []
        self.pending = False

    def request(self, method, path, **kwargs):
        self.calls.append((method, path, kwargs))
        return {"id": f"id-{len(self.calls)}"}

    def poll_container(self, container_id):
        if self.pending:
            raise MetaApiError("container_pending", retryable=True, container_id=container_id)
        return {"status_code": "FINISHED"}


def job():
    return PublicationJob(id="j", campaign_slug="c", day=1, locale=LocaleCode.TR, platform=Platform.INSTAGRAM,
                          account_id="123", automation_mode=AutomationMode.APPROVAL, state=JobState.SCHEDULED,
                          scheduled_at=datetime.now(timezone.utc), idempotency_key="stable", content_revision=1)


def content(format="image"):
    return LocalizedContent(day=1, locale=LocaleCode.TR, hook="İlk hafta", body="Oruç ritmini takip et.",
                            cta="FastTrack'i keşfet", hashtags=("#Oruç",), preferred_format=format)


def test_image_container_publish_and_reconciliation(tmp_path):
    image = tmp_path / "card.png"
    Image.new("RGB", (1080, 1350), "white").save(image)
    client = FakeClient()
    hosted = []
    adapter = InstagramPublisher(client, content_lookup=lambda _: content(), media_url=lambda path: hosted.append(path) or "https://cdn.test/card.jpg")
    result = adapter.publish(job(), image)
    assert result.status == "published" and result.remote_id
    assert hosted[0].suffix == ".jpg"
    assert client.calls[0][2]["data"]["alt_text"] == "İlk hafta"
    assert adapter.lookup_by_idempotency_key("stable") == result


def test_pending_container_is_reused_and_reels_supported(tmp_path):
    video = tmp_path / "clip.mp4"
    video.write_bytes(b"video")
    client = FakeClient()
    client.pending = True
    adapter = InstagramPublisher(client, content_lookup=lambda _: content("video"), media_url=lambda _: "https://cdn.test/clip.mp4")
    assert adapter.publish(job(), video).retryable
    client.pending = False
    assert adapter.publish(job(), video).status == "published"
    assert sum(path.endswith("/media") for _, path, _ in client.calls) == 1
    assert client.calls[0][2]["data"]["media_type"] == "REELS"


def test_carousel_child_order(tmp_path):
    for n in range(1, 4):
        Image.new("RGB", (1080, 1350), "white").save(tmp_path / f"slide-{n:02d}.png")
    client = FakeClient()
    adapter = InstagramPublisher(client, content_lookup=lambda _: content("carousel"), media_url=lambda _: "https://cdn.test/card.jpg")
    assert adapter.publish(job(), tmp_path / "slide-01.png").status == "published"
    assert len([call for call in client.calls if call[1].endswith("/media")]) == 4
    assert client.calls[3][2]["data"]["media_type"] == "CAROUSEL"
