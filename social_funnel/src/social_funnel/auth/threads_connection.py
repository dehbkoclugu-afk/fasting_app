"""Connect a Threads account while keeping credentials in the OS vault."""

from dataclasses import dataclass
import json
from typing import Callable

from social_funnel.auth.threads_oauth import ThreadsOAuthClient, ThreadsOAuthConfig
from social_funnel.auth.token_store import AccountTokenStore
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


@dataclass(frozen=True)
class ThreadsOAuthStart:
    account_id: str
    authorization_url: str


@dataclass(frozen=True)
class ConnectedThreadsAccount:
    account_id: str
    provider_identity: str
    public_identity: str


class ThreadsConnectionService:
    DEVELOPER_CREDENTIAL = "provider:threads"

    def __init__(self, database: Database, vault: CredentialVault, *,
                 client_factory: Callable[[ThreadsOAuthConfig], ThreadsOAuthClient] = ThreadsOAuthClient):
        self.accounts = AccountConnectionRepository(database)
        self.vault = vault
        self.tokens = AccountTokenStore(vault)
        self.client_factory = client_factory

    def save_developer_credentials(self, app_id: str, app_secret: str) -> None:
        if not app_id.strip() or not app_secret.strip():
            raise ValueError("Threads app ID and secret are required")
        self.vault.set(self.DEVELOPER_CREDENTIAL, json.dumps({
            "app_id": app_id.strip(), "app_secret": app_secret.strip(),
        }, separators=(",", ":")))

    def configured(self) -> bool:
        return self.vault.get(self.DEVELOPER_CREDENTIAL) is not None

    def begin(self, account_id: str, *, redirect_uri: str, state: str) -> ThreadsOAuthStart:
        self._threads_account(account_id)
        client = self.client_factory(self._config(redirect_uri))
        return ThreadsOAuthStart(account_id, client.authorization_url(state=state))

    def complete(self, account_id: str, *, redirect_uri: str, code: str) -> ConnectedThreadsAccount:
        account = self._threads_account(account_id)
        client = self.client_factory(self._config(redirect_uri))
        short = client.exchange_code(code)
        long_lived = client.exchange_long_lived_token(short.access_token)
        identity = client.fetch_identity(long_lived.access_token)
        if identity.user_id != short.user_id:
            raise ValueError("Threads token identity does not match profile identity")
        expected = (account["public_identity"] or "").casefold().removeprefix("@")
        actual = identity.username.casefold().removeprefix("@")
        if not expected or actual != expected:
            raise ValueError("Connected Threads handle does not match the selected account")
        vault_reference = f"oauth:{account_id}"
        self.tokens.save(account_id, {
            "access_token": long_lived.access_token,
            "user_id": identity.user_id,
            "expires_in": long_lived.expires_in,
            "redirect_uri": redirect_uri,
        })
        try:
            self.accounts.mark_connected(
                account_id, provider_identity=identity.user_id,
                public_identity=f"@{identity.username}", vault_reference=vault_reference,
                capabilities={"publish": True, "scopes": ["threads_basic", "threads_content_publish"]},
            )
        except Exception:
            self.vault.delete(vault_reference)
            raise
        return ConnectedThreadsAccount(account_id, identity.user_id, f"@{identity.username}")

    def access_token(self, account_id: str) -> str:
        account = self._threads_account(account_id)

        def refresh(old: dict) -> dict:
            client = self.client_factory(self._config(old["redirect_uri"]))
            refreshed = client.refresh_long_lived_token(
                old["access_token"], user_id=old["user_id"],
            )
            if refreshed.user_id != account["provider_identity"]:
                raise ValueError("Refreshed Threads identity does not match connected account")
            return {
                "access_token": refreshed.access_token,
                "user_id": refreshed.user_id,
                "expires_in": refreshed.expires_in,
                "redirect_uri": old["redirect_uri"],
            }

        return self.tokens.access_token(account_id, refresh=refresh)

    def disconnect(self, account_id: str) -> None:
        account = self._threads_account(account_id)
        if account["vault_reference"]:
            self.vault.delete(account["vault_reference"])
        self.accounts.disconnect(account_id)

    def _threads_account(self, account_id: str):
        account = self.accounts.get(account_id)
        if account["platform"] != "threads":
            raise ValueError("Selected account is not a Threads destination")
        return account

    def _config(self, redirect_uri: str) -> ThreadsOAuthConfig:
        stored = self.vault.get(self.DEVELOPER_CREDENTIAL)
        if not stored:
            raise ValueError("Threads developer app is not configured")
        try:
            payload = json.loads(stored)
            return ThreadsOAuthConfig(
                app_id=payload["app_id"], app_secret=payload["app_secret"],
                redirect_uri=redirect_uri,
            )
        except (KeyError, TypeError, json.JSONDecodeError):
            raise ValueError("Threads developer app configuration is invalid") from None
