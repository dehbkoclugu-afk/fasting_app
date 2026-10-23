"""Meta Facebook Login flow for paired Facebook Page and Instagram accounts."""

from dataclasses import dataclass
from urllib.parse import urlencode, urlparse

import httpx


REQUIRED_SCOPES = (
    "instagram_basic",
    "instagram_content_publish",
    "pages_manage_posts",
    "pages_read_engagement",
    "pages_show_list",
)


@dataclass(frozen=True)
class MetaOAuthConfig:
    app_id: str
    app_secret: str
    redirect_uri: str
    graph_version: str = "v25.0"

    def __post_init__(self) -> None:
        parsed = urlparse(self.redirect_uri)
        if parsed.scheme not in {"http", "https"}:
            raise ValueError("Meta redirect URI must use HTTP or HTTPS")
        if parsed.scheme == "http" and parsed.hostname not in {"127.0.0.1", "localhost"}:
            raise ValueError("Plain HTTP Meta redirects are allowed only on loopback")
        if parsed.hostname in {"127.0.0.1", "localhost"} and not parsed.port:
            raise ValueError("Loopback Meta redirect must include a port")


@dataclass(frozen=True)
class MetaToken:
    access_token: str
    expires_in: int


@dataclass(frozen=True)
class MetaPagePair:
    page_id: str
    page_name: str
    page_access_token: str
    tasks: tuple[str, ...]
    instagram_id: str | None
    instagram_username: str | None


class MetaOAuthClient:
    AUTHORIZE_URL = "https://www.facebook.com/{version}/dialog/oauth"
    GRAPH_URL = "https://graph.facebook.com/{version}"

    def __init__(self, config: MetaOAuthConfig, *, transport: httpx.BaseTransport | None = None):
        self.config = config
        self.http = httpx.Client(transport=transport, timeout=30)

    def authorization_url(self, *, state: str) -> str:
        query = urlencode({
            "client_id": self.config.app_id,
            "redirect_uri": self.config.redirect_uri,
            "response_type": "code",
            "state": state,
            "scope": ",".join(REQUIRED_SCOPES),
        })
        return f"{self.AUTHORIZE_URL.format(version=self.config.graph_version)}?{query}"

    def exchange_code(self, code: str) -> MetaToken:
        response = self.http.post(
            f"{self.GRAPH_URL.format(version=self.config.graph_version)}/oauth/access_token",
            data={
                "client_id": self.config.app_id,
                "client_secret": self.config.app_secret,
                "redirect_uri": self.config.redirect_uri,
                "code": code,
            },
        )
        return self._token(response)

    def exchange_long_lived_token(self, short_lived_token: str) -> MetaToken:
        response = self.http.get(
            f"{self.GRAPH_URL.format(version=self.config.graph_version)}/oauth/access_token",
            params={
                "grant_type": "fb_exchange_token",
                "client_id": self.config.app_id,
                "client_secret": self.config.app_secret,
                "fb_exchange_token": short_lived_token,
            },
        )
        return self._token(response)

    def discover_page_pairs(self, user_access_token: str) -> tuple[MetaPagePair, ...]:
        response = self.http.get(
            f"{self.GRAPH_URL.format(version=self.config.graph_version)}/me/accounts",
            params={
                "fields": "id,name,access_token,tasks,instagram_business_account",
                "access_token": user_access_token,
            },
        )
        payload = self._payload(response)
        try:
            pairs = []
            for item in payload["data"]:
                instagram = item.get("instagram_business_account") or {}
                username = None
                if instagram.get("id"):
                    identity_response = self.http.get(
                        f"{self.GRAPH_URL.format(version=self.config.graph_version)}/{instagram['id']}",
                        params={"fields": "id,username", "access_token": item["access_token"]},
                    )
                    username = self._payload(identity_response).get("username")
                pairs.append(MetaPagePair(
                    page_id=item["id"], page_name=item["name"],
                    page_access_token=item["access_token"],
                    tasks=tuple(item.get("tasks", ())),
                    instagram_id=instagram.get("id"),
                    instagram_username=username,
                ))
            return tuple(pairs)
        except (KeyError, TypeError):
            raise ValueError("Meta returned an incomplete account response") from None

    @classmethod
    def _token(cls, response: httpx.Response) -> MetaToken:
        payload = cls._payload(response)
        try:
            return MetaToken(payload["access_token"], int(payload.get("expires_in", 0)))
        except (KeyError, TypeError, ValueError):
            raise ValueError("Meta returned an incomplete token response") from None

    @staticmethod
    def _payload(response: httpx.Response) -> dict:
        try:
            payload = response.json()
        except ValueError:
            raise ValueError("Meta returned an invalid response") from None
        if response.status_code >= 400 or not isinstance(payload, dict) or payload.get("error"):
            raise ValueError("Meta authorization request failed")
        return payload
