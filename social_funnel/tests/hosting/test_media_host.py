from datetime import datetime, timedelta, timezone
from pathlib import Path

import pytest

from social_funnel.domain.models import MediaAsset
from social_funnel.auth.vault import CredentialVault
from social_funnel.hosting.base import HostingDisabled, HostedMedia
from social_funnel.hosting.connection import MediaHostingService
from social_funnel.hosting.s3 import S3MediaHost


class FakeS3:
    def __init__(self):
        self.puts = []
        self.deletes = []

    def upload_file(self, filename, bucket, key, ExtraArgs):
        self.puts.append((filename, bucket, key, ExtraArgs))

    def delete_object(self, Bucket, Key):
        self.deletes.append((Bucket, Key))


class MemoryKeyring:
    def __init__(self): self.values = {}
    def get_password(self, service, user): return self.values.get((service, user))
    def set_password(self, service, user, password): self.values[(service, user)] = password
    def delete_password(self, service, user): self.values.pop((service, user), None)


def test_public_host_uses_opaque_keys_and_https(tmp_path):
    path = tmp_path / "özel görsel.png"
    path.write_bytes(b"image")
    client = FakeS3()
    host = S3MediaHost(client, bucket="social", public_base_url="https://media.example.test")
    asset = MediaAsset(path=path, width=1080, height=1350, checksum="sha", mime_type="image/png")
    expiry = datetime.now(timezone.utc) + timedelta(days=2)
    hosted = host.put(asset, expiry)
    assert "özel" not in hosted.object_key and "Users" not in hosted.object_key
    assert host.get_public_url(hosted).startswith("https://media.example.test/")
    assert client.puts[0][3]["ContentType"] == "image/png"
    assert "token" not in str(hosted).lower()
    host.delete(hosted)
    host.delete(hosted)
    assert client.deletes == [("social", hosted.object_key)]


def test_retries_reuse_checksum_key_instead_of_leaking_duplicate_objects(tmp_path):
    path = tmp_path / "card.png"
    path.write_bytes(b"image")
    client = FakeS3()
    host = S3MediaHost(client, bucket="social", public_base_url="https://media.example.test")
    asset = MediaAsset(
        path=path, width=1080, height=1350,
        checksum="a" * 64, mime_type="image/png",
    )
    expiry = datetime.now(timezone.utc) + timedelta(days=2)

    first = host.put(asset, expiry)
    second = host.put(asset, expiry)

    assert first.object_key == second.object_key == f"campaign/{'a' * 64}.png"
    assert client.puts[0][3]["Expires"] == expiry


def test_hosted_extension_matches_jpeg_content_type(tmp_path):
    path = tmp_path / "card.jpg"
    path.write_bytes(b"jpeg")
    host = S3MediaHost(FakeS3(), bucket="social", public_base_url="https://media.example.test")
    hosted = host.put(
        MediaAsset(path=path, width=1, height=1, checksum="b" * 64, mime_type="image/jpeg"),
        datetime.now(timezone.utc) + timedelta(days=1),
    )
    assert hosted.object_key.endswith(".jpg")


def test_rejects_unsafe_public_url_and_short_expiry(tmp_path):
    with pytest.raises(ValueError, match="HTTPS"):
        S3MediaHost(FakeS3(), bucket="social", public_base_url="http://localhost")
    asset = MediaAsset(path=tmp_path / "x.png", width=100, height=100, checksum="x", mime_type="image/png")
    asset.path.write_bytes(b"x")
    with pytest.raises(ValueError, match="expiry"):
        S3MediaHost(FakeS3(), bucket="social", public_base_url="https://cdn.test").put(
            asset, datetime.now(timezone.utc) + timedelta(minutes=10))


def test_disabled_host_blocks_upload(tmp_path):
    with pytest.raises(HostingDisabled):
        S3MediaHost(None, bucket="social", public_base_url="https://cdn.test").put(
            MediaAsset(path=tmp_path / "x", width=1, height=1, checksum="x", mime_type="image/png"),
            datetime.now(timezone.utc) + timedelta(days=1))


def test_connection_keeps_credentials_in_vault_and_reuses_hosted_file(tmp_path):
    backend = MemoryKeyring()
    vault = CredentialVault(backend)
    client = FakeS3()
    client_options = []
    service = MediaHostingService(
        vault, client_factory=lambda **options: client_options.append(options) or client,
    )
    service.configure(
        endpoint_url="https://account.r2.cloudflarestorage.com",
        bucket="fasttrack-media",
        public_base_url="https://media.fasttrack.test",
        access_key_id="access-id",
        secret_access_key="secret-key",
        region="auto",
    )
    image = tmp_path / "card.png"
    image.write_bytes(b"same-image")

    first = service.url_for(image)
    second = service.url_for(image)

    assert first == second
    assert first.startswith("https://media.fasttrack.test/campaign/")
    assert len(client.puts) == 1
    assert client_options == [{
        "endpoint_url": "https://account.r2.cloudflarestorage.com",
        "aws_access_key_id": "access-id",
        "aws_secret_access_key": "secret-key",
        "region_name": "auto",
    }]
    assert service.configured()
    assert "secret-key" not in first
