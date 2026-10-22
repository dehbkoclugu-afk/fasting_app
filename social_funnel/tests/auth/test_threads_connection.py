import json
from urllib.parse import parse_qs, urlparse

import httpx
import pytest

from social_funnel.auth.threads_connection import ThreadsConnectionService
from social_funnel.auth.threads_oauth import ThreadsIdentity, ThreadsOAuthClient, ThreadsOAuthConfig, ThreadsToken
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


def test_threads_oauth_uses_minimum_publish_scopes_and_verifies_profile():
    def handler(request: httpx.Request):
        if request.url.path == "/oauth/access_token":
            return httpx.Response(200, json={"access_token": "short", "user_id": "user-1"})
        if request.url.path == "/access_token":
            return httpx.Response(200, json={"access_token": "long", "token_type": "bearer", "expires_in": 5184000})
        return httpx.Response(200, json={"id": "user-1", "username": "fasttrack.fasting.br"})

    client = ThreadsOAuthClient(ThreadsOAuthConfig(
        app_id="threads-app", app_secret="secret",
        redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
    ), transport=httpx.MockTransport(handler))
    query = parse_qs(urlparse(client.authorization_url(state="state-1")).query)
    short = client.exchange_code("code")
    long_lived = client.exchange_long_lived_token(short.access_token)
    identity = client.fetch_identity(long_lived.access_token)

    assert query["scope"] == ["threads_basic,threads_content_publish"]
    assert short.user_id == "user-1"
    assert long_lived.access_token == "long"
    assert identity == ThreadsIdentity("user-1", "fasttrack.fasting.br")


def test_threads_refresh_uses_current_long_lived_token():
    def handler(request: httpx.Request):
        assert request.url.path == "/refresh_access_token"
        assert request.url.params["grant_type"] == "th_refresh_token"
        assert request.headers["authorization"] == "Bearer old-token"
        return httpx.Response(200, json={
            "access_token": "new-token", "token_type": "bearer", "expires_in": 5184000,
        })
    client = ThreadsOAuthClient(ThreadsOAuthConfig(
        app_id="threads-app", app_secret="secret",
        redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
    ), transport=httpx.MockTransport(handler))

    refreshed = client.refresh_long_lived_token("old-token", user_id="user-1")

    assert refreshed == ThreadsToken("new-token", "user-1", 5184000)


class FakeThreadsOAuth:
    def __init__(self, config, username="fasttrack.fasting.br"):
        self.config = config
        self.username = username

    def authorization_url(self, *, state): return f"https://threads.test/oauth?state={state}"
    def exchange_code(self, code): return ThreadsToken("short", "user-1", 0)
    def exchange_long_lived_token(self, token): return ThreadsToken("long-secret", "user-1", 5184000)
    def fetch_identity(self, token): return ThreadsIdentity("user-1", self.username)
    def refresh_long_lived_token(self, token, *, user_id):
        assert token == "long-secret" and user_id == "user-1"
        return ThreadsToken("long-refreshed", user_id, 5184000)


def setup_service(tmp_path, username="fasttrack.fasting.br"):
    db = Database.open(tmp_path / "campaign.db")
    db.connection.execute(
        """INSERT INTO account_connection(id,platform,locale,public_identity,enabled)
        VALUES('pt-BR-threads','threads','pt-BR','@fasttrack.fasting.br',0)"""
    )
    db.connection.commit()
    vault = CredentialVault(MemoryKeyring())
    service = ThreadsConnectionService(
        db, vault, client_factory=lambda config: FakeThreadsOAuth(config, username),
    )
    return db, vault, service


def test_threads_connection_stores_long_lived_token_only_in_vault(tmp_path):
    db, vault, service = setup_service(tmp_path)
    service.save_developer_credentials("app-id", "app-secret")

    start = service.begin(
        "pt-BR-threads", redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
        state="state-1",
    )
    connected = service.complete(
        "pt-BR-threads", redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
        code="code",
    )

    assert start.authorization_url.startswith("https://threads.test/")
    assert connected.public_identity == "@fasttrack.fasting.br"
    assert json.loads(vault.get("oauth:pt-BR-threads"))["access_token"] == "long-secret"
    row = AccountConnectionRepository(db).get("pt-BR-threads")
    assert row["provider_identity"] == "user-1" and row["enabled"] == 1
    assert "long-secret" not in str(dict(row))
    db.close()


def test_threads_connection_rejects_wrong_handle_without_saving_token(tmp_path):
    db, vault, service = setup_service(tmp_path, "wrong.handle")
    service.save_developer_credentials("app-id", "app-secret")

    with pytest.raises(ValueError, match="does not match"):
        service.complete(
            "pt-BR-threads", redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
            code="code",
        )

    assert vault.get("oauth:pt-BR-threads") is None
    assert AccountConnectionRepository(db).get("pt-BR-threads")["enabled"] == 0
    db.close()


def test_threads_connection_refreshes_an_expired_long_lived_token(tmp_path):
    db, vault, service = setup_service(tmp_path)
    service.save_developer_credentials("app-id", "app-secret")
    service.complete(
        "pt-BR-threads", redirect_uri="http://127.0.0.1:8811/oauth/threads/callback",
        code="code",
    )
    credential = json.loads(vault.get("oauth:pt-BR-threads"))
    credential["expires_at"] = 0
    vault.set("oauth:pt-BR-threads", json.dumps(credential))

    assert service.access_token("pt-BR-threads") == "long-refreshed"
    db.close()
