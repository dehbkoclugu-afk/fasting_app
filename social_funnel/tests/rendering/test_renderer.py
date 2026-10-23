import json
import shutil
import subprocess
from pathlib import Path

import pytest
from PIL import Image, ImageDraw

from social_funnel.domain.models import LocaleCode, LocalizedContent
from social_funnel.rendering.images import RenderRequest, _fit_wrapped, render_asset
from social_funnel.rendering.video import render_video


def content(locale=LocaleCode.TR):
    return LocalizedContent(day=1, locale=locale, hook="İlk haftanı sakin başlat" if locale == LocaleCode.TR else "Comece sua rotina com calma",
                            body="Küçük adımlarla sürdürülebilir bir oruç ritmi oluştur." if locale == LocaleCode.TR else "Uma rotina de jejum leve e sustentável.",
                            cta="FastTrack ile takip et" if locale == LocaleCode.TR else "Acompanhe com FastTrack",
                            hashtags=("#FastTrack",))


@pytest.mark.parametrize("size", [(1080, 1350), (1080, 1080), (1080, 1920)])
def test_image_dimensions_checksum_and_safe_bounds(tmp_path, size):
    request = RenderRequest(content=content(), destination=tmp_path / "cards", size=size)
    first = render_asset(request)
    second = render_asset(request)
    assert first.path.is_file()
    assert Image.open(first.path).size == size
    assert first.checksum == second.checksum
    assert first.alt_text.startswith("FastTrack")


def test_pt_br_and_carousel_pages(tmp_path):
    asset = render_asset(RenderRequest(content=content(LocaleCode.PT_BR), destination=tmp_path,
                                       size=(1080, 1350), format="carousel"))
    assert len(asset.additional_paths) == 2
    assert all(path.is_file() for path in (asset.path, *asset.additional_paths))
    assert [p.name for p in (asset.path, *asset.additional_paths)] == ["slide-01.png", "slide-02.png", "slide-03.png"]


def test_long_carousel_copy_is_fitted_without_dropping_words():
    copy = (
        "FastTrack'te zamanlayıcı, temel planlar ve ilerleme görünümüyle "
        "başlayabilirsin. Mağazadaki güncel özellikleri yüklemeden önce kontrol et."
    )
    draw = ImageDraw.Draw(Image.new("RGB", (1080, 1350)))

    _, lines = _fit_wrapped(draw, copy, None, max_width=870, max_lines=4, start_size=74)

    assert len(lines) <= 4
    assert " ".join(lines) == copy


def test_missing_font_fails_actionably(tmp_path):
    with pytest.raises(FileNotFoundError, match="font"):
        render_asset(RenderRequest(content=content(), destination=tmp_path, font_path=tmp_path / "missing.ttf"))


@pytest.mark.skipif(not shutil.which("ffmpeg") or not shutil.which("ffprobe"), reason="FFmpeg not installed")
def test_video_is_h264_vertical_mp4(tmp_path):
    asset = render_video(RenderRequest(content=content(), destination=tmp_path, size=(1080, 1920)))
    assert asset.mime_type == "video/mp4"
    probe = subprocess.run(["ffprobe", "-v", "quiet", "-print_format", "json", "-show_streams", str(asset.path)],
                           check=True, capture_output=True, text=True)
    streams = json.loads(probe.stdout)["streams"]
    assert any(s["codec_name"] == "h264" and s["width"] == 1080 and s["height"] == 1920 for s in streams)
