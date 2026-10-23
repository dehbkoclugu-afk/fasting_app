"""Public-media host contract; no credentials in metadata."""

from dataclasses import dataclass
from datetime import datetime
from typing import Protocol

from social_funnel.domain.models import MediaAsset


class HostingDisabled(RuntimeError):
    pass


@dataclass(frozen=True)
class HostedMedia:
    object_key: str
    public_url: str
    expires_at: datetime


class PublicMediaHost(Protocol):
    def put(self, asset: MediaAsset, expires_at: datetime) -> HostedMedia: ...
    def get_public_url(self, hosted: HostedMedia) -> str: ...
    def delete(self, hosted: HostedMedia) -> None: ...
