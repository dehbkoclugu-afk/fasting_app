from datetime import date
from pathlib import Path

from social_funnel.campaign.expansion import AccountConfig, expand_publication_jobs
from social_funnel.content.loader import load_campaign
from social_funnel.domain.models import AutomationMode, LocaleCode, Platform
from social_funnel.publishing.runtime import build_account_publishers
from social_funnel.storage.database import Database


CATALOG = Path(__file__).parents[2] / "content" / "fasttrack-30-day-launch.json"


class Tokens:
    def __init__(self): self.requested = []
    def access_token(self, account_id):
        self.requested.append(account_id)
        return f"token-for-{account_id}"


class GraphClient:
    def __init__(self, token, *, version, graph_host="https://graph.facebook.com"):
        self.token = token
        self.version = version
        self.graph_host = graph_host
        self.requests = []

    def request(self, method, path, **kwargs):
        self.requests.append((method, path))
        return {"id": "remote-1"}

    def poll_container(self, container_id): return {"status_code": "FINISHED"}


class TikTokClient:
    def __init__(self, token): self.token = token


def test_runtime_binds_each_connected_account_to_its_provider_identity(tmp_path):
    db = Database.open(tmp_path / "campaign.db")
    rows = (
        ("tr-facebook", "facebook", "tr", "page-provider", 1),
        ("tr-instagram", "instagram", "tr", "ig-provider", 1),
        ("tr-threads", "threads", "tr", "threads-provider", 1),
        ("tr-tiktok", "tiktok", "tr", "tiktok-provider", 1),
        ("en-facebook", "facebook", "en", "disabled-provider", 0),
    )
    db.connection.executemany(
        """INSERT INTO account_connection(id,platform,locale,provider_identity,enabled,
        public_identity,vault_reference) VALUES(?,?,?,?,?,'public','vault')""", rows,
    )
    db.connection.commit()
    manifest = load_campaign(CATALOG)
    meta = Tokens()
    threads = Tokens()
    tiktok = Tokens()
    graph_clients = []
    def graph_factory(token, **options):
        client = GraphClient(token, **options)
        graph_clients.append(client)
        return client

    publishers = build_account_publishers(
        db, manifest, meta_tokens=meta, threads_tokens=threads, tiktok_tokens=tiktok,
        media_url=lambda path: f"https://media.test/{path.name}",
        graph_client_factory=graph_factory, tiktok_client_factory=TikTokClient,
    )

    assert set(publishers) == {"tr-facebook", "tr-instagram", "tr-threads", "tr-tiktok"}
    job = next(item for item in expand_publication_jobs(manifest, (
        AccountConfig("tr-facebook", LocaleCode.TR, Platform.FACEBOOK, AutomationMode.APPROVAL),
    ), date(2026, 10, 20)) if item.day == 18)
    result = publishers["tr-facebook"].publish(job, None)
    assert result.remote_id == "remote-1"
    facebook_client = next(client for client in graph_clients if client.token == "token-for-tr-facebook")
    assert facebook_client.requests == [("POST", "page-provider/feed")]
    assert "en-facebook" not in meta.requested
    db.close()
