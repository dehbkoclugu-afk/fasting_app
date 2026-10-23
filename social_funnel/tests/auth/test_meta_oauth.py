from urllib.parse import parse_qs, urlparse

import httpx

from social_funnel.auth.meta_oauth import MetaOAuthClient, MetaOAuthConfig


def test_meta_authorization_requests_only_publishing_and_identity_permissions():
    client = MetaOAuthClient(MetaOAuthConfig(
        app_id="app-123", app_secret="secret",
        redirect_uri="http://127.0.0.1:8811/oauth/meta/callback",
    ))

    query = parse_qs(urlparse(client.authorization_url(state="state-123")).query)

    assert query == {
        "client_id": ["app-123"],
        "redirect_uri": ["http://127.0.0.1:8811/oauth/meta/callback"],
        "response_type": ["code"],
        "state": ["state-123"],
        "scope": ["instagram_basic,instagram_content_publish,pages_manage_posts,pages_read_engagement,pages_show_list"],
    }


def test_meta_exchanges_long_lived_token_and_discovers_page_instagram_pairs():
    seen = []

    def handler(request: httpx.Request):
        seen.append((request.method, request.url.path))
        if request.url.path.endswith("/oauth/access_token") and request.method == "POST":
            return httpx.Response(200, json={"access_token": "short-user", "token_type": "bearer", "expires_in": 3600})
        if request.url.path.endswith("/oauth/access_token"):
            return httpx.Response(200, json={"access_token": "long-user", "token_type": "bearer", "expires_in": 5184000})
        if request.url.path.endswith("/me/accounts"):
            return httpx.Response(200, json={"data": [{
                "id": "page-1", "name": "FastTrack Fasting", "access_token": "page-secret",
                "tasks": ["CREATE_CONTENT"],
                "instagram_business_account": {"id": "ig-1"},
            }]})
        return httpx.Response(200, json={"id": "ig-1", "username": "fasttrack.fasting.en"})

    client = MetaOAuthClient(MetaOAuthConfig(
        app_id="app-123", app_secret="secret",
        redirect_uri="http://127.0.0.1:8811/oauth/meta/callback",
    ), transport=httpx.MockTransport(handler))

    token = client.exchange_code("code-123")
    long_lived = client.exchange_long_lived_token(token.access_token)
    pairs = client.discover_page_pairs(long_lived.access_token)

    assert token.access_token == "short-user"
    assert long_lived.access_token == "long-user"
    assert pairs[0].page_id == "page-1"
    assert pairs[0].page_name == "FastTrack Fasting"
    assert pairs[0].page_access_token == "page-secret"
    assert pairs[0].instagram_id == "ig-1"
    assert pairs[0].instagram_username == "fasttrack.fasting.en"
    assert seen == [
        ("POST", "/v25.0/oauth/access_token"),
        ("GET", "/v25.0/oauth/access_token"),
        ("GET", "/v25.0/me/accounts"),
        ("GET", "/v25.0/ig-1"),
    ]


def test_meta_rejects_provider_errors_without_exposing_provider_message():
    transport = httpx.MockTransport(lambda _: httpx.Response(400, json={
        "error": {"message": "token secret leaked", "type": "OAuthException", "code": 190},
    }))
    client = MetaOAuthClient(MetaOAuthConfig(
        app_id="app", app_secret="secret",
        redirect_uri="http://127.0.0.1:8811/oauth/meta/callback",
    ), transport=transport)

    try:
        client.exchange_code("bad")
    except ValueError as exc:
        assert str(exc) == "Meta authorization request failed"
    else:
        raise AssertionError("Meta provider error was accepted")
