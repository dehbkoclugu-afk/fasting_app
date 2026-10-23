"""Inspect media contents rather than trusting archive extensions."""

from hashlib import sha256
import json
from pathlib import Path
import shutil
import subprocess
from typing import Callable

from PIL import Image, UnidentifiedImageError

from social_funnel.media.models import MediaMetadata


Runner = Callable[[list[str]], object]


def _checksum(path: Path) -> str:
    digest = sha256()
    with path.open("rb") as source:
        for block in iter(lambda: source.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def probe_image(path: Path) -> MediaMetadata:
    try:
        with Image.open(path) as image:
            image.verify()
        with Image.open(path) as image:
            if image.format != "PNG":
                raise ValueError("Media is not a valid PNG image.")
            width, height = image.size
    except (UnidentifiedImageError, OSError):
        raise ValueError("Media is not a valid PNG image.") from None
    return MediaMetadata(checksum=_checksum(path), width=width, height=height, mime_type="image/png")


def _run(command: list[str]):
    return subprocess.run(command, capture_output=True, text=True, check=False)


def probe_video(path: Path, runner: Runner | None = None) -> MediaMetadata:
    executable = shutil.which("ffprobe")
    if runner is None and executable is None:
        raise FileNotFoundError("FFprobe is required to inspect video uploads.")
    command = [executable or "ffprobe", "-v", "error", "-show_streams", "-show_format", "-of", "json", str(path)]
    result = (runner or _run)(command)
    if getattr(result, "returncode", 1) != 0:
        raise ValueError("ffprobe could not inspect video.")
    try:
        payload = json.loads(getattr(result, "stdout", ""))
        stream = next(item for item in payload.get("streams", []) if item.get("codec_type") == "video")
    except (json.JSONDecodeError, StopIteration, TypeError):
        raise ValueError("Media does not contain a video stream.") from None
    if stream.get("codec_name") != "h264":
        raise ValueError("Video must use H.264.")
    width, height = int(stream.get("width", 0)), int(stream.get("height", 0))
    if (width, height) != (1080, 1920):
        raise ValueError("Video must be 1080x1920.")
    if stream.get("pix_fmt") != "yuv420p":
        raise ValueError("Video must use yuv420p pixel format.")
    try:
        duration = float(stream.get("duration") or payload.get("format", {}).get("duration"))
    except (TypeError, ValueError):
        raise ValueError("Video duration is unavailable.") from None
    if not 20 <= duration <= 45:
        raise ValueError("Video duration must be between 20 and 45 seconds.")
    return MediaMetadata(checksum=_checksum(path), width=width, height=height,
                         duration_ms=round(duration * 1000), mime_type="video/mp4")
