from pathlib import Path

import httpx

from social_funnel.publishing.tiktok.uploads import chunk_ranges, upload_video_file


def test_chunk_ranges_exact_divisibility():
    assert list(chunk_ranges(20, 10)) == [(0, 9), (10, 19)]
    assert list(chunk_ranges(21, 10)) == [(0, 9), (10, 19), (20, 20)]


def test_upload_uses_content_range_without_logging_signed_url(tmp_path):
    path = tmp_path / "clip.mp4"; path.write_bytes(b"0123456789")
    seen = []
    def handler(request):
        seen.append((request.headers["Content-Range"], request.content))
        return httpx.Response(200)
    client = httpx.Client(transport=httpx.MockTransport(handler))
    upload_video_file(client, "https://upload.tiktokapis.com/video?upload_token=secret", path, chunk_size=5)
    assert seen == [("bytes 0-4/10", b"01234"), ("bytes 5-9/10", b"56789")]
