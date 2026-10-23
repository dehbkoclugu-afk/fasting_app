"""Short vertical H.264 clips assembled with local FFmpeg."""

import shutil
import subprocess
from hashlib import sha256

from social_funnel.domain.models import MediaAsset
from social_funnel.rendering.images import RenderRequest, render_asset


def render_video(request: RenderRequest) -> MediaAsset:
    executable = shutil.which("ffmpeg")
    if executable is None:
        raise FileNotFoundError("FFmpeg missing; install FFmpeg 8 and add it to PATH.")
    still = render_asset(RenderRequest(content=request.content, destination=request.destination,
                                       size=(1080, 1920), format="image", font_path=request.font_path,
                                       artwork_path=request.artwork_path))
    output = request.destination / f"day-{request.content.day:02d}-{request.content.locale.value}.mp4"
    subprocess.run([executable, "-y", "-loop", "1", "-framerate", "24", "-i", str(still.path),
                    "-t", "3", "-c:v", "libx264", "-preset", "ultrafast", "-pix_fmt", "yuv420p",
                    "-movflags", "+faststart", "-an", str(output)],
                   check=True, capture_output=True, text=True)
    return MediaAsset(path=output, width=1080, height=1920, checksum=sha256(output.read_bytes()).hexdigest(),
                      mime_type="video/mp4", alt_text=still.alt_text)
