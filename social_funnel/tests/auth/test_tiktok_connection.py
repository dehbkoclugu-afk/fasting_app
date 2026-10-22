import json

import pytest

from social_funnel.auth.tiktok_connection import TikTokConnectionService
from social_funnel.auth.tiktok_oauth import TikTokIdentity, TikTokTokens
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


class FakeOAuth:
    def __init__(self, config, username="fasttrack.fasting.tr"):
        self.config = config
        self.username = username

    def authorization_url(self, *, state, code_verifier):
        return f"https://authorize.test/?state={state}&verifier={code_verifier}"

    def exchange_code(self, code, code_verifier):
        return TikTokTokens(
            "access-secret", "refresh-secret", "open-123",
            frozenset({"user.info.basic", "user.info.profile", "video.upload"}),
            86400, 31536000,
        )

    def fetch_identity(self, access_token):
        return TikTokIdentity(
            "open-123", "FastTrack TR", self.username,
            f"https://www.tiktok.com/@{self.username}", "https://example.test/avatar.jpg",
        )


def setup_service(tmp_path, *, username="fasttrack.fasting.tr"):
    db = Database.open(tmp_path / "campaign.db")
    db.connection.execute(
        """INSERT INTO account_connection(id,platform,locale,public_identity,enabled)
        VALUES('tr-tiktok','tiktok','tr','@fasttrack.fasting.tr',0)"""
    )
    db.connection.commit()
    vault = CredentialVault(MemoryKeyring())
    service = TikTokConnectionService(
        db, vault, client_factory=lambda config: FakeOAuth(config, username),
    )
    return db, vault, service


def test_tiktok_connection_keeps_secrets_in_vault_and_marks_verified_identity(tmp_path):
    db, vault, service = setup_service(tmp_path)
    service.save_developer_credentials("client-key", "client-secret")

    start = service.begin(
        "tr-tiktok", redirect_uri="http://127.0.0.1:8811/oauth/tiktok/callback",
        state="state-123", verifier="v" * 64,
    )
    connected = service.complete(
        "tr-tiktok", redirect_uri="http://127.0.0.1:8811/oauth/tiktok/callback",
        code="code-123", verifier="v" * 64,
    )

    assert start.authorization_url.startswith("https://authorize.test/")
    assert connected.public_identity == "@fasttrack.fasting.tr"
    saved = json.loads(vault.get("oauth:tr-tiktok"))
    assert saved["access_token"] == "access-secret"
    row = AccountConnectionRepository(db).get("tr-tiktok")
    assert row["provider_identity"] == "open-123"
    assert row["vault_reference"] == "oauth:tr-tiktok"
    assert "access-secret" not in str(dict(row))
    db.close()


def test_tiktok_connection_rejects_the_wrong_public_handle_without_saving_tokens(tmp_path):
    db, vault, service = setup_service(tmp_path, username="someone.else")
    service.save_developer_credentials("client-key", "client-secret")

    with pytest.raises(ValueError, match="does not match"):
        service.complete(
            "tr-tiktok", redirect_uri="http://127.0.0.1:8811/oauth/tiktok/callback",
            code="code-123", verifier="v" * 64,
        )

    assert vault.get("oauth:tr-tiktok") is None
    assert AccountConnectionRepository(db).get("tr-tiktok")["enabled"] == 0
    db.close()
