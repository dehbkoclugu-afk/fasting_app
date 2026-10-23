from datetime import date
from pathlib import Path

from fastapi.testclient import TestClient

from social_funnel.auth.tiktok_connection import ConnectedTikTokAccount, TikTokOAuthStart
from social_funnel.auth.meta_connection import ConnectedMetaPair, MetaOAuthStart
from social_funnel.auth.threads_connection import ConnectedThreadsAccount, ThreadsOAuthStart
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


class FakeMetaConnection:
    def __init__(self):
        self.is_configured = False
        self.saved = None
        self.started = None
        self.completed = None
        self.disconnected = None

    def configured(self):
        return self.is_configured

    def save_developer_credentials(self, app_id, app_secret):
        self.saved = (app_id, app_secret)
        self.is_configured = True

    def begin(self, locale, *, redirect_uri, state):
        self.started = (locale, redirect_uri, state)
        return MetaOAuthStart(locale, f"https://facebook.test/oauth?state={state}")

    def complete(self, locale, *, redirect_uri, code):
        self.completed = (locale, redirect_uri, code)
        return ConnectedMetaPair(locale, (f"{locale}-facebook", f"{locale}-instagram"))

    def disconnect(self, locale):
        self.disconnected = locale


class FakeThreadsConnection:
    def __init__(self):
        self.is_configured = False
        self.saved = None
        self.started = None
        self.completed = None
        self.disconnected = None

    def configured(self): return self.is_configured
    def save_developer_credentials(self, app_id, app_secret):
        self.saved = (app_id, app_secret)
        self.is_configured = True
    def begin(self, account_id, *, redirect_uri, state):
        self.started = (account_id, redirect_uri, state)
        return ThreadsOAuthStart(account_id, f"https://threads.test/oauth?state={state}")
    def complete(self, account_id, *, redirect_uri, code):
        self.completed = (account_id, redirect_uri, code)
        return ConnectedThreadsAccount(account_id, "user-1", "@fasttrack.fasting.tr")
    def disconnect(self, account_id): self.disconnected = account_id


class FakeHosting:
    def __init__(self):
        self.is_configured = False
        self.saved = None

    def configured(self): return self.is_configured
    def configure(self, **values):
        self.saved = values
        self.is_configured = True
    def disconnect(self): self.is_configured = False
    def url_for(self, path): return f"https://media.test/{path.name}"


