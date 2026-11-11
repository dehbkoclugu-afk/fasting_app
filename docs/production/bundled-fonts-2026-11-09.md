# Bundled Inter fonts

Inter now loads through Flutter's font manifest rather than `google_fonts`.
The app bundles normal weights 400, 500, 600, 700, 800 and 900; other scripts
continue to use platform glyph fallback. The six unmodified font files match
the SHA-256 hashes in the previously pinned google_fonts 6.2.1 Inter map.
Provenance and hashes are recorded in `assets/fonts/README.md`.

The SIL Open Font License is included in the bundle and registered with
Flutter's license registry. No font download or font cache is required on
first launch. The google_fonts dependency and its startup-test workaround
were removed.

Validated locally with Flutter 3.38.10 / Dart 3.10.9:

- `flutter test --no-pub --concurrency=2 --reporter expanded`: 155 passed.
- The new bundled-font test reads the generated font manifest, checks all six
  weights, loads every TrueType asset, checks the license asset and verifies
  the family used by both themes and timer styles.
- `flutter analyze --no-pub`: no issues.
- `git diff --check`: passed.

These are code and bundle checks. Physical-device visual review remains
assigned to the user, with results unrecorded.
