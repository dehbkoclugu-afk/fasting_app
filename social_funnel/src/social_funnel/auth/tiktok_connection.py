"""Coordinate TikTok OAuth without persisting credentials outside the OS vault."""

from dataclasses import dataclass
import json
from typing import Callable

from social_funnel.auth.tiktok_oauth import TikTokOAuthClient, TikTokOAuthConfig
from social_funnel.auth.token_store import AccountTokenStore
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


@dataclass(frozen=True)
class TikTokOAuthStart:
    account_id: str
    authorization_url: str


@dataclass(frozen=True)
class ConnectedTikTokAccount:
    account_id: str
    provider_identity: str
    public_identity: str


class TikTokConnectionService:
    DEVELOPER_CREDENTIAL = "provider:tiktok"

    def __init__(self, database: Database, vault: CredentialVault, *,
                 client_factory: Callable[[TikTokOAuthConfig], TikTokOAuthClient] = TikTokOAuthClient):
        self.accounts = AccountConnectionRepository(database)
        self.vault = vault
        self.tokens = AccountTokenStore(vault)
        self.client_factory = client_factory

    def save_developer_credentials(self, client_key: str, client_secret: str) -> None:
        if not client_key.strip() or not client_secret.strip():
            raise ValueError("TikTok developer key and secret are required")
        self.vault.set(self.DEVELOPER_CREDENTIAL, json.dumps({
            "client_key": client_key.strip(), "client_secret": client_secret.strip(),
        }, separators=(",", ":")))

    def configured(self) -> bool:
        return self.vault.get(self.DEVELOPER_CREDENTIAL) is not None

    def begin(self, account_id: str, *, redirect_uri: str, state: str,
              verifier: str) -> TikTokOAuthStart:
        account = self._tiktok_account(account_id)
        client = self.client_factory(self._config(redirect_uri))
        return TikTokOAuthStart(
            account_id=account["id"],
            authorization_url=client.authorization_url(state=state, code_verifier=verifier),
        )

    def complete(self, account_id: str, *, redirect_uri: str, code: str,
                 verifier: str) -> ConnectedTikTokAccount:
        account = self._tiktok_account(account_id)
        client = self.client_factory(self._config(redirect_uri))
        tokens = client.exchange_code(code, verifier)
        identity = client.fetch_identity(tokens.access_token)
        if identity.open_id != tokens.open_id:
            raise ValueError("TikTok token identity does not match profile identity")
        expected = (account["public_identity"] or "").casefold().removeprefix("@")
        actual = identity.username.casefold().removeprefix("@")
        if not expected or actual != expected:
            raise ValueError("Connected TikTok handle does not match the selected account")

        vault_reference = f"oauth:{account_id}"
        credential = json.dumps({
            "access_token": tokens.access_token,
            "refresh_token": tokens.refresh_token,
            "open_id": tokens.open_id,
            "granted_scopes": sorted(tokens.granted_scopes),
            "expires_in": tokens.expires_in,
            "refresh_expires_in": tokens.refresh_expires_in,
            "redirect_uri": redirect_uri,
        }, separators=(",", ":"))
        self.tokens.save(account_id, json.loads(credential))
        try:
            self.accounts.mark_connected(
                account_id,
                provider_identity=identity.open_id,
                public_identity=f"@{identity.username}",
                vault_reference=vault_reference,
                capabilities={
                    "review_upload": True,
                    "direct_public": False,
                    "profile_url": identity.profile_deep_link,
                    "scopes": sorted(tokens.granted_scopes),
                },
            )
        except Exception:
            self.vault.delete(vault_reference)
            raise
        return ConnectedTikTokAccount(account_id, identity.open_id, f"@{identity.username}")

    def access_token(self, account_id: str) -> str:
        account = self._tiktok_account(account_id)

        def refresh(old: dict) -> dict:
            client = self.client_factory(self._config(old["redirect_uri"]))
            refreshed = client.refresh_token(old["refresh_token"])
            if refreshed.open_id != account["provider_identity"]:
                raise ValueError("Refreshed TikTok identity does not match connected account")
            return {
                "access_token": refreshed.access_token,
                "refresh_token": refreshed.refresh_token,
                "open_id": refreshed.open_id,
                "granted_scopes": sorted(refreshed.granted_scopes),
                "expires_in": refreshed.expires_in,
                "refresh_expires_in": refreshed.refresh_expires_in,
                "redirect_uri": old["redirect_uri"],
            }

        return self.tokens.access_token(account_id, refresh=refresh)

    def disconnect(self, account_id: str) -> None:
        account = self._tiktok_account(account_id)
        if account["vault_reference"]:
            self.vault.delete(account["vault_reference"])
        self.accounts.disconnect(account_id)

    def _config(self, redirect_uri: str) -> TikTokOAuthConfig:
        stored = self.vault.get(self.DEVELOPER_CREDENTIAL)
        if not stored:
            raise ValueError("TikTok developer app is not configured")
        try:
            payload = json.loads(stored)
            return TikTokOAuthConfig(
                client_key=payload["client_key"],
                client_secret=payload["client_secret"],
                redirect_uri=redirect_uri,
            )
        except (KeyError, TypeError, json.JSONDecodeError):
            raise ValueError("TikTok developer app configuration is invalid") from None

    def _tiktok_account(self, account_id: str):
        account = self.accounts.get(account_id)
        if account["platform"] != "tiktok":
            raise ValueError("Selected account is not a TikTok destination")
        return account
