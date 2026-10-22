from datetime import date
from pathlib import Path

from fastapi.testclient import TestClient

from social_funnel.auth.tiktok_connection import ConnectedTikTokAccount, TikTokOAuthStart
from social_funnel.storage.repositories import AccountConnectionRepository
from social_funnel.web.app import WebSettings, create_app


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


def csrf_from(page: str) -> str:
    import re
    return re.search(r'name="csrf" value="([^"]+)"', page).group(1)


class FakeTikTokConnection:
    def __init__(self):
        self.is_configured = False
        self.saved = None
        self.started = None
        self.completed = None
        self.disconnected = None

    def configured(self):
        return self.is_configured

    def save_developer_credentials(self, client_key, client_secret):
        self.saved = (client_key, client_secret)
        self.is_configured = True

    def begin(self, account_id, *, redirect_uri, state, verifier):
        self.started = (account_id, redirect_uri, state, verifier)
        return TikTokOAuthStart(account_id, f"https://authorize.test/?state={state}")

    def complete(self, account_id, *, redirect_uri, code, verifier):
        self.completed = (account_id, redirect_uri, code, verifier)
        return ConnectedTikTokAccount(account_id, "open-123", "@fasttrack.fasting.tr")

    def disconnect(self, account_id):
        self.disconnected = account_id


def make_app(tmp_path, service):
    return create_app(
        WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)),
        tiktok_connection=service,
    )


def test_accounts_page_lists_destinations_and_keeps_secrets_out_of_html(tmp_path):
    service = FakeTikTokConnection()
    client = TestClient(make_app(tmp_path, service))

    page = client.get("/accounts")

    assert page.status_code == 200
    assert page.text.count("data-account-id=") == 12
    assert "@fasttrack.fasting.tr" in page.text
    assert "Bağlı değil" in page.text
    assert "actual-secret-value" not in page.text


def test_tiktok_developer_config_requires_csrf_and_is_delegated_to_vault_service(tmp_path):
    service = FakeTikTokConnection()
    client = TestClient(make_app(tmp_path, service))

    assert client.post("/accounts/tiktok/configure", data={}).status_code == 403
    csrf = csrf_from(client.get("/accounts").text)
    response = client.post(
        "/accounts/tiktok/configure",
        data={"csrf": csrf, "client_key": " key ", "client_secret": " secret "},
        follow_redirects=False,
    )

    assert response.status_code == 303
    assert response.headers["location"] == "/accounts?notice=configured"
    assert service.saved == (" key ", " secret ")


def test_tiktok_connect_stores_one_time_oauth_state_and_redirects(tmp_path):
    service = FakeTikTokConnection()
    service.is_configured = True
    client = TestClient(make_app(tmp_path, service))
    csrf = csrf_from(client.get("/accounts").text)

    response = client.post(
        "/accounts/tr-tiktok/tiktok/connect", data={"csrf": csrf}, follow_redirects=False,
    )

    assert response.status_code == 303
    assert response.headers["location"].startswith("https://authorize.test/")
    account_id, redirect_uri, state, verifier = service.started
    assert account_id == "tr-tiktok"
    assert redirect_uri.endswith("/oauth/tiktok/callback")
    assert len(state) >= 32 and len(verifier) >= 43


def test_tiktok_callback_rejects_state_mismatch_and_completes_matching_flow(tmp_path):
    service = FakeTikTokConnection()
    service.is_configured = True
    app = make_app(tmp_path, service)
    client = TestClient(app)
    csrf = csrf_from(client.get("/accounts").text)
    client.post("/accounts/tr-tiktok/tiktok/connect", data={"csrf": csrf})
    state = service.started[2]

    rejected = client.get("/oauth/tiktok/callback?code=good&state=wrong", follow_redirects=False)
    assert rejected.status_code == 303
    assert rejected.headers["location"] == "/accounts?error=oauth"
    assert service.completed is None

    client.post("/accounts/tr-tiktok/tiktok/connect", data={"csrf": csrf})
    state = service.started[2]
    connected = client.get(
        f"/oauth/tiktok/callback?code=good&state={state}", follow_redirects=False,
    )
    assert connected.status_code == 303
    assert connected.headers["location"] == "/accounts?notice=connected"
    assert service.completed[0] == "tr-tiktok"


def test_disconnect_requires_csrf_and_stops_active_campaign(tmp_path):
    service = FakeTikTokConnection()
    app = make_app(tmp_path, service)
    client = TestClient(app)
    csrf = csrf_from(client.get("/accounts").text)
    app.state.scheduler.activate()

    response = client.post(
        "/accounts/tr-tiktok/disconnect", data={"csrf": csrf}, follow_redirects=False,
    )

    assert response.status_code == 303
    assert service.disconnected == "tr-tiktok"
    assert not app.state.scheduler.active

