# Photo analysis stability fix — 2026-09-27

Base: main `86b474677f2e43e2a99589892b4fdf518e508691`.

The earlier audit identified lifecycle and recovery problems. Further inspection
of the exact locked Android picker package found a native decode defect: sample
size was calculated with empty dimensions, so large photos were decoded at full
resolution before scaling. See the vendored package's FASTTRACK_PATCH.md for
provenance, the minimal patch, and reproduction details.

## Changes

- Fix native subsampling and release intermediate bitmaps.
- Reject oversized picker/recovery files before reading them fully into Dart;
  also reject oversized/empty byte input before exposing it to the preview.
- Bound preview decode width and render a fallback when a codec rejects a photo.
- Ignore picker/quota/API continuations after provider disposal.
- Serialize analysis before the first await; refresh the daily quota on retry.
- Consume recovered images once, wait for premium entitlement, and provide a
  home-route fallback when recovery opens the scanner as the root route.
- Lock save/back/retake during a meal write, show success only after completion,
  and allow retry after a write error.

## Validation

- The actual upstream Java resizer fails the local Android-double regression:
  12000x9000 input requests sample=1 and a modeled 432,000,000-byte bitmap.
- The patched resizer passes nine checks: landscape/portrait/large/small/thin
  images, invalid dimensions, and recycling on success or compression failure.
- Dart format parses the changed production and test Dart files.
- Seven provider regression tests and two widget regression tests were added.
  They have NOT been executed in this environment.
- Flutter setup was blocked by automatic security review because it attempted
  to contact the cloud instance metadata endpoint. Full Flutter analysis/tests,
  Android compilation, and real-device reproduction remain pending.

The native source defect is verified; attributing a specific production crash
still requires a corresponding Android stack trace. This change does not claim
to fix all 24 findings from the wider audit. No Play Store release is performed.
