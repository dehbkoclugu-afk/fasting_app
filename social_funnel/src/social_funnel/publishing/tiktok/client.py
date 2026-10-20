"""Thin authenticated TikTok HTTP client; production calls are opt-in only."""

import httpx

from social_funnel.publishing.tiktok.errors import TikTokApiError


class TikTokClient:
    BASE = "https://open.tiktokapis.com"

    def __init__(self, token: str, *, transport: httpx.BaseTransport | None = None):
        self.token = token
        self.http = httpx.Client(transport=transport, timeout=30)

    def request(self, path: str, payload: dict | None = None) -> dict:
        response = self.http.post(f"{self.BASE}{path}",
                                  headers={"Authorization": f"Bearer {self.token}",
                                           "Content-Type": "application/json; charset=UTF-8"},
                                  json=payload or {})
        try:
            body = response.json()
        except ValueError:
            raise TikTokApiError("invalid_response") from None
        error = body.get("error", {})
        code = error.get("code", "ok")
        if response.status_code >= 400 or code != "ok":
            reconnect = response.status_code == 401 or code in {"access_token_invalid", "scope_not_authorized", "auth_removed"}
            retryable = not reconnect and (response.status_code in {429, 500, 502, 503, 504} or code == "rate_limit_exceeded")
            raise TikTokApiError("reconnect" if reconnect else "rate_limit" if retryable else code,
                                 retryable=retryable, reconnect_required=reconnect)
        return body.get("data", {})

    def query_creator_info(self) -> dict:
        return self.request("/v2/post/publish/creator_info/query/")

    def init_video(self, *, review: bool, source_info: dict, post_info: dict | None = None) -> dict:
        path = "/v2/post/publish/inbox/video/init/" if review else "/v2/post/publish/video/init/"
        data = {"source_info": source_info}
        if not review:
            data["post_info"] = post_info or {}
        return self.request(path, data)

    def init_photo(self, *, review: bool, photo_urls: tuple[str, ...], post_info: dict) -> dict:
        return self.request("/v2/post/publish/content/init/", {
            "post_mode": "MEDIA_UPLOAD" if review else "DIRECT_POST", "media_type": "PHOTO",
            "post_info": post_info, "source_info": {"source": "PULL_FROM_URL",
                                                  "photo_cover_index": 0, "photo_images": list(photo_urls)},
        })

    def fetch_status(self, publish_id: str) -> dict:
        data = self.request("/v2/post/publish/status/fetch/", {"publish_id": publish_id})
        if data.get("fail_reason") == "auth_removed":
            raise TikTokApiError("reconnect", reconnect_required=True)
        return data
