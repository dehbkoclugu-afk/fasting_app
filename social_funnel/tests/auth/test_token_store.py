import json
from datetime import datetime, timezone

import pytest

from social_funnel.auth.token_store import AccountTokenStore
from social_funnel.auth.vault import CredentialVault


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


NOW = datetime(2026, 10, 22, 12, 0, tzinfo=timezone.utc)


def test_unexpired_account_token_is_returned_without_refresh():
    vault = CredentialVault(MemoryKeyring())
    store = AccountTokenStore(vault, now=lambda: NOW)
    store.save("tr-tiktok", {"access_token": "current", "expires_in": 3600})

    token = store.access_token("tr-tiktok", refresh=lambda _: (_ for _ in ()).throw(AssertionError()))

    assert token == "current"


def test_expiring_account_token_is_rotated_atomically_in_vault():
    vault = CredentialVault(MemoryKeyring())
    vault.set("oauth:tr-tiktok", json.dumps({
        "access_token": "old", "refresh_token": "refresh-old", "expires_at": NOW.timestamp() - 1,
    }))
    store = AccountTokenStore(vault, now=lambda: NOW)

    token = store.access_token("tr-tiktok", refresh=lambda old: {
        "access_token": "new", "refresh_token": "refresh-new", "expires_in": 86400,
        "open_id": old["open_id"] if "open_id" in old else "open-1",
    })

    saved = json.loads(vault.get("oauth:tr-tiktok"))
    assert token == "new"
    assert saved["refresh_token"] == "refresh-new"
    assert saved["expires_at"] == NOW.timestamp() + 86400


def test_expired_token_without_refresh_support_requires_reconnect():
    vault = CredentialVault(MemoryKeyring())
    vault.set("oauth:en-facebook", json.dumps({
        "access_token": "old", "expires_at": NOW.timestamp() - 1,
    }))
    store = AccountTokenStore(vault, now=lambda: NOW)

    with pytest.raises(ValueError, match="reconnect"):
        store.access_token("en-facebook")
