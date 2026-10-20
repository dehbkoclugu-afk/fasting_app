from datetime import datetime, timedelta, timezone
from pathlib import Path

import pytest

from social_funnel.domain.models import MediaAsset
from social_funnel.hosting.base import HostingDisabled, HostedMedia
from social_funnel.hosting.s3 import S3MediaHost


class FakeS3:
    def __init__(self):
        self.puts = []
        self.deletes = []

    def upload_file(self, filename, bucket, key, ExtraArgs):
        self.puts.append((filename, bucket, key, ExtraArgs))

    def delete_object(self, Bucket, Key):
        self.deletes.append((Bucket, Key))


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
