# Android fasting duration and clock changes

## Problem and implementation

The timer derived elapsed time from `DateTime.now() - startTime`. Moving the
phone clock forward could complete a fast immediately; moving it backward
could erase elapsed time or write an end timestamp before the start.

Android now supplies a wall-clock / `SystemClock.elapsedRealtime()` snapshot
and `Settings.Global.BOOT_COUNT` through a small method channel. Elapsed realtime
is independent of wall-clock changes and includes deep sleep, as described in
the [Android SystemClock reference](https://developer.android.com/reference/android/os/SystemClock).

The existing database settings table stores one anchor, scoped to the session
ID, start timestamp and boot count. No schema migration or new package is needed.
Starting, ticking, stopping and restoring the timer use this reference. An app
process restart on the same device boot preserves it. Finished history uses
start plus measured duration; completion remains capped at the plan target.
Restoring a session also rebases reminder scheduling to the recovered duration.

A native-call failure during a protected running session retains the last
measured duration and retries on subsequent ticks. Read calls time out after
two seconds. Concurrent ticks are skipped; late tick results cannot update a
disposed notifier or a different session. Full user-data erasure removes the
anchor with the rest of the database settings.

## Scope and remaining work

- Protection applies to Android within one device boot, including app process
  death and deep sleep. Physical-device verification remains assigned to the
  user; its result is unrecorded.
- A session created before this patch gains its first reference on restore.
  Earlier wall-clock changes cannot be reconstructed.
- A device reboot invalidates the monotonic reference. Recovery currently uses
  wall time and creates a new anchor. This does not verify offline elapsed time
  across reboots and is not a complete tamper-proof rewards system.
- iOS retains the existing wall-clock behavior; it needs a separate native
  continuous-clock implementation and platform validation.
- If no native reference can be obtained at initial attachment, compatibility
  wall-clock recovery remains available. This path is not protected.
- Already scheduled OS notifications and the background worker still use wall
  time. A live clock change can affect them until the timer is restored; they
  do not finalize database records or grant completion rewards.

## Verification

The three initial regression cases failed against the old timer: forward
clock change, backward clock change and restoration after a clock change.
Before the final stop-serialization fix, the full Flutter suite passed **166 tests** locally
with Flutter 3.38.10 / Dart 3.10.9. Added cases also cover native failure and
recovery, old sessions, reboot compatibility, unrelated session anchors,
corrupt metadata, unsupported platforms, full data erasure, overlapping ticks
and notifier disposal.

`flutter analyze --no-pub` reported no issues, and `git diff --check` passed.

## Physical-device checks (unrecorded)

Use an Android candidate containing this patch; the older QA APK does not
contain it. Start a 12:12 fast and leave it running for a few minutes. Disable
automatic date/time and advance the phone date by two days. On returning to
FastTrack, the fast should still be running at approximately the elapsed real
duration. Move the date backward and verify that the displayed duration does
not reset. Force-close and reopen the app without rebooting the phone; the
duration should still reflect real elapsed time. End the fast and verify that
history records the short actual duration as incomplete. Restore automatic
date/time after the check. This is an assigned manual check, not a recorded pass.

A further regression test confirmed that a safety exit could race a pending
native-clock stop. Stop requests now share one pending operation, so the safety
exit drains that operation. The subsequent 167-test run was interrupted when
the C: drive filled during Android dependency transforms. The Android native
compilation did not complete for the same reason. These final changes require
CI verification; neither final full-suite success nor native compilation is
claimed locally. Automatic approval review blocked cache cleanup, including a
narrowed workspace-output cleanup. No cache deletion was performed.
