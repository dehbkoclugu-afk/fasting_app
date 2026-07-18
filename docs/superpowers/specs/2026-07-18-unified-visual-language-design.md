# Unified Visual Language Design

## Goal

Unify the complete FastTrack interface around a calm, trustworthy health-coach visual language. Every screen and interaction must feel like part of one product, including the timer, onboarding, statistics, meals, water, weight, profile, paywall, achievements, dialogs, sheets, pickers, forms, charts, and system states.

The current home screen is not a fixed reference. It will be redesigned alongside the rest of the application.

## Design Direction

The product will use a **calm health coach** direction:

- Coral red remains the primary brand color.
- Blue is reserved for water-related meaning.
- Green is reserved for success and completed goals.
- Neutral surfaces carry most of the interface.
- Gradients, strong shadows, and glass effects are reserved for rare focal moments such as the fasting ring, completion, and premium presentation.
- Motion is restrained, purposeful, and supportive rather than decorative.

This direction balances motivation with the trust and clarity expected from a daily health product.

## Foundations

### Color

Use semantic roles instead of screen-specific color values:

- Primary: coral red for primary actions, selected states, and fasting identity.
- Water: blue only for hydration-related information and actions.
- Success: green only for completed goals and positive confirmation.
- Warning and error: distinct semantic colors with accessible foregrounds.
- Background, surface, elevated surface, border, primary text, and secondary text: coordinated neutral ramps for both light and dark themes.

Text contrast must meet WCAG AA: 4.5:1 for normal text and 3:1 for large text. Dark mode must preserve the same semantic hierarchy as light mode rather than becoming a separate visual system.

### Typography

Inter remains the only type family. The type scale will be tightened into clear roles:

- Strong, compact display typography for timer values and important metrics.
- Consistent screen and section headings.
- Readable body text with sufficient contrast and line height.
- Short labels for controls and metadata.

Arbitrary font sizes and opacity-based muted text will be replaced with theme roles where practical.

### Spacing and Shape

- Use an 8 px base spacing rhythm.
- Screen gutters remain consistent across primary screens.
- Major surfaces use 20–24 px corner radii.
- Interactive controls use 14–16 px corner radii.
- Touch targets are at least 48×48 logical pixels.
- Spacing communicates hierarchy; every section should not appear as an identical card.

### Elevation and Effects

Default surfaces use subtle borders or tonal separation rather than heavy shadows. Gradients and pronounced effects are limited to moments that deserve focus. Decorative glass effects are removed from routine content.

## Shared Components

ThemeData and a small set of shared widgets will own the common presentation of:

- Filled, outlined, text, and icon buttons
- Chips and segmented selectors
- Cards and grouped list surfaces
- Text fields and form controls
- Dialogs and modal bottom sheets
- Date and time pickers
- Navigation bars and app bars
- Snackbars and inline feedback
- Loading, empty, error, disabled, and success states

Screen-local `styleFrom`, colors, radii, padding, and shadows will be removed when they duplicate a shared semantic role. A local override remains only when the component communicates a genuinely distinct meaning.

Short confirmations use dialogs. Selection, editing, and richer data entry use modal sheets. Pickers inherit the shared theme and action styling.

## Screen Architecture

### Timer Home

The fasting timer is the single visual focus. Plan selection, start/end information, progress, and the primary action form one coherent zone. Support, metabolic progress, and quick statistics follow in descending importance. Secondary content must not compete with the timer.

### Statistics

The period selector, summary metrics, chart, streak, and calendar form one readable narrative. Repeated summary-card grids are reduced in favor of clearer grouping and hierarchy. Charts use semantic colors, legible labels, and consistent empty states.

### Meals, Water, and Weight

These tracking screens share a common model:

1. Current status or daily summary
2. History or recent entries
3. One obvious add action

Entry sheets, date selection, validation, empty states, and feedback behave consistently across all three areas.

### Profile and Settings

Settings are grouped by meaning. Rows share height, icon treatment, typography, spacing, and trailing behavior. Destructive actions are visually distinct without dominating the page.

### Onboarding

Each step presents one clear decision. Progress remains stable, content hierarchy is consistent, and the primary action occupies a predictable bottom region. Turkish and English content must fit without truncation or awkward layout shifts.

### Paywall

The paywall uses the same product language while allowing one controlled premium moment. Benefits are concise, the recommended annual option is unambiguous, and plan selection uses one consistent selectable-control pattern. Purchase, restore, loading, success, and error states are explicit.

### Achievements and Gamification

Progress and rewards remain motivating but do not turn the product into a noisy game interface. Color, motion, badges, and celebration effects are used in proportion to the achievement.

## Interaction and Motion

- Standard transitions last approximately 160–240 ms.
- Motion uses calm ease-out curves.
- Pressed, selected, loading, disabled, and focused states are visible and consistent.
- Haptics remain purposeful and do not fire for passive interactions.
- Reduced-motion preferences replace non-essential movement with instant changes or simple fades.

## Data and Behavior Boundaries

This project changes presentation and interaction structure only. Existing Riverpod state, GoRouter routes, persistence, services, and business behavior remain intact unless a UI defect cannot be fixed without a narrowly scoped correction.

The current uncommitted feature work must be preserved. The implementation should use Flutter Material 3 and existing dependencies; no new UI package is required.

## Responsive and Accessibility Requirements

The interface must be checked for:

- Small phone widths
- Large system text scales
- Light and dark themes
- Turkish and English strings
- Keyboard and focus behavior where applicable
- Loading, empty, error, disabled, and offline-adjacent states already represented by the product
- Minimum 48×48 touch targets
- WCAG AA text contrast
- No clipped dialogs, sheets, menus, or picker content

## Implementation Sequence

1. Consolidate semantic colors, typography, spacing, radii, and ThemeData.
2. Consolidate shared interactive and feedback components.
3. Redesign the timer home and navigation shell to establish the system in use.
4. Apply the system to onboarding and paywall.
5. Apply the shared tracking model to meals, water, and weight.
6. Redesign statistics, achievements, gamification, explore, and circle surfaces.
7. Redesign profile and settings.
8. Remove redundant local styling and verify all states.

## Verification

- Run Dart formatting on changed files.
- Run `flutter analyze` and the existing test suite.
- Add or update focused widget tests only where a reusable interaction or state has non-trivial behavior.
- Visually inspect primary screens in light and dark modes.
- Check Turkish and English layouts on a small viewport and with increased text scale.
- Confirm that the existing timer, tracking, navigation, purchase, and settings flows still behave as before.

## Success Criteria

The redesign succeeds when:

- Any two screens clearly appear to belong to the same product family.
- Controls with the same meaning use the same shape, spacing, states, and behavior.
- The timer remains the strongest focus on the home screen.
- Tracking screens share a recognizable interaction model.
- Visual effects emphasize meaning instead of decorating routine content.
- Light and dark themes preserve the same hierarchy.
- Existing behavior remains intact and automated checks pass.
