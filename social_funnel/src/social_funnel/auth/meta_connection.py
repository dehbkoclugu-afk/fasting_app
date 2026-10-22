"""Connect one locale's Facebook Page and linked Instagram account as a pair."""

from dataclasses import dataclass
import json
from typing import Callable

from social_funnel.auth.meta_oauth import MetaOAuthClient, MetaOAuthConfig
from social_funnel.auth.vault import CredentialVault
from social_funnel.storage.database import Database
from social_funnel.storage.repositories import AccountConnectionRepository


@dataclass(frozen=True)
class MetaOAuthStart:
    locale: str
    authorization_url: str


@dataclass(frozen=True)
class ConnectedMetaPair:
    locale: str
    account_ids: tuple[str, str]


class MetaConnectionService:
    DEVELOPER_CREDENTIAL = "provider:meta"
    LOCALES = frozenset({"tr", "en", "pt-BR"})

    def __init__(self, database: Database, vault: CredentialVault, *,
                 client_factory: Callable[[MetaOAuthConfig], MetaOAuthClient] = MetaOAuthClient):
        self.accounts = AccountConnectionRepository(database)
        self.vault = vault
        self.client_factory = client_factory

    def save_developer_credentials(self, app_id: str, app_secret: str) -> None:
        if not app_id.strip() or not app_secret.strip():
            raise ValueError("Meta app ID and secret are required")
        self.vault.set(self.DEVELOPER_CREDENTIAL, json.dumps({
            "app_id": app_id.strip(), "app_secret": app_secret.strip(),
        }, separators=(",", ":")))

    def configured(self) -> bool:
        return self.vault.get(self.DEVELOPER_CREDENTIAL) is not None

    def begin(self, locale: str, *, redirect_uri: str, state: str) -> MetaOAuthStart:
        self._accounts_for(locale)
        client = self.client_factory(self._config(redirect_uri))
        return MetaOAuthStart(locale, client.authorization_url(state=state))

    def complete(self, locale: str, *, redirect_uri: str, code: str) -> ConnectedMetaPair:
        facebook, instagram = self._accounts_for(locale)
        client = self.client_factory(self._config(redirect_uri))
        short = client.exchange_code(code)
        long_lived = client.exchange_long_lived_token(short.access_token)
        pairs = client.discover_page_pairs(long_lived.access_token)
        expected_page = (facebook["public_identity"] or "").strip().casefold()
        expected_instagram = (instagram["public_identity"] or "").strip().casefold().removeprefix("@")
        pair = next((item for item in pairs if (
            item.page_name.strip().casefold() == expected_page and
            (item.instagram_username or "").strip().casefold().removeprefix("@") == expected_instagram
        )), None)
        if pair is None:
            raise ValueError("Connected Meta account pair does not match the selected locale")
        if "CREATE_CONTENT" not in pair.tasks or not pair.instagram_id:
            raise ValueError("Connected Meta Page does not have publishing capability")

        account_ids = (facebook["id"], instagram["id"])
        credentials = {
            facebook["id"]: {
                "access_token": pair.page_access_token, "page_id": pair.page_id,
                "expires_in": long_lived.expires_in,
            },
            instagram["id"]: {
                "access_token": pair.page_access_token, "page_id": pair.page_id,
                "instagram_id": pair.instagram_id, "expires_in": long_lived.expires_in,
            },
        }
        for account_id, credential in credentials.items():
            self.vault.set(f"oauth:{account_id}", json.dumps(credential, separators=(",", ":")))
        try:
            self.accounts.mark_meta_pair(
                locale,
                page_identity=pair.page_id,
                page_name=pair.page_name,
                instagram_identity=pair.instagram_id,
                instagram_handle=f"@{pair.instagram_username}",
            )
        except Exception:
            for account_id in account_ids:
                self.vault.delete(f"oauth:{account_id}")
            raise
        return ConnectedMetaPair(locale, account_ids)

    def disconnect(self, locale: str) -> None:
        accounts = self._accounts_for(locale)
        for account in accounts:
            if account["vault_reference"]:
                self.vault.delete(account["vault_reference"])
        for account in accounts:
            self.accounts.disconnect(account["id"])

    def _accounts_for(self, locale: str):
        if locale not in self.LOCALES:
            raise ValueError("Unsupported Meta account locale")
        return (
            self.accounts.get(f"{locale}-facebook"),
            self.accounts.get(f"{locale}-instagram"),
        )

    def _config(self, redirect_uri: str) -> MetaOAuthConfig:
        stored = self.vault.get(self.DEVELOPER_CREDENTIAL)
        if not stored:
            raise ValueError("Meta developer app is not configured")
        try:
            payload = json.loads(stored)
            return MetaOAuthConfig(
                app_id=payload["app_id"], app_secret=payload["app_secret"],
                redirect_uri=redirect_uri,
            )
        except (KeyError, TypeError, json.JSONDecodeError):
            raise ValueError("Meta developer app configuration is invalid") from None
