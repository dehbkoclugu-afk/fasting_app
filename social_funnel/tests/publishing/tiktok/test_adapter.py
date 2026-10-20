from datetime import datetime, timezone
from pathlib import Path

from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, LocalizedContent, Platform, PublicationJob
from social_funnel.publishing.tiktok.adapter import TikTokPublisher


class FakeClient:
    def __init__(self): self.calls=[]; self.http=object(); self.privacy=["PUBLIC_TO_EVERYONE", "SELF_ONLY"]
    def query_creator_info(self):
        self.calls.append("creator")
        return {"privacy_level_options": self.privacy, "comment_disabled": False,
                "duet_disabled": False, "stitch_disabled": False}
    def init_video(self, **kwargs):
        self.calls.append(("video", kwargs))
        return {"publish_id": "pub-1", "upload_url": "https://upload.tiktokapis.com/video?upload_token=secret"}
    def init_photo(self, **kwargs):
        self.calls.append(("photo", kwargs))
        return {"publish_id": "pub-1"}
    def fetch_status(self, publish_id): return {"status": "SEND_TO_USER_INBOX"}


def job(revision=1):
    return PublicationJob(id="j", campaign_slug="c", day=1, locale=LocaleCode.EN, platform=Platform.TIKTOK,
                          account_id="tt-en", automation_mode=AutomationMode.AUTOMATIC, state=JobState.SCHEDULED,
                          scheduled_at=datetime.now(timezone.utc), idempotency_key="key", content_revision=revision)


def content():
    return LocalizedContent(day=1, locale=LocaleCode.EN, hook="Start gently", body="A calm fasting routine.",
                            cta="Try FastTrack", hashtags=("#Fasting",))


def test_default_review_upload_requires_current_revision_consent(tmp_path):
    video = tmp_path / "clip.mp4"; video.write_bytes(b"video")
    client = FakeClient()
    uploaded = []
    publisher = TikTokPublisher(client, content_lookup=lambda _: content(), upload=lambda url, path: uploaded.append(path))
    assert publisher.publish(job(), video).status == "consent_required"
    publisher.record_consent("j", 1, datetime.now(timezone.utc))
    result = publisher.publish(job(), video)
    assert result.status == "awaiting_creator_review" and result.remote_id == "pub-1"
    assert client.calls[0][0] == "video" and client.calls[0][1]["review"]
    assert uploaded == [video]
    assert publisher.publish(job(2), video).status == "consent_required"


def test_direct_post_requires_audit_and_fresh_creator_privacy(tmp_path):
    video = tmp_path / "clip.mp4"; video.write_bytes(b"video")
    client = FakeClient()
    publisher = TikTokPublisher(client, content_lookup=lambda _: content(), upload=lambda *_: None,
                                audited=True, direct_post=True, privacy_level="PUBLIC_TO_EVERYONE")
    publisher.record_consent("j", 1, datetime.now(timezone.utc))
    client.privacy = ["SELF_ONLY"]
    assert publisher.publish(job(), video).status == "privacy_unavailable"
    client.privacy = ["PUBLIC_TO_EVERYONE"]
    assert publisher.publish(job(), video).status == "processing"
    assert client.calls[-1][1]["post_info"]["is_aigc"] is True


def test_photo_needs_verified_host(tmp_path):
    image = tmp_path / "card.png"; image.write_bytes(b"image")
    client = FakeClient()
    publisher = TikTokPublisher(client, content_lookup=lambda _: content(),
                                media_url=lambda _: "https://unverified.test/card.png", verified_media_host="verified.test")
    publisher.record_consent("j", 1, datetime.now(timezone.utc))
    assert publisher.publish(job(), image).status == "unverified_media_host"
    assert client.calls == []
