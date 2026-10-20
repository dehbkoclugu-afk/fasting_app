from datetime import datetime, timezone
from pathlib import Path

from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, LocalizedContent, Platform, PublicationJob
from social_funnel.publishing.meta.facebook import FacebookPagePublisher
from social_funnel.publishing.meta.errors import MetaApiError


class FakeClient:
    def __init__(self, error=None): self.calls = []; self.error = error
    def request(self, method, path, **kwargs):
        self.calls.append((method, path, kwargs))
        if self.error: raise self.error
        return {"id": "post-1"}


def job():
    return PublicationJob(id="j", campaign_slug="c", day=1, locale=LocaleCode.EN, platform=Platform.FACEBOOK,
                          account_id="page-1", automation_mode=AutomationMode.APPROVAL, state=JobState.SCHEDULED,
                          scheduled_at=datetime.now(timezone.utc), idempotency_key="key", content_revision=1)


def content():
    return LocalizedContent(day=1, locale=LocaleCode.EN, hook="Begin gently", body="Track your fasting rhythm.",
                            cta="Try FastTrack", hashtags=("#FastTrack",))


def test_page_photo_and_video_use_correct_endpoint(tmp_path):
    image = tmp_path / "image.png"; image.write_bytes(b"image")
    client = FakeClient()
    adapter = FacebookPagePublisher(client, content_lookup=lambda _: content())
    assert adapter.publish(job(), image).remote_id == "post-1"
    assert client.calls[0][1] == "page-1/photos"
    assert "source" in client.calls[0][2]["files"]
    video = tmp_path / "video.mp4"; video.write_bytes(b"video")
    other = job().model_copy(update={"idempotency_key": "other"})
    assert adapter.publish(other, video).status == "published"
    assert client.calls[1][1] == "page-1/videos"


def test_revoked_page_permission_never_retries(tmp_path):
    image = tmp_path / "image.png"; image.write_bytes(b"image")
    client = FakeClient(MetaApiError("reconnect", reconnect_required=True))
    result = FacebookPagePublisher(client, content_lookup=lambda _: content()).publish(job(), image)
    assert result.status == "reconnect" and not result.retryable
