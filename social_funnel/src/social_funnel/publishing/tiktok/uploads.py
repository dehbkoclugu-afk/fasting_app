"""Single-use signed upload URL handling with exact byte ranges."""

from collections.abc import Iterator
from pathlib import Path
from urllib.parse import urlparse

import httpx


def chunk_ranges(total: int, chunk_size: int) -> Iterator[tuple[int, int]]:
    if total <= 0 or chunk_size <= 0:
        raise ValueError("Video and chunk size must be positive")
    for start in range(0, total, chunk_size):
        yield start, min(total - 1, start + chunk_size - 1)


def upload_video_file(client: httpx.Client, upload_url: str, path: Path,
                      *, chunk_size: int = 10_000_000) -> None:
    parsed = urlparse(upload_url)
    if parsed.scheme != "https" or not parsed.hostname or not parsed.hostname.endswith(".tiktokapis.com"):
        raise ValueError("Unexpected TikTok upload host")
    total = path.stat().st_size
    with path.open("rb") as source:
        for start, end in chunk_ranges(total, chunk_size):
            data = source.read(end - start + 1)
            response = client.put(upload_url, content=data,
                                  headers={"Content-Type": "video/mp4",
                                           "Content-Range": f"bytes {start}-{end}/{total}"}, timeout=120)
            response.raise_for_status()
