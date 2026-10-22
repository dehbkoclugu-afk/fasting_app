import json

import pytest

from social_funnel.auth.meta_connection import MetaConnectionService
from social_funnel.auth.meta_oauth import MetaPagePair, MetaToken
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


class FakeMetaOAuth:
    def __init__(self, config, *, page_name="FastTrack Fasting",
                 username="fasttrack.fasting.en"):
        self.config = config
        self.page_name = page_name
        self.username = username

    def authorization_url(self, *, state):
        return f"https://facebook.test/oauth?state={state}"

    def exchange_code(self, code):
        return MetaToken("short-user", 3600)

    def exchange_long_lived_token(self, token):
        return MetaToken("long-user", 5184000)

    def discover_page_pairs(self, token):
        return (MetaPagePair(
            "page-123", self.page_name, "page-access-secret", ("CREATE_CONTENT",),
            "ig-123", self.username,
        ),)


def setup_service(tmp_path, **fake_options):
    db = Database.open(tmp_path / "campaign.db")
    db.connection.executemany(
        """INSERT INTO account_connection(id,platform,locale,public_identity,enabled)
        VALUES(?,?,?,?,0)""",
        (
            ("en-facebook", "facebook", "en", "FastTrack Fasting"),
            ("en-instagram", "instagram", "en", "@fasttrack.fasting.en"),
        ),
    )
    db.connection.commit()
    vault = CredentialVault(MemoryKeyring())
    service = MetaConnectionService(
        db, vault, client_factory=lambda config: FakeMetaOAuth(config, **fake_options),
    )
    return db, vault, service


def test_meta_connection_verifies_and_enables_page_and_instagram_as_one_pair(tmp_path):
    db, vault, service = setup_service(tmp_path)
    service.save_developer_credentials("app-id", "app-secret")

    start = service.begin(
        "en", redirect_uri="http://127.0.0.1:8811/oauth/meta/callback", state="state-123",
    )
    connected = service.complete(
        "en", redirect_uri="http://127.0.0.1:8811/oauth/meta/callback", code="code-123",
    )

    assert start.authorization_url == "https://facebook.test/oauth?state=state-123"
    assert connected.account_ids == ("en-facebook", "en-instagram")
    facebook = AccountConnectionRepository(db).get("en-facebook")
    instagram = AccountConnectionRepository(db).get("en-instagram")
    assert facebook["provider_identity"] == "page-123" and facebook["enabled"] == 1
    assert instagram["provider_identity"] == "ig-123" and instagram["enabled"] == 1
    assert json.loads(vault.get("oauth:en-facebook"))["access_token"] == "page-access-secret"
    assert json.loads(vault.get("oauth:en-instagram"))["access_token"] == "page-access-secret"
    assert "page-access-secret" not in str(dict(facebook)) + str(dict(instagram))
    db.close()


def test_meta_connection_rejects_mismatched_pair_without_partial_credentials(tmp_path):
    db, vault, service = setup_service(tmp_path, username="wrong.handle")
    service.save_developer_credentials("app-id", "app-secret")

    with pytest.raises(ValueError, match="does not match"):
        service.complete(
            "en", redirect_uri="http://127.0.0.1:8811/oauth/meta/callback", code="code-123",
        )

    assert vault.get("oauth:en-facebook") is None
    assert vault.get("oauth:en-instagram") is None
    assert AccountConnectionRepository(db).get("en-facebook")["enabled"] == 0
    assert AccountConnectionRepository(db).get("en-instagram")["enabled"] == 0
    db.close()


def test_meta_pair_disconnect_removes_both_tokens_and_disables_both_rows(tmp_path):
    db, vault, service = setup_service(tmp_path)
    service.save_developer_credentials("app-id", "app-secret")
    service.complete(
        "en", redirect_uri="http://127.0.0.1:8811/oauth/meta/callback", code="code-123",
    )

    service.disconnect("en")

    assert vault.get("oauth:en-facebook") is None
    assert vault.get("oauth:en-instagram") is None
    assert AccountConnectionRepository(db).get("en-facebook")["enabled"] == 0
    assert AccountConnectionRepository(db).get("en-instagram")["enabled"] == 0
    db.close()
