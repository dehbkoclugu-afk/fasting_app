import json
from pathlib import Path
from subprocess import CompletedProcess

import pytest
from PIL import Image

from social_funnel.media.probe import probe_image, probe_video


def video_result(**overrides) -> CompletedProcess:
    stream = {"codec_type": "video", "codec_name": "h264", "pix_fmt": "yuv420p", "width": 1080, "height": 1920, "duration": "24.0"}
    stream.update(overrides)
    return CompletedProcess([], 0, stdout=json.dumps({"streams": [stream], "format": {"duration": stream.get("duration", "24.0")}}), stderr="")


def test_probe_image_reads_real_png_and_checksum(tmp_path: Path) -> None:
    path = tmp_path / "post.png"
    Image.new("RGB", (1080, 1350), "white").save(path)
    metadata = probe_image(path)
    assert (metadata.width, metadata.height, metadata.mime_type) == (1080, 1350, "image/png")
    assert len(metadata.checksum) == 64


def test_probe_image_rejects_disguised_bytes(tmp_path: Path) -> None:
    path = tmp_path / "post.png"
    path.write_bytes(b"not an image")
    with pytest.raises(ValueError, match="valid PNG"):
        probe_image(path)


@pytest.mark.parametrize("change,message", [
    ({"codec_name": "hevc"}, "H.264"),
    ({"width": 720}, "1080x1920"),
    ({"duration": "19.9"}, "20 and 45"),
    ({"duration": "45.1"}, "20 and 45"),
    ({"pix_fmt": "yuv444p"}, "yuv420p"),
])
def test_probe_video_rejects_incompatible_streams(tmp_path: Path, change: dict, message: str) -> None:
    path = tmp_path / "video.mp4"
    path.write_bytes(b"video")
    with pytest.raises(ValueError, match=message):
        probe_video(path, runner=lambda _: video_result(**change))


def test_probe_video_rejects_missing_stream_and_sanitizes_probe_failure(tmp_path: Path) -> None:
    path = tmp_path / "video.mp4"
    path.write_bytes(b"video")
    no_stream = CompletedProcess([], 0, stdout='{"streams": [], "format": {}}', stderr="")
    with pytest.raises(ValueError, match="video stream"):
        probe_video(path, runner=lambda _: no_stream)
    failed = CompletedProcess([], 1, stdout="", stderr="access_token=secret")
    with pytest.raises(ValueError, match="ffprobe could not inspect video") as error:
        probe_video(path, runner=lambda _: failed)
    assert "secret" not in str(error.value)


def test_probe_video_accepts_required_contract(tmp_path: Path) -> None:
    path = tmp_path / "video.mp4"
    path.write_bytes(b"video")
    metadata = probe_video(path, runner=lambda _: video_result())
    assert (metadata.width, metadata.height, metadata.duration_ms, metadata.mime_type) == (1080, 1920, 24000, "video/mp4")
