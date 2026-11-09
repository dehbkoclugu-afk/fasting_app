# Fasting history and individual record deletion

## Scope

Add a history destination to the existing profile menu. Show ended fasts, newest
start first, with plan, localized start/end dates, saved duration and status.
Use existing theme/components and existing Riverpod session state. A separate
stream/controller would duplicate that state; embedding the list in statistics
would make record management harder to discover from the profile.

Deleting a row requires a localized confirmation explaining permanence. Cancel
does nothing. Disable delete actions during an operation; an error keeps the
record and offers retry. Empty and load-error states must be usable.

## Data and state

`AppDatabase.deleteFinishedSession(int id)` deletes only the requested ID whose
endTime is non-null and returns the affected-row count. Active fasts must remain
protected even if a stale or direct caller supplies their ID. No schema change.

`FastingSessionNotifier.deleteSession(int id)` calls that method, reloads on
success and reports whether a row was removed. Loads ignore obsolete results
and results after disposal. Statistics and heatmaps observe session state so
deletion refreshes cached totals and streaks. Existing gamification already
observes the same session state; persisted reward-bank behavior is preserved.

## UI and localization

Route `/fasting-history` opens above the main shell. Use a lazily built list,
existing card styling and localized date/number formatting. Support narrow
screens, large text and RTL without fixed row heights. Unknown saved plan IDs
remain visible rather than being relabeled as another plan.

Add localized history title and permanent-delete confirmation to all existing
ARB locales; reuse common actions, duration labels, empty/retry and status text.
Do not add ads, premium gates, networking, dependencies or generated database code.

## Acceptance

Database tests prove one-row deletion and active/missing-ID protection. Provider
tests prove stats/heatmap/streak refresh, obsolete-load suppression and disposal.
Widget tests prove ended-only ordering, cancel/confirm, failure/retry, empty/error
states and narrow/large-text/RTL layouts. Run Flutter 3.38.10 analysis and the full
test suite, obtain a fresh review, then push to the existing PR without merging.
