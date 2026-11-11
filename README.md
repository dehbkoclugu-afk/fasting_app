# FastTrack

Intermittent fasting tracker for Android and iOS, built with Flutter. Fasts,
water, weight and meals stay on the device; there is no account.

## Run

```bash
flutter pub get
flutter gen-l10n
flutter run
```

CI builds with Flutter 3.38.10. Newer stables currently break `google_fonts` and
`phosphor_flutter`; see `codemagic.yaml`.

## Check

```bash
flutter analyze --no-fatal-infos
flutter test
```

## Layout

- `lib/features/` screens and state, one folder per feature
- `lib/services/` notifications, ads, purchases, analytics, background work
- `lib/data/` the drift database
- `lib/l10n/` translations; `app_en.arb` is the template, and every locale must
  carry every key
- `third_party/image_picker_android/` patched plugin; see `FASTTRACK_PATCH.md`
- `legal_site/` the published privacy, terms and deletion pages
- `social_funnel/` separate Python tool for social scheduling

Releases and required secrets are in `RELEASE_SETUP.md`.

Current release evidence and the pending device acceptance checks are in
[`docs/production/release-validation-2026-11-09.md`](docs/production/release-validation-2026-11-09.md).
