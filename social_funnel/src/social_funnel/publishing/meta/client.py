"""Versioned Graph transport with normalized errors and container polling."""

from collections.abc import Callable

import httpx

from social_funnel.publishing.meta.errors import MetaApiError


class MetaGraphClient:
    def __init__(self, token: str, *, version: str, transport: httpx.BaseTransport | None = None,
                 graph_host: str = "https://graph.facebook.com"):
        if not version.startswith("v") or not version[1:].replace(".", "").isdigit():
            raise ValueError("Explicit Graph API version required")
        self.token = token
        self.base = f"{graph_host.rstrip('/')}/{version}"
        self.http = httpx.Client(transport=transport, timeout=30)

    def request(self, method: str, path: str, *, params: dict | None = None,
                data: dict | None = None, files: dict | None = None) -> dict:
        response = self.http.request(method, f"{self.base}/{path.lstrip('/')}",
                                     headers={"Authorization": f"Bearer {self.token}"},
                                     params=params, data=data, files=files)
        try:
            payload = response.json()
        except ValueError:
            payload = {}
        embedded = payload.get("error") if isinstance(payload, dict) else None
        if response.status_code >= 400 or embedded:
            code = embedded.get("code") if isinstance(embedded, dict) else None
            reconnect = response.status_code in {401, 403} or code in {10, 190, 200}
            retryable = not reconnect and (response.status_code in {429, 500, 502, 503, 504} or code in {4, 17, 32})
            category = "reconnect" if reconnect else "rate_limit" if retryable and response.status_code == 429 else "api_error"
            raise MetaApiError(category, retryable=retryable, reconnect_required=reconnect)
        if not isinstance(payload, dict):
            raise MetaApiError("invalid_response")
        return payload

    def poll_container(self, container_id: str, *, attempts: int = 10,
                       wait: Callable[[float], None] | None = None) -> dict:
        if wait is None:
            import time
            wait = time.sleep
        for index in range(attempts):
            payload = self.request("GET", container_id, params={"fields": "status_code,status"})
            status = payload.get("status_code", "")
            if status in {"FINISHED", "PUBLISHED"}:
                return payload
            if status == "ERROR":
                raise MetaApiError("container_error", container_id=container_id)
            if index + 1 < attempts:
                wait(min(16, 2 ** index))
        raise MetaApiError("container_pending", retryable=True, container_id=container_id)
