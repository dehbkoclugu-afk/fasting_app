# FastTrack release validation — 9 November 2026

## Verified source and CI

Application PR: https://github.com/dehbkoclugu-afk/fasting_app/pull/73

Validated application commit: `fcb17a94fa85b7682e82d075b2f2baa9e4b59de6`.
GitHub Actions tested its merge with main, `4f184fa0e894ee4b7002bbdf699582d1bd9c8dd1`.

- Flutter 3.38.10: dependency resolution and localization generation passed.
- All **140 tests passed**. Analysis reported **8 informational findings**;
  no errors or warnings failed the analysis step.
- Native image decoder regression checks passed.
- Android release AAB compilation passed (66.4 MB). This artifact is unsigned.
- Official bundletool 1.18.3 accepted the downloaded AAB structure; its bundle
  configuration reports `PAGE_ALIGNMENT_16K`. This does not replace runtime
  validation on a 16 KB device.
- Android emulator smoke passed: installation, notification receivers and boot
  permission, launch and relaunch without a fatal exception.
- Windows social-funnel workflow passed; it is a separate product check.

Evidence:

- Analyze, tests and AAB: https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42531140649
- Emulator smoke: https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42531140697
- Social funnel: https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42531140751

The older PR description's 128-test result refers to `2dbb73f`, before the
subscription lifecycle regression tests were added. Do not use it as the count
for the current application commit.

## Phone test package

Sideload workflow run for the validated application commit:
https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42538120355

The `sideload-apk` artifact contains release APKs split by CPU architecture.
Most current physical Android phones use `arm64-v8a`. The test app has the
`.sideload` application ID suffix and can coexist with the Play app. It uses a
throwaway signing key and cannot be uploaded to Play. Rebuilds use different
keys, so they cannot upgrade an older sideload installation.

This public test build contains no Gemini API key; photo scanning is hidden.
It cannot validate photo analysis, production telemetry, or Play purchases.
Purchase and restore tests need an internal Play build and a license tester.
Do not enter real health information or personal photos in a QA installation.

## Manual acceptance checks still pending

Use fictional test data in a dedicated QA installation. Record device model,
Android version, application commit, expected result, actual result and any
reproduction steps. Automated unit tests and launch smoke do not close these
checks.

| Check | Expected result |
| --- | --- |
| Eligibility | Underage, disallowed health answers and low BMI prevent fasting; eligible test answers permit the supported plan. |
| Long plan | The additional confirmation appears before starting a longer plan; cancelling leaves no active fast. |
| Safety exit | Start a fast, open crisis mode, choose the unwell path and finish. The fast ends and stays ended after relaunch. |
| Start/exit race | Request a safety exit while starting or restoring a fast. The exit completes instead of silently disappearing. |
| Delete data | Create fictional fasting, meal, water and weight data, then delete all data. Relaunch and confirm no records or active widget session return. |
| Delete failure | If finalizing the active fast fails, deletion stops and offers retry instead of claiming success. |
| Widget and notifications | Start/end a fast, relaunch and reboot. Widget and notification state follow the saved session; clearing notifications must not skip widget cleanup. |
| Purchases and restore | In Play internal testing, verify purchase, cancellation, restore, offline access and expiry. Old refresh results must not revoke a newer verified entitlement. |
| Photo handling | In a separately configured private build, test a large photo, retry, cancellation and deletion during analysis. Check GPS metadata handling and no late preference recreation. |
| Background work | Verify Workmanager and notification restoration on a physical device with normal battery restrictions. |

## Release gates

1. Complete the physical-device checks above. No physical phone was connected
   to this validation environment.
2. Produce and verify the Codemagic store-signed Android AAB against the Play
   upload certificate. The unsigned CI AAB and sideload APK do not satisfy this.
3. Resolve Gemini proxy/key protection and the previously identified unpaid-tier
   data and regional conditions before enabling production scanning.
4. Complete legal/contact review and Play Data Safety / Apple privacy
   declarations. Keep the legal-site PR in draft and publish it with the matching
   app release: https://github.com/dehbkoclugu-afk/dehbkoclugu-afk.github.io/pull/3
5. Complete iOS production AdMob configuration, signed build and device checks.
6. Configure optional Sentry/PostHog accounts and verify crash reporting and
   analytics consent using the intended production configuration.

## Local validation limits

The installed local Flutter SDK is an older beta, so Flutter 3.38.10 results
above come from the linked CI logs, not a local rerun. Existing unrelated edits
in `C:/Users/kedi/dev/fasting_app` were preserved; this work uses an isolated
managed worktree.

The native image decoder regression script was also rerun locally with Python
3.13 and the Android Studio JDK. All twelve checks passed: nine sampling/lifetime
checks and three added checks using the actual vendored EXIF copier. The added
checks cover GPS omission, orientation/exposure preservation, stale-dimension
omission, source preservation and saving the destination attributes. Mutations
that copy GPS, drop orientation or skip saving were each rejected. This tests
the Java copier against an Android API double; actual EXIF byte encoding and
device-level metadata handling remain unverified.
The system-default Java compiler was too old; only the test process's PATH was
changed to select the installed Android Studio JDK.

The CI AAB was converted with official bundletool 1.18.3 and installed on the
local headless Android emulator. Android reported installation success and an
application PID, but `am start -W` timed out. No crash-buffer entry was returned.
This does **not** prove that a frame or any health/deletion screen rendered.
No emulator window was available; the attempted scrcpy download/launch was
rejected by automatic policy review. No manual UI acceptance check is marked
passed on that basis.

No merge or store publication has been performed as part of this validation.
