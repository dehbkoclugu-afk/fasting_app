# Unified Visual Language Implementation Plan

## Constraints

- Preserve all current uncommitted feature and behavior changes.
- Keep Riverpod, GoRouter, persistence, services, and purchase behavior intact.
- Add no UI dependency.
- Prefer ThemeData and existing shared widgets over new abstractions.
- Verify each phase before widening the change.

## Phase 1: Foundations

1. Normalize semantic light/dark colors and surface roles in `app_colors.dart`.
2. Normalize the 8 px spacing and radius scale in `app_spacing.dart`.
3. Tighten the Inter type scale and timer number roles in `app_typography.dart`.
4. Complete Material 3 themes for buttons, inputs, chips, cards, dialogs, sheets, pickers, navigation, feedback, selection controls, and progress indicators in `app_theme.dart`.
5. Convert `GlassCard` into a neutral shared surface while retaining its API for existing callers.
6. Convert `GradientButton` into the standard primary action while retaining optional gradients only for premium or completion moments.
7. Format and analyze the foundation files.

## Phase 2: Shell and Timer Home

1. Align the navigation shell with the shared navigation theme and safe areas.
2. Remove local style overrides from the timer home and timer controls.
3. Establish one timer focal zone, one primary action, and ordered secondary content.
4. Align plan selection, stop confirmation, crisis support, completion, quick stats, metabolic journey, and weather widgets.
5. Verify running, paused, completed, busy, and inactive timer states.

## Phase 3: Acquisition

1. Apply one-question/one-action composition to all onboarding screens.
2. Normalize progress, selectable plans/goals, fields, permissions, and navigation actions.
3. Recompose the paywall using the shared selection and action vocabulary.
4. Verify premium active, loading, error, purchase, and restore states.

## Phase 4: Trackers

1. Give meals, water, and weight the shared summary/history/add structure.
2. Normalize entry sheets, date/time selection, validation, deletion confirmation, and snackbars.
3. Remove local button, chip, field, card, and sheet styles that duplicate the theme.
4. Verify empty and populated histories.

## Phase 5: Insight and Motivation

1. Recompose statistics around period, narrative, metrics, chart, streak, and calendar hierarchy.
2. Normalize chart colors, labels, tooltips, and empty states.
3. Align achievements, gamification, explore, and circle screens with restrained semantic color and shared controls.
4. Reserve celebration effects for meaningful completion events.

## Phase 6: Profile and Cleanup

1. Group profile/settings rows by meaning and normalize row anatomy.
2. Align body metrics, language selection, theme settings, and destructive confirmations.
3. Search the full `lib` tree for remaining raw styles and inconsistent Material controls.
4. Keep only overrides with distinct semantic purpose.

## Phase 7: Verification

1. Run `dart format` on changed Dart files.
2. Run `flutter analyze`.
3. Run `flutter test`.
4. Exercise primary routes and interaction states on a compact Android viewport.
5. Inspect light/dark themes, Turkish/English strings, and increased text scale.
6. Correct regressions and repeat the relevant checks.
