from concurrent.futures import ThreadPoolExecutor

from social_funnel.auth.vault import CredentialVault


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


def test_vault_uses_keyring_not_database():
    backend = MemoryKeyring()
    vault = CredentialVault(backend)
    vault.set("tr-instagram", "secret-token")
    assert vault.get("tr-instagram") == "secret-token"
    assert list(backend.values) == [("FastTrack Social Funnel", "tr-instagram")]
    vault.delete("tr-instagram")
    assert vault.get("tr-instagram") is None


def test_refresh_serializes_per_account():
    vault = CredentialVault(MemoryKeyring())
    vault.set("tr-instagram", "one")
    calls = []
    def refresh(old):
        calls.append(old)
        return "two"
    with ThreadPoolExecutor(max_workers=2) as pool:
        values = list(pool.map(lambda _: vault.refresh("tr-instagram", refresh, stale_token="one"), range(2)))
    assert values == ["two", "two"]
    assert calls == ["one"]
