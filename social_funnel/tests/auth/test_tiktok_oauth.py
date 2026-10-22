from hashlib import sha256
from urllib.parse import parse_qs, urlparse

import httpx

from social_funnel.auth.tiktok_oauth import TikTokOAuthClient, TikTokOAuthConfig


def config() -> TikTokOAuthConfig:
    return TikTokOAuthConfig(
        client_key="client-key",
        client_secret="client-secret",
        redirect_uri="http://127.0.0.1:8811/oauth/tiktok/callback",
    )


def test_desktop_authorization_url_uses_state_pkce_and_minimum_scopes():
    client = TikTokOAuthClient(config())
    verifier = "v" * 64

    url = urlparse(client.authorization_url(state="state-123", code_verifier=verifier))
    query = parse_qs(url.query)

    assert f"{url.scheme}://{url.netloc}{url.path}" == "https://www.tiktok.com/v2/auth/authorize/"
    assert query == {
        "client_key": ["client-key"],
        "response_type": ["code"],
        "scope": ["user.info.basic,user.info.profile,video.upload"],
        "redirect_uri": ["http://127.0.0.1:8811/oauth/tiktok/callback"],
        "state": ["state-123"],
        "code_challenge": [sha256(verifier.encode()).hexdigest()],
        "code_challenge_method": ["S256"],
        "disable_auto_auth": ["1"],
    }


def test_code_exchange_and_identity_lookup_use_current_v2_contract():
    requests = []

    def handler(request: httpx.Request) -> httpx.Response:
        requests.append(request)
        if request.url.path == "/v2/oauth/token/":
            return httpx.Response(200, json={
                "access_token": "access-token",
                "refresh_token": "refresh-token",
                "open_id": "open-123",
                "scope": "user.info.basic,user.info.profile,video.upload",
                "expires_in": 86400,
                "refresh_expires_in": 31536000,
            })
        assert request.url.params["fields"] == "open_id,display_name,username,profile_deep_link,avatar_url"
        assert request.headers["authorization"] == "Bearer access-token"
        return httpx.Response(200, json={
            "data": {"user": {
                "open_id": "open-123", "display_name": "FastTrack TR",
                "username": "fasttrack.fasting.tr",
                "profile_deep_link": "https://www.tiktok.com/@fasttrack.fasting.tr",
                "avatar_url": "https://example.test/avatar.jpg",
            }},
            "error": {"code": "ok", "message": "", "log_id": "log-1"},
        })

    client = TikTokOAuthClient(config(), transport=httpx.MockTransport(handler))
    tokens = client.exchange_code("code-123", "v" * 64)
    identity = client.fetch_identity(tokens.access_token)

    assert tokens.open_id == "open-123"
    assert tokens.granted_scopes == frozenset({"user.info.basic", "user.info.profile", "video.upload"})
    assert identity.open_id == "open-123"
    assert identity.display_name == "FastTrack TR"
    assert identity.username == "fasttrack.fasting.tr"
    form = parse_qs(requests[0].content.decode())
    assert form == {
        "client_key": ["client-key"],
        "client_secret": ["client-secret"],
        "code": ["code-123"],
        "grant_type": ["authorization_code"],
        "redirect_uri": ["http://127.0.0.1:8811/oauth/tiktok/callback"],
        "code_verifier": ["v" * 64],
    }


def test_code_exchange_rejects_missing_required_scope():
    transport = httpx.MockTransport(lambda _: httpx.Response(200, json={
        "access_token": "access-token", "refresh_token": "refresh-token",
        "open_id": "open-123", "scope": "user.info.basic",
        "expires_in": 86400, "refresh_expires_in": 31536000,
    }))
    client = TikTokOAuthClient(config(), transport=transport)

    try:
        client.exchange_code("code-123", "v" * 64)
    except ValueError as exc:
        assert "video.upload" in str(exc)
    else:
        raise AssertionError("missing upload scope was accepted")


def test_refresh_rotates_tiktok_access_and_refresh_tokens():
    captured = {}
    def handler(request: httpx.Request):
        captured.update({key: values[0] for key, values in parse_qs(request.content.decode()).items()})
        return httpx.Response(200, json={
            "access_token": "new-access", "refresh_token": "new-refresh",
            "open_id": "open-123",
            "scope": "user.info.basic,user.info.profile,video.upload",
            "expires_in": 86400, "refresh_expires_in": 31536000,
        })
    client = TikTokOAuthClient(config(), transport=httpx.MockTransport(handler))

    refreshed = client.refresh_token("old-refresh")

    assert refreshed.access_token == "new-access"
    assert refreshed.refresh_token == "new-refresh"
    assert captured == {
        "client_key": "client-key", "client_secret": "client-secret",
        "grant_type": "refresh_token", "refresh_token": "old-refresh",
    }
