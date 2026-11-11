# FastTrack release validation — 9 November 2026

## Update, 11 November 2026

- Release candidate is `fix/release-blockers`, version **1.3.0+31**. CI on
  `663871e` passed: Android build, emulator smoke and Windows. Since `fcb17a9`
  the branch adds database encryption (`database-encryption-2026-11-09.md`),
  moves profile values into the encrypted database and removes the gender
  question.
- Phone testing must use the sideload APK from run
  https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42679002016
  (`6ee545f`, same app code as `663871e`) or newer, not the `85641cc` build
  below. Add two checks: install it over the older build with data and confirm
  the data survives; confirm onboarding no longer asks for gender.
- The app's privacy link (`fasting-app-mauve.vercel.app/privacy/`) is served
  from `privacy/` in this repository, not from the legal-site repository. Both
  copies now carry the encryption and backup text and go live when this branch
  merges. `/privacy/` and `/terms/` returned 200 on 11 November.
- Contact address: the release owner chose the mailbox this repository's pages
  already use; the legal-site PR now uses it on every FastTrack page too.
- Store privacy answers are drafted in `store-privacy-declarations-2026-11-11.md`.
- `bug-control-protocol-100.md` was re-audited: 77 pass, 6 fixed, 13 manual,
  3 pending (Codemagic AAB and certificate, final sign-off), 1 warning.
- The manual phone checks below were not run on an emulator: the build host had
  0.16 GB free memory and its emulator previously stalled with system ANRs.

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

Sideload workflow run for `85641cc`, including fasting history:
https://github.com/dehbkoclugu-afk/fasting_app/actions/runs/42619740680

The `sideload-apk` artifact contains release APKs split by CPU architecture.
Most current physical Android phones use `arm64-v8a`. The test app has the
`.sideload` application ID suffix and can coexist with the Play app. It uses a
throwaway signing key and cannot be uploaded to Play. Rebuilds use different
keys, so they cannot upgrade an older sideload installation.

This public test build contains no Gemini API key; photo scanning is hidden.
It cannot validate photo analysis, production telemetry, or Play purchases.
Purchase and restore tests need an internal Play build and a license tester.
Do not enter real health information or personal photos in a QA installation.

## Manual acceptance checks handed off to the release owner

The release owner is running the Android phone checklist. Test results have
not been recorded.

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
| Delete one fast | Open Profile → Fasting history with two ended fasts. Cancelling preserves both. Confirming removes only the selected record and updates totals. |
| Delete failure | If finalizing the active fast fails, deletion stops and offers retry instead of claiming success. |
| Widget and notifications | Start/end a fast, relaunch and reboot. Widget and notification state follow the saved session; clearing notifications must not skip widget cleanup. |
| Purchases and restore | In Play internal testing, verify purchase, cancellation, restore, offline access and expiry. Old refresh results must not revoke a newer verified entitlement. |
| Photo handling | In a separately configured private build, test a large photo, retry, cancellation and deletion during analysis. Check GPS metadata handling and no late preference recreation. |
| Background work | Verify Workmanager and notification restoration on a physical device with normal battery restrictions. |

## Release gates

### Local signed candidate and preflight follow-up

The successful AAB from run `42539090961` was signed locally with the existing
upload key. `jarsigner` verified the signature; its SHA1 matches the upload
certificate recorded in `codemagic.yaml`:
`36:ED:82:3B:8C:08:A4:12:F5:3B:D9:7E:0A:0E:11:1C:FB:0C:41:0B`.
All 1,582 original bundle entries have identical contents after signing.

The local output is
`C:/Users/kedi/Downloads/FastTrack-Release-2026-11-09/FastTrack-1.2.9-29-473cec8-upload-signed.aab`.
This candidate retains the CI configuration: Gemini scanning, Sentry and
PostHog are disabled. It does not incorporate the local `release.json`.
It is not a completed Codemagic production release, and Play Console acceptance
or availability of versionCode 29 has not been verified. No store upload occurred.

The release preflight now accepts `-Platform Android` or `-Platform iOS`, while
the default still checks both. It recognizes multiline public key fallbacks,
rejects missing platform files and malformed JSON, and does not echo malformed
configuration contents. Regression fixtures cover valid combined configuration,
platform isolation, missing keys/signing files, missing iOS files and invalid JSON.
All eight preflight regression cases passed under PowerShell 7 and Windows
PowerShell 5. The regression suite is included in the Android CI workflow.

### Still required

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
