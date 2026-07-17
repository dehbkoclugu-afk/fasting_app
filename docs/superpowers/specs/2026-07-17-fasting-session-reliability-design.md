# Fasting Session Reliability Design

## Scope

Make the fasting timer and session history reliable across manual completion,
natural completion, app restarts, and background execution. Remove pause because
fasting is not a process that can be meaningfully paused.

This change does not redesign the UI, introduce a repository layer, or address
unrelated statistics and release configuration issues.

## Product behavior

- An idle timer can start one fasting session.
- A running fast has one action: end the fast.
- Ending before the target keeps the session in history as incomplete.
- Reaching the target marks the session complete.
- Closing and reopening the app restores the same active session.
- Reopening after the target time finalizes that session exactly once.
- Starting repeatedly cannot create multiple active sessions.
- Completing or ending repeatedly cannot create duplicate history rows.

## Architecture

Drift is the source of truth for fasting sessions. An active session is a row
whose `endTime` is null. SharedPreferences remains a small mirror for background
workers and notifications, not the authoritative history store.

`TimerNotifier` owns the session lifecycle:

1. Start: create or reuse an active Drift row, then start background services.
2. Tick: derive elapsed time from the persisted start time.
3. Natural completion: finalize the active row as completed, then stop background
   services.
4. Manual end: finalize the active row as incomplete, then stop background
   services.
5. Restore: load the active Drift row. If its target has passed, finalize it;
   otherwise resume ticking.

The screen does not insert fasting history rows. It observes timer state and
shows completion feedback.

## Data changes

No schema migration is needed. The existing `FastingSessions` columns already
represent active, completed, and incomplete sessions.

Database operations required:

- Load the single active session deterministically.
- Insert an active session and return its id.
- Finalize an active session by id only when `endTime` is still null.
- Protect against multiple active rows by reusing the existing active session.

## Error handling

- Database persistence happens before optional notification/widget work.
- Optional native service failures must not erase or duplicate session data.
- UI actions are guarded while a start or finish operation is in progress.
- Restore failures leave the timer idle and expose an error state suitable for
  later UI messaging; they do not fabricate a completed session.

## Testing

Use an in-memory Drift database and a controllable clock/service boundary.

Required checks:

- Start creates exactly one active session.
- Repeated start reuses the active session.
- Manual end stores actual duration and `completed = false`.
- Natural completion stores actual duration and `completed = true`.
- Restore resumes an unfinished session.
- Restore finalizes an overdue session once.
- Duplicate finish calls do not create or rewrite extra history rows.
- Timer public state no longer contains `paused` behavior.

## Deliberate non-goals

- No clean-architecture or generic repository abstraction.
- No database schema redesign.
- No statistics formula changes in this slice.
- No notification preference redesign in this slice.
- No visual restyling beyond removing the pause control.
