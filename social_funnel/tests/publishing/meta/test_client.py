import httpx
import pytest

from social_funnel.publishing.meta.client import MetaGraphClient
from social_funnel.publishing.meta.errors import MetaApiError


def test_graph_success_and_embedded_error():
    requests = []
    def handler(request):
        requests.append(request)
        if len(requests) == 1: return httpx.Response(200, json={"id": "123"})
        return httpx.Response(200, json={"error": {"code": 190, "message": "Invalid token secret123"}})
    client = MetaGraphClient("secret123", version="v26.0", transport=httpx.MockTransport(handler))
    assert client.request("GET", "me")["id"] == "123"
    assert requests[0].headers["Authorization"] == "Bearer secret123"
    with pytest.raises(MetaApiError) as error:
        client.request("GET", "me")
    assert error.value.reconnect_required
    assert "secret123" not in str(error.value)


def test_rate_limit_and_pending_container_timeout():
    def handler(request):
        if request.url.path.endswith("/container"):
            return httpx.Response(200, json={"status_code": "IN_PROGRESS"})
        return httpx.Response(429, json={"error": {"code": 4, "message": "Too many"}})
    client = MetaGraphClient("token", version="v26.0", transport=httpx.MockTransport(handler))
    with pytest.raises(MetaApiError) as error:
        client.request("POST", "me/media")
    assert error.value.retryable
    with pytest.raises(MetaApiError) as error:
        client.poll_container("container", attempts=2, wait=lambda _: None)
    assert error.value.retryable and error.value.container_id == "container"
