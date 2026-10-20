import httpx
import pytest

from social_funnel.publishing.tiktok.client import TikTokClient
from social_funnel.publishing.tiktok.errors import TikTokApiError


def test_creator_info_and_embedded_error_classification():
    calls = []
    def handler(request):
        calls.append(request)
        if len(calls) == 1:
            return httpx.Response(200, json={"data": {"privacy_level_options": ["SELF_ONLY"]}, "error": {"code": "ok"}})
        return httpx.Response(401, json={"error": {"code": "access_token_invalid", "message": "secret"}})
    client = TikTokClient("secret", transport=httpx.MockTransport(handler))
    assert client.query_creator_info()["privacy_level_options"] == ["SELF_ONLY"]
    with pytest.raises(TikTokApiError) as error:
        client.query_creator_info()
    assert error.value.reconnect_required and "secret" not in str(error.value)


def test_status_auth_removed_is_terminal():
    client = TikTokClient("token", transport=httpx.MockTransport(lambda _: httpx.Response(200, json={
        "data": {"status": "FAILED", "fail_reason": "auth_removed"}, "error": {"code": "ok"}})))
    with pytest.raises(TikTokApiError) as error:
        client.fetch_status("publish-1")
    assert error.value.reconnect_required and not error.value.retryable
