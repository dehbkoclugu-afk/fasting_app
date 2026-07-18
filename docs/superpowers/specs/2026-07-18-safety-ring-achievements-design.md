# Safety, Phase Ring, and Achievements Redesign

## Scope

This change fixes the weight-screen bottom inset, exposes metabolic phases around the fasting ring, adds an App Store-ready education disclaimer and sources to Explore, and rebuilds Achievements as a personal journey.

## Weight Screen

The scrollable body must respect the device bottom safe area. Its final action receives navigation-bar-aware bottom padding so the add-weight button remains fully visible and tappable in gesture and three-button navigation modes.

## Fasting Ring

The ring displays metabolic phase thresholds as compact dots and hour labels inside its safe bounds. Completed phases are filled, the current phase receives stronger emphasis, and future phases remain neutral. Each marker has a minimum 48×48 touch target. Tapping it opens a themed bottom sheet with the localized phase name, hour range, explanation, and an estimate disclaimer. The timer remains the primary visual focus and markers must not overlap or overflow at compact widths.

## Explore Safety and Sources

Explore begins with a concise notice that its content is educational and not medical advice. Health claims use cautious language. A safety section advises users to consult a qualified professional when they have a condition, symptoms, take medication, are pregnant, or are breastfeeding.

The screen includes tappable primary-source references for the fasting and health guidance. Links open externally and failure produces a snackbar. Sources are visible from the content surface rather than hidden only in legal settings.

## Achievements: Personal Journey

Replace the flat achievement list with:

1. A next-goal hero showing title, remaining work, and progress.
2. A compact lifetime summary for streak, completed fasts, and total hours.
3. Four ordered sections: Start, Rhythm, Endurance, and Mastery.
4. Achievement rows that show unlocked state or measurable progress toward the requirement.

Unlocked items use restrained coral and success semantics. Locked items remain readable and show progress instead of appearing disabled. The screen avoids gradients, repeated trophy decoration, and a wall of identical cards.

## Verification

- Check compact Android bottom navigation inset behavior.
- Check phase marker layout for all fasting plans and both languages.
- Verify source links and failure feedback.
- Verify achievement progress at empty, partial, and completed states.
- Run formatting, analysis, and widget tests.