def make_app(tmp_path, service, meta_service=None, threads_service=None, hosting_service=None):
    return create_app(
        WebSettings(workspace=tmp_path, catalog=CATALOG, start_date=date(2026, 10, 20)),
        tiktok_connection=service, meta_connection=meta_service or FakeMetaConnection(),
        threads_connection=threads_service or FakeThreadsConnection(),
        media_hosting=hosting_service or FakeHosting(),
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


def test_accounts_page_shows_exact_oauth_callback_urls_for_current_port(tmp_path):
    client = TestClient(
        make_app(tmp_path, FakeTikTokConnection()),
        base_url="http://127.0.0.1:8823",
    )

    page = client.get("/accounts")

    assert "http://127.0.0.1:8823/oauth/tiktok/callback" in page.text
    assert "http://127.0.0.1:8823/oauth/threads/callback" in page.text
    assert "http://127.0.0.1:8823/oauth/meta/callback" in page.text


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


def test_meta_config_connect_callback_and_pair_disconnect(tmp_path):
    tiktok = FakeTikTokConnection()
    meta = FakeMetaConnection()
    app = make_app(tmp_path, tiktok, meta)
    client = TestClient(app)
    csrf = csrf_from(client.get("/accounts").text)

    configured = client.post(
        "/accounts/meta/configure",
        data={"csrf": csrf, "app_id": " app-id ", "app_secret": " app-secret "},
        follow_redirects=False,
    )
    assert configured.headers["location"] == "/accounts?notice=meta-configured"
    assert meta.saved == (" app-id ", " app-secret ")

    started = client.post(
        "/accounts/en/meta/connect", data={"csrf": csrf}, follow_redirects=False,
    )
    assert started.status_code == 303
    assert started.headers["location"].startswith("https://facebook.test/")
    locale, redirect_uri, state = meta.started
    assert locale == "en" and redirect_uri.endswith("/oauth/meta/callback")

    connected = client.get(
        f"/oauth/meta/callback?code=good&state={state}", follow_redirects=False,
    )
    assert connected.headers["location"] == "/accounts?notice=meta-connected"
    assert meta.completed[0] == "en"

    app.state.scheduler.activate()
    disconnected = client.post(
        "/accounts/en/meta/disconnect", data={"csrf": csrf}, follow_redirects=False,
    )
    assert disconnected.headers["location"] == "/accounts?notice=meta-disconnected"
    assert meta.disconnected == "en"
    assert not app.state.scheduler.active


def test_meta_callback_rejects_wrong_state_without_completing(tmp_path):
    meta = FakeMetaConnection()
    meta.is_configured = True
    client = TestClient(make_app(tmp_path, FakeTikTokConnection(), meta))
    csrf = csrf_from(client.get("/accounts").text)
    client.post("/accounts/tr/meta/connect", data={"csrf": csrf})

    response = client.get(
        "/oauth/meta/callback?code=good&state=wrong", follow_redirects=False,
    )

    assert response.headers["location"] == "/accounts?error=meta-oauth"
    assert meta.completed is None


def test_threads_config_connect_callback_and_disconnect(tmp_path):
    threads = FakeThreadsConnection()
    app = make_app(tmp_path, FakeTikTokConnection(), threads_service=threads)
    client = TestClient(app)
    csrf = csrf_from(client.get("/accounts").text)

    configured = client.post(
        "/accounts/threads/configure",
        data={"csrf": csrf, "app_id": "threads-id", "app_secret": "threads-secret"},
        follow_redirects=False,
    )
    assert configured.headers["location"] == "/accounts?notice=threads-configured"

    started = client.post(
        "/accounts/tr-threads/threads/connect", data={"csrf": csrf}, follow_redirects=False,
    )
    assert started.headers["location"].startswith("https://threads.test/")
    account_id, redirect_uri, state = threads.started
    assert account_id == "tr-threads" and redirect_uri.endswith("/oauth/threads/callback")

    connected = client.get(
        f"/oauth/threads/callback?code=good&state={state}", follow_redirects=False,
    )
    assert connected.headers["location"] == "/accounts?notice=threads-connected"
    assert threads.completed[0] == "tr-threads"

    app.state.scheduler.activate()
    disconnected = client.post(
        "/accounts/tr-threads/threads/disconnect", data={"csrf": csrf}, follow_redirects=False,
    )
    assert disconnected.headers["location"] == "/accounts?notice=threads-disconnected"
    assert threads.disconnected == "tr-threads"
    assert not app.state.scheduler.active


def test_media_hosting_configuration_requires_csrf_and_stays_out_of_page(tmp_path):
    hosting = FakeHosting()
    app = make_app(tmp_path, FakeTikTokConnection(), hosting_service=hosting)
    client = TestClient(app)
    page = client.get("/accounts")
    assert "Medya barındırma" in page.text
    assert client.post("/accounts/hosting/configure", data={}).status_code == 403
    csrf = csrf_from(page.text)

    response = client.post(
        "/accounts/hosting/configure",
        data={
            "csrf": csrf,
            "endpoint_url": "https://account.r2.cloudflarestorage.com",
            "bucket": "fasttrack-media",
            "public_base_url": "https://media.fasttrack.test",
            "access_key_id": "access-id",
            "secret_access_key": "secret-key",
            "region": "auto",
        },
        follow_redirects=False,
    )

    assert response.headers["location"] == "/accounts?notice=hosting-configured"
    assert hosting.saved["bucket"] == "fasttrack-media"
    rendered = client.get("/accounts").text
    assert "secret-key" not in rendered and "access-id" not in rendered

