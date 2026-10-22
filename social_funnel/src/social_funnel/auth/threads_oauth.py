"""Official Threads OAuth flow with least-privilege publishing scopes."""

from dataclasses import dataclass
from urllib.parse import urlencode, urlparse

import httpx


@dataclass(frozen=True)
class ThreadsOAuthConfig:
    app_id: str
    app_secret: str
    redirect_uri: str

    def __post_init__(self) -> None:
        parsed = urlparse(self.redirect_uri)
        if parsed.scheme not in {"http", "https"}:
            raise ValueError("Threads redirect URI must use HTTP or HTTPS")
        if parsed.scheme == "http" and parsed.hostname not in {"127.0.0.1", "localhost"}:
            raise ValueError("Plain HTTP Threads redirects are allowed only on loopback")
        if parsed.hostname in {"127.0.0.1", "localhost"} and not parsed.port:
            raise ValueError("Loopback Threads redirect must include a port")


@dataclass(frozen=True)
class ThreadsToken:
    access_token: str
    user_id: str
    expires_in: int


@dataclass(frozen=True)
class ThreadsIdentity:
    user_id: str
    username: str


class ThreadsOAuthClient:
    AUTHORIZE_URL = "https://threads.net/oauth/authorize"
    API_URL = "https://graph.threads.net"

    def __init__(self, config: ThreadsOAuthConfig, *, transport: httpx.BaseTransport | None = None):
        self.config = config
        self.http = httpx.Client(transport=transport, timeout=30)

    def authorization_url(self, *, state: str) -> str:
        return f"{self.AUTHORIZE_URL}?{urlencode({
            'client_id': self.config.app_id,
            'redirect_uri': self.config.redirect_uri,
            'scope': 'threads_basic,threads_content_publish',
            'response_type': 'code',
            'state': state,
        })}"

    def exchange_code(self, code: str) -> ThreadsToken:
        response = self.http.post(f"{self.API_URL}/oauth/access_token", data={
            "client_id": self.config.app_id,
            "client_secret": self.config.app_secret,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": self.config.redirect_uri,
        })
        payload = self._payload(response)
        try:
            return ThreadsToken(payload["access_token"], str(payload["user_id"]), 0)
        except (KeyError, TypeError):
            raise ValueError("Threads returned an incomplete token response") from None

    def exchange_long_lived_token(self, short_lived_token: str) -> ThreadsToken:
        response = self.http.get(
            f"{self.API_URL}/access_token",
            params={"grant_type": "th_exchange_token", "client_secret": self.config.app_secret},
            headers={"Authorization": f"Bearer {short_lived_token}"},
        )
        payload = self._payload(response)
        try:
            return ThreadsToken(payload["access_token"], "", int(payload["expires_in"]))
        except (KeyError, TypeError, ValueError):
            raise ValueError("Threads returned an incomplete long-lived token") from None

    def fetch_identity(self, access_token: str) -> ThreadsIdentity:
        response = self.http.get(
            f"{self.API_URL}/me", params={"fields": "id,username"},
            headers={"Authorization": f"Bearer {access_token}"},
        )
        payload = self._payload(response)
        try:
            return ThreadsIdentity(str(payload["id"]), payload["username"])
        except (KeyError, TypeError):
            raise ValueError("Threads returned an incomplete identity response") from None

    @staticmethod
    def _payload(response: httpx.Response) -> dict:
        try:
            payload = response.json()
        except ValueError:
            raise ValueError("Threads returned an invalid response") from None
        if response.status_code >= 400 or not isinstance(payload, dict) or payload.get("error"):
            raise ValueError("Threads authorization request failed")
        return payload
