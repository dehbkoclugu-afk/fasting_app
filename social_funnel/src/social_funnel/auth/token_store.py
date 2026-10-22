"""Expiry-aware account token access backed only by the OS credential vault."""

from collections.abc import Callable
from datetime import datetime, timezone
import json

from social_funnel.auth.vault import CredentialVault


class AccountTokenStore:
    def __init__(self, vault: CredentialVault, *,
                 now: Callable[[], datetime] | None = None, refresh_margin: int = 300):
        self.vault = vault
        self.now = now or (lambda: datetime.now(timezone.utc))
        self.refresh_margin = refresh_margin

    def save(self, account_id: str, payload: dict) -> None:
        self.vault.set(self._key(account_id), self._serialize(payload))

    def access_token(self, account_id: str, *,
                     refresh: Callable[[dict], dict] | None = None) -> str:
        key = self._key(account_id)
        raw = self.vault.get(key)
        payload = self._parse(raw)
        if self._valid(payload):
            return payload["access_token"]
        if refresh is None:
            raise ValueError("Account token expired; reconnect required")

        def rotate(stale: str) -> str:
            return self._serialize(refresh(self._parse(stale)))

        updated = self.vault.refresh(key, rotate, stale_token=raw)
        payload = self._parse(updated)
        if not self._valid(payload):
            raise ValueError("Refreshed account token is already expired")
        return payload["access_token"]

    def _valid(self, payload: dict) -> bool:
        try:
            return bool(payload["access_token"]) and float(payload["expires_at"]) > (
                self.now().timestamp() + self.refresh_margin
            )
        except (KeyError, TypeError, ValueError):
            return False

    def _serialize(self, payload: dict) -> str:
        value = dict(payload)
        try:
            expires_in = int(value["expires_in"])
            value["expires_at"] = self.now().timestamp() + expires_in
        except (KeyError, TypeError, ValueError):
            if "expires_at" not in value:
                raise ValueError("Account token expiry is missing") from None
        if not value.get("access_token"):
            raise ValueError("Account access token is missing")
        return json.dumps(value, separators=(",", ":"), sort_keys=True)

    @staticmethod
    def _parse(raw: str | None) -> dict:
        if not raw:
            raise ValueError("Account credential missing; reconnect required")
        try:
            payload = json.loads(raw)
        except (TypeError, json.JSONDecodeError):
            raise ValueError("Account credential is invalid; reconnect required") from None
        if not isinstance(payload, dict):
            raise ValueError("Account credential is invalid; reconnect required")
        return payload

    @staticmethod
    def _key(account_id: str) -> str:
        return f"oauth:{account_id}"
