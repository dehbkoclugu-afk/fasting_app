from datetime import datetime, timezone

from social_funnel.domain.models import AutomationMode, JobState, LocaleCode, LocalizedContent, Platform, PublicationJob
from social_funnel.publishing.meta.threads import ThreadsPublisher


class FakeClient:
    def __init__(self): self.calls=[]
    def request(self, method, path, **kwargs):
        self.calls.append((method, path, kwargs))
        return {"id": f"remote-{len(self.calls)}"}
    def poll_container(self, container_id): return {"status_code": "FINISHED"}


def job():
    return PublicationJob(id="j", campaign_slug="c", day=1, locale=LocaleCode.PT_BR, platform=Platform.THREADS,
                          account_id="thread-1", automation_mode=AutomationMode.APPROVAL, state=JobState.SCHEDULED,
                          scheduled_at=datetime.now(timezone.utc), idempotency_key="key", content_revision=1)


def content():
    return LocalizedContent(day=1, locale=LocaleCode.PT_BR, hook="Comece com calma", body="Jejum não precisa virar cobrança.",
                            cta="Qual é seu ritmo?", hashtags=("#Jejum",))


def test_text_thread_is_concise_and_published():
    client = FakeClient()
    adapter = ThreadsPublisher(client, content_lookup=lambda _: content())
    result = adapter.publish(job(), None)
    assert result.status == "published" and result.remote_id
    assert client.calls[0][1] == "thread-1/threads"
    assert client.calls[0][2]["data"]["media_type"] == "TEXT"
    assert len(client.calls[0][2]["data"]["text"]) <= 500
    assert client.calls[1][1] == "thread-1/threads_publish"


def test_sequence_publishes_ordered_replies_without_duplicate_first():
    client = FakeClient()
    adapter = ThreadsPublisher(client, content_lookup=lambda _: content(),
                               sequence_lookup=lambda _: ("First thought", "Second thought"))
    assert adapter.publish(job(), None).status == "published"
    assert client.calls[2][2]["data"]["reply_to_id"] == "remote-2"
    assert adapter.publish(job(), None).status == "published"
    assert len(client.calls) == 4


def test_missing_media_host_falls_back_to_threads_text_only(tmp_path):
    client = FakeClient()
    asset = tmp_path / "post.png"
    asset.write_bytes(b"image")
    adapter = ThreadsPublisher(client, content_lookup=lambda _: content())

    result = adapter.publish(job(), asset)

    assert result.status == "published"
    assert client.calls[0][2]["data"]["media_type"] == "TEXT"
    assert "image_url" not in client.calls[0][2]["data"]
