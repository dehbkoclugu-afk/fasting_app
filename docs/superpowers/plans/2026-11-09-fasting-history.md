# Fasting History Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** View ended fasts and permanently delete one without affecting an active fast or leaving stale statistics.

**Architecture:** Reuse the existing session notifier and database. Add a profile-linked full-screen history route; make existing stats/heatmap providers observe session state.

**Tech Stack:** Flutter 3.38.10, Riverpod 2.6, Drift, existing intl/l10n and widgets.

**Spec:** `docs/superpowers/specs/2026-11-09-fasting-history-design.md`

## Global Constraints

- No schema change, new dependencies, ads, premium gates or network services.
- Never delete a row with a null endTime.
- Reuse existing reward-bank behavior and protect active timer state.
- All new user-facing text is localized in every existing ARB locale.
- Work on the existing isolated release worktree; push to PR #73, never merge.

## Review Focus

- A stale caller supplies an active/missing ID: zero rows deleted.
- Two database loads finish out of order: older results cannot resurrect a deleted row in the UI.
- The screen/notifier is disposed during I/O: no dead-state writes or invalid widget-ref use.
- A delete fails: keep the entry and offer a usable retry.
- Long dates, unknown plans, RTL and large text: readable rows without clipping.

### Task 1: Guard deletion and refresh session-derived state

**Files:**
- Modify: `lib/data/database/app_database.dart`
- Modify: `lib/features/timer/providers/fasting_session_provider.dart`
- Modify: `lib/features/stats/providers/stats_provider.dart`
- Create: `test/data/fasting_history_test.dart`

**Interfaces:**
- Consumes: existing `AppDatabase.forTesting`, `databaseProvider`, `fastingSessionProvider`, `statsProvider`, `heatmapProvider`.
- Produces: `Future<int> AppDatabase.deleteFinishedSession(int id)` and `Future<bool> FastingSessionNotifier.deleteSession(int id)`.

- [ ] Write real in-memory DB tests for targeted completed/early-stop deletion, missing and active IDs, preserved other data, and warm stats/heatmap/streak refresh.
- [ ] Add controlled-query notifier tests for out-of-order loads and disposal.
- [ ] Run `flutter test test/data/fasting_history_test.dart`.
  Expected: FAIL because the deletion methods do not exist.
- [ ] Implement the guarded SQL deletion, notifier reload/revision/mounted checks and stats/heatmap dependencies.
- [ ] Run the targeted tests and `flutter test`.
  Expected: all tests pass.
- [ ] Commit as `feat: delete individual finished fasts and refresh statistics`.

### Task 2: History screen, navigation and localization

**Files:**
- Create: `lib/features/timer/screens/fasting_history_screen.dart`
- Modify: `lib/features/profile/screens/profile_screen.dart`
- Modify: `lib/core/router/app_router.dart`
- Modify: `lib/l10n/app_*.arb` and generated localization files.
- Create: `test/features/timer/fasting_history_screen_test.dart`

**Interfaces:**
- Consumes: Task 1's notifier deletion method and existing session state.
- Produces: `FastingHistoryScreen`, profile entry and `/fasting-history` route.

- [ ] Write widget tests for newest-first ended-only rows, empty state, cancel/confirm deletion, delete failure/retry, load error/retry and narrow large-text RTL layout.
- [ ] Run `flutter test test/features/timer/fasting_history_screen_test.dart`.
  Expected: FAIL because the history screen does not exist.
- [ ] Implement the screen with existing cards, per-operation disabling, permanent-delete confirmation and mounted guards.
- [ ] Add the profile destination/route and localized title/confirmation across all ARBs; run `flutter gen-l10n`.
- [ ] Run `flutter analyze --no-fatal-infos` and `flutter test`.
  Expected: no analysis errors/warnings and all tests pass.
- [ ] Commit as `feat: add localized fasting history and record deletion`.

## Final verification

Use a fresh reviewer for the full change since `f1cbc01`, including the Review
Focus above. Fix important findings with regression tests, then push and verify
the existing CI checks. Account/device-dependent release gates remain pending.
