"""TikTok desktop OAuth with loopback redirect, PKCE, and least-privilege scopes."""

from dataclasses import dataclass
from hashlib import sha256
from urllib.parse import urlencode, urlparse

import httpx


REQUIRED_SCOPES = frozenset({"user.info.basic", "user.info.profile", "video.upload"})


@dataclass(frozen=True)
class TikTokOAuthConfig:
    client_key: str
    client_secret: str
    redirect_uri: str

    def __post_init__(self) -> None:
        parsed = urlparse(self.redirect_uri)
        if parsed.scheme not in {"http", "https"} or parsed.hostname not in {"127.0.0.1", "localhost"}:
            raise ValueError("TikTok desktop redirect must use localhost or 127.0.0.1")
        if not parsed.port:
            raise ValueError("TikTok desktop redirect must include a port")


@dataclass(frozen=True)
class TikTokTokens:
    access_token: str
    refresh_token: str
    open_id: str
    granted_scopes: frozenset[str]
    expires_in: int
    refresh_expires_in: int


@dataclass(frozen=True)
class TikTokIdentity:
    open_id: str
    display_name: str
    username: str
    profile_deep_link: str
    avatar_url: str


class TikTokOAuthClient:
    AUTHORIZE_URL = "https://www.tiktok.com/v2/auth/authorize/"
    TOKEN_URL = "https://open.tiktokapis.com/v2/oauth/token/"
    IDENTITY_URL = "https://open.tiktokapis.com/v2/user/info/"

    def __init__(self, config: TikTokOAuthConfig, *, transport: httpx.BaseTransport | None = None):
        self.config = config
        self.http = httpx.Client(transport=transport, timeout=30)

    def authorization_url(self, *, state: str, code_verifier: str) -> str:
        if not 43 <= len(code_verifier) <= 128:
            raise ValueError("PKCE verifier must contain 43-128 characters")
        query = urlencode({
            "client_key": self.config.client_key,
            "response_type": "code",
            "scope": ",".join(sorted(REQUIRED_SCOPES)),
            "redirect_uri": self.config.redirect_uri,
            "state": state,
            "code_challenge": sha256(code_verifier.encode()).hexdigest(),
            "code_challenge_method": "S256",
            "disable_auto_auth": "1",
        })
        return f"{self.AUTHORIZE_URL}?{query}"

    def exchange_code(self, code: str, code_verifier: str) -> TikTokTokens:
        response = self.http.post(self.TOKEN_URL, data={
            "client_key": self.config.client_key,
            "client_secret": self.config.client_secret,
            "code": code,
            "grant_type": "authorization_code",
            "redirect_uri": self.config.redirect_uri,
            "code_verifier": code_verifier,
        })
        payload = self._payload(response)
        scopes = frozenset(filter(None, payload.get("scope", "").split(",")))
        missing = REQUIRED_SCOPES - scopes
        if missing:
            raise ValueError(f"TikTok authorization is missing required scopes: {', '.join(sorted(missing))}")
        try:
            return TikTokTokens(
                access_token=payload["access_token"], refresh_token=payload["refresh_token"],
                open_id=payload["open_id"], granted_scopes=scopes,
                expires_in=int(payload["expires_in"]),
                refresh_expires_in=int(payload["refresh_expires_in"]),
            )
        except (KeyError, TypeError, ValueError):
            raise ValueError("TikTok returned an incomplete token response") from None

    def fetch_identity(self, access_token: str) -> TikTokIdentity:
        response = self.http.get(
            self.IDENTITY_URL,
            params={"fields": "open_id,display_name,username,profile_deep_link,avatar_url"},
            headers={"Authorization": f"Bearer {access_token}"},
        )
        payload = self._payload(response)
        error = payload.get("error", {})
        if error.get("code") not in {None, "ok"}:
            raise ValueError("TikTok identity lookup failed")
        try:
            user = payload["data"]["user"]
            return TikTokIdentity(
                open_id=user["open_id"], display_name=user["display_name"],
                username=user["username"], profile_deep_link=user["profile_deep_link"],
                avatar_url=user.get("avatar_url", ""),
            )
        except (KeyError, TypeError):
            raise ValueError("TikTok returned an incomplete identity response") from None

    @staticmethod
    def _payload(response: httpx.Response) -> dict:
        try:
            payload = response.json()
        except ValueError:
            raise ValueError("TikTok returned an invalid response") from None
        if response.status_code >= 400 or not isinstance(payload, dict):
            raise ValueError("TikTok authorization request failed")
        error = payload.get("error")
        if (isinstance(error, str) and error) or (
            isinstance(error, dict) and error.get("code") not in {None, "ok"}
        ):
            raise ValueError("TikTok authorization request failed")
        return payload
