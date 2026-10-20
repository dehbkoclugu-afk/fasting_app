"""Readable, deterministic campaign cards over ChatGPT-generated source art."""

from dataclasses import dataclass
from hashlib import sha256
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont, ImageOps

from social_funnel.domain.models import LocalizedContent, MediaAsset
from social_funnel.rendering.templates import PALETTE, artwork_for_day


@dataclass(frozen=True)
class RenderRequest:
    content: LocalizedContent
    destination: Path
    size: tuple[int, int] = (1080, 1350)
    format: str = "image"
    font_path: Path | None = None
    artwork_path: Path | None = None


def _font(path: Path | None, size: int) -> ImageFont.FreeTypeFont:
    resolved = path or Path("C:/Windows/Fonts/segoeui.ttf")
    if not resolved.is_file():
        raise FileNotFoundError(f"Unicode font missing: {resolved}. Install Segoe UI or supply font_path.")
    return ImageFont.truetype(str(resolved), size)


def _wrapped(draw: ImageDraw.ImageDraw, text: str, font: ImageFont.FreeTypeFont, max_width: int) -> list[str]:
    lines: list[str] = []
    current = ""
    for word in text.split():
        candidate = f"{current} {word}".strip()
        if current and draw.textbbox((0, 0), candidate, font=font)[2] > max_width:
            lines.append(current)
            current = word
        else:
            current = candidate
    if current:
        lines.append(current)
    return lines


def _draw_card(request: RenderRequest, title: str, subtitle: str, filename: str) -> Path:
    width, height = request.size
    if (width, height) not in {(1080, 1350), (1080, 1080), (1080, 1920)}:
        raise ValueError("supported sizes are 1080x1350, 1080x1080, 1080x1920")
    art_path = request.artwork_path or artwork_for_day(request.content.day)
    if not art_path.is_file():
        raise FileNotFoundError(f"Campaign artwork missing: {art_path}")
    with Image.open(art_path) as source:
        image = ImageOps.fit(source.convert("RGB"), (width, height), method=Image.Resampling.LANCZOS)
    # A translucent block keeps text readable without destroying the artwork.
    overlay = Image.new("RGBA", (width, height), (0, 0, 0, 0))
    layer = ImageDraw.Draw(overlay)
    panel_height = min(int(height * 0.54), 760)
    layer.rounded_rectangle((55, 72, width - 55, panel_height), radius=36, fill=(246, 241, 232, 224))
    image = Image.alpha_composite(image.convert("RGBA"), overlay)
    draw = ImageDraw.Draw(image)
    x, y = 105, 120
    draw.text((x, y), "FASTTRACK  /  DAILY RHYTHM", font=_font(request.font_path, 31), fill=PALETTE["sage"])
    title_font = _font(request.font_path, 74 if height > 1100 else 62)
    body_font = _font(request.font_path, 40)
    y += 85
    for line in _wrapped(draw, title, title_font, width - 210)[:4]:
        draw.text((x, y), line, font=title_font, fill=PALETTE["ink"])
        y += 91
    y += 14
    for line in _wrapped(draw, subtitle, body_font, width - 210)[:3]:
        draw.text((x, y), line, font=body_font, fill=PALETTE["ink"])
        y += 55
    if y > panel_height - 35:
        raise ValueError("Copy exceeds card safe area; shorten hook or subtitle.")
    request.destination.mkdir(parents=True, exist_ok=True)
    path = request.destination / filename
    image.convert("RGB").save(path, "PNG", optimize=False)
    return path


def render_asset(request: RenderRequest) -> MediaAsset:
    """Render one still or an ordered three-page carousel."""
    if request.format not in {"image", "carousel"}:
        raise ValueError("Use image or carousel; videos use render_video")
    if request.format == "carousel":
        cards = (
            _draw_card(request, request.content.hook, request.content.body, "slide-01.png"),
            _draw_card(request, request.content.body, request.content.cta, "slide-02.png"),
            _draw_card(request, request.content.cta, "FastTrack · daily rhythm", "slide-03.png"),
        )
    else:
        cards = (_draw_card(request, request.content.hook, request.content.cta,
                            f"day-{request.content.day:02d}-{request.content.locale.value}.png"),)
    data = cards[0].read_bytes()
    return MediaAsset(path=cards[0], width=request.size[0], height=request.size[1],
                      checksum=sha256(data).hexdigest(), mime_type="image/png",
                      alt_text=f"FastTrack day {request.content.day}: {request.content.hook}",
                      additional_paths=cards[1:])
