# FastTrack Reels Renderer Design

> **SUPERSEDED — 2026-10-22:** The user decided that Reels/TikTok videos will be produced manually outside this application (currently with Claude Motion Designer) and uploaded as a monthly media package. Do not implement this renderer upgrade. Preserve this file only as decision history. The active direction is documented in `docs/HANDOFF-2026-10-22.md`.

## Goal

Replace the current three-second static MP4 output with useful, deterministic vertical motion graphics for the ten video campaign days. Generate one localized video for Turkish, English, and Brazilian Portuguese: 30 videos total.

## Chosen approach

Use the existing Pillow and FFmpeg pipeline. Pillow creates localized scene cards from the approved campaign copy and existing FastTrack artwork. FFmpeg turns those cards into a 24-second motion graphic with subtle zoom, fades, and readable timing.

This first production version will not use generative video, narration, or copyrighted music. It stays reproducible, inexpensive, and safe to publish silently with all meaning present on screen.

## Output contract

- MP4, H.264, 1080x1920, 30 fps, `yuv420p`, fast-start enabled.
- Exactly 24 seconds and no audio track.
- Text stays inside a 90 px horizontal, 180 px top, and 320 px bottom safe area.
- One output can be used by Instagram Reels, Facebook Reels, and TikTok.
- File name remains `day-NN-locale.mp4` so existing publishing and ZIP-export code continues to work.

## Storyboard

1. 0-3 seconds: localized hook.
2. 3-10 seconds: first concise body segment.
3. 10-17 seconds: remaining key idea with a FastTrack progress-ring motif.
4. 17-21 seconds: localized call to action and official FastTrack icon.
5. 21-24 seconds: safety note when present; otherwise a neutral `Not medical advice` equivalent for the locale.

Each scene receives a slow scale or pan. Scene transitions use short fades. Copy is wrapped and bounded; rendering fails instead of producing clipped text.

Body copy is split at the sentence boundary nearest its midpoint. If there is only one sentence, words are divided into two balanced segments. Safety-note fallbacks are `Tıbbi tavsiye değildir.`, `Not medical advice.`, and `Não é aconselhamento médico.` for `tr`, `en`, and `pt-BR` respectively.

## Components

- `rendering/video.py`: owns scene timing, temporary scene images, FFmpeg command construction, and final media metadata.
- `rendering/images.py`: keeps static and carousel behavior unchanged; exposes or reuses focused card-drawing helpers where practical.
- Campaign JSON: remains the source of localized hook, body, CTA, and safety text.
- Existing artwork routing: supplies the approved awareness, activation, habit, or trust/conversion background by campaign day.
- `assets/brand/fasttrack-avatar.png`: supplies the official icon for the CTA scene.

No new runtime dependency is required beyond Pillow and FFmpeg.

## Data flow

The orchestrator selects localized content, calls `render_video`, and receives the existing `MediaAsset` shape. The same path is used by daily ZIP export and platform adapters. Temporary scene files live inside a per-render temporary directory and are removed after success or failure.

## Failure behavior

- Missing FFmpeg, font, artwork, or official icon stops the render with a clear error.
- Text that does not fit the safe area stops the render.
- FFmpeg failure includes a sanitized diagnostic and leaves no partial final MP4.
- The final file is atomically moved into place only after FFmpeg succeeds.
- Existing deterministic naming and checksum behavior remains intact.

## Verification

- Unit-test storyboard text selection, localized fallback safety notes, and FFmpeg argument construction.
- Integration-test with FFmpeg/ffprobe when installed: H.264, 1080x1920, 30 fps, about 24 seconds, no audio.
- Confirm existing static-image, carousel, orchestrator, manual ZIP, and publishing tests still pass.
- Render day 1 in all three locales and visually inspect the three MP4 files before expanding to the remaining video days.

## Out of scope for this increment

- Voice-over, music licensing, AI-generated moving footage, and automatic app screen recording.
- OAuth or live publishing changes.
- Rendering all 30 campaign days before the day-1 visual check.
