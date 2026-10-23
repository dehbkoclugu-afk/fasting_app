"""Windows Credential Manager via keyring; one account refresh at a time."""

from collections import defaultdict
from threading import Lock
from typing import Callable


class CredentialVault:
    SERVICE = "FastTrack Social Funnel"

    def __init__(self, backend=None):
        self.backend = backend
        self._locks: dict[str, Lock] = defaultdict(Lock)

    def _backend(self):
        if self.backend is None:
            import keyring
            self.backend = keyring
        return self.backend

    def get(self, account_id: str) -> str | None:
        return self._backend().get_password(self.SERVICE, account_id)

    def set(self, account_id: str, token: str) -> None:
        if not token:
            raise ValueError("Empty access token")
        self._backend().set_password(self.SERVICE, account_id, token)

    def delete(self, account_id: str) -> None:
        if self.get(account_id) is not None:
            self._backend().delete_password(self.SERVICE, account_id)

    def refresh(self, account_id: str, refresh_fn: Callable[[str], str], *, stale_token: str) -> str:
        with self._locks[account_id]:
            current = self.get(account_id)
            if current is None:
                raise ValueError("Account credential missing; reconnect")
            if current != stale_token:
                return current
            new_token = refresh_fn(current)
            self.set(account_id, new_token)
            return new_token
