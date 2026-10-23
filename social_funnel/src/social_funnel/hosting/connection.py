"""Vault-backed S3-compatible media hosting for URL-only publisher APIs."""

from datetime import datetime, timedelta, timezone
from hashlib import sha256
import json
import mimetypes
from pathlib import Path
from urllib.parse import urlparse

from social_funnel.domain.models import MediaAsset
from social_funnel.hosting.s3 import S3MediaHost


class MediaHostingService:
    CREDENTIAL = "provider:media-host"

    def __init__(self, vault, *, client_factory=None):
        self.vault = vault
        self.client_factory = client_factory or self._boto_client
        self._urls: dict[str, str] = {}

    def configure(self, *, endpoint_url: str, bucket: str, public_base_url: str,
                  access_key_id: str, secret_access_key: str, region: str = "auto") -> None:
        values = {
            "endpoint_url": endpoint_url.strip().rstrip("/"),
            "bucket": bucket.strip(),
            "public_base_url": public_base_url.strip().rstrip("/"),
            "access_key_id": access_key_id.strip(),
            "secret_access_key": secret_access_key.strip(),
            "region": region.strip() or "auto",
        }
        for name in ("endpoint_url", "public_base_url"):
            parsed = urlparse(values[name])
            if parsed.scheme != "https" or not parsed.netloc:
                raise ValueError(f"{name} must be a public HTTPS URL")
        if not values["bucket"] or not values["access_key_id"] or not values["secret_access_key"]:
            raise ValueError("Bucket and access credentials are required")
        self.vault.set(self.CREDENTIAL, json.dumps(values, separators=(",", ":")))
        self._urls.clear()

    def configured(self) -> bool:
        return self.vault.get(self.CREDENTIAL) is not None

    def disconnect(self) -> None:
        self.vault.delete(self.CREDENTIAL)
        self._urls.clear()

    def url_for(self, path: Path) -> str:
        path = Path(path)
        if not path.is_file():
            raise FileNotFoundError(path)
        checksum = sha256(path.read_bytes()).hexdigest()
        if checksum in self._urls:
            return self._urls[checksum]
        config = self._config()
        mime_type = mimetypes.guess_type(path.name)[0]
        if mime_type not in {"image/png", "image/jpeg", "video/mp4"}:
            raise ValueError("Only PNG, JPEG, and MP4 media can be hosted")
        client = self.client_factory(
            endpoint_url=config["endpoint_url"],
            aws_access_key_id=config["access_key_id"],
            aws_secret_access_key=config["secret_access_key"],
            region_name=config["region"],
        )
        host = S3MediaHost(
            client, bucket=config["bucket"], public_base_url=config["public_base_url"],
        )
        hosted = host.put(
            MediaAsset(
                path=path, width=1, height=1, checksum=checksum,
                mime_type=mime_type,
            ),
            datetime.now(timezone.utc) + timedelta(days=7),
        )
        url = host.get_public_url(hosted)
        self._urls[checksum] = url
        return url

    def _config(self) -> dict:
        stored = self.vault.get(self.CREDENTIAL)
        if not stored:
            raise ValueError("Public media hosting is not configured")
        try:
            config = json.loads(stored)
            required = {
                "endpoint_url", "bucket", "public_base_url", "access_key_id",
                "secret_access_key", "region",
            }
            if not required.issubset(config):
                raise ValueError
            return config
        except (TypeError, json.JSONDecodeError, ValueError):
            raise ValueError("Public media hosting configuration is invalid") from None

    @staticmethod
    def _boto_client(**options):
        import boto3
        return boto3.client("s3", **options)
