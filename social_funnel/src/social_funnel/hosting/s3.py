"""S3-compatible upload with opaque keys and explicit cleanup."""

from datetime import datetime, timedelta, timezone
from uuid import uuid4

from social_funnel.domain.models import MediaAsset
from social_funnel.hosting.base import HostedMedia, HostingDisabled


class S3MediaHost:
    def __init__(self, client, *, bucket: str, public_base_url: str):
        if not public_base_url.startswith("https://"):
            raise ValueError("Public media base URL must use HTTPS")
        self.client = client
        self.bucket = bucket
        self.base = public_base_url.rstrip("/")
        self._deleted: set[str] = set()

    def put(self, asset: MediaAsset, expires_at: datetime) -> HostedMedia:
        if self.client is None:
            raise HostingDisabled("Public media host is not configured; use manual export until connected.")
        if expires_at.tzinfo is None or expires_at < datetime.now(timezone.utc) + timedelta(hours=1):
            raise ValueError("Media expiry must be at least one hour in the future")
        if not asset.path.is_file():
            raise FileNotFoundError(asset.path)
        extension = ".mp4" if asset.mime_type == "video/mp4" else ".png"
        key = f"campaign/{uuid4().hex}{extension}"
        self.client.upload_file(str(asset.path), self.bucket, key, ExtraArgs={"ContentType": asset.mime_type})
        return HostedMedia(key, f"{self.base}/{key}", expires_at)

    def get_public_url(self, hosted: HostedMedia) -> str:
        return hosted.public_url

    def delete(self, hosted: HostedMedia) -> None:
        if hosted.object_key not in self._deleted and self.client is not None:
            self.client.delete_object(Bucket=self.bucket, Key=hosted.object_key)
            self._deleted.add(hosted.object_key)
