# Ethical Gamification Implementation Plan

## Goal

Create a motivating progression system that rewards consistency, hydration,
reflection, and completing the plan the user selected. Never reward extending a
fast beyond its target, aggressive weight loss, or ignoring physical warning
signs.

## Core economy

- **Rhythm XP:** Derived from finalized sessions, completed targets, active
  streaks, hydration, support-mode use, and small consistency bonuses.
- **Levels:** A transparent 500 XP cadence. Levels unlock visual titles rather
  than health claims or functional restrictions.
- **Daily quests:** Three short goals: begin or complete a fast, hydrate, and
  protect the user’s rhythm. Partial progress is always visible.
- **Season path:** A 30-step local progression track. Every fifth step is a
  milestone with a collectible visual token.
- **Streak shields:** Earned through consistency and presented as compassionate
  recovery, never as a paid loss-aversion mechanic.

## Reward surfaces

1. A dedicated Progress Hub replaces the basic awards tab.
2. The hub leads with level progress and today’s quests.
3. A horizontal season path shows reached and upcoming milestones.
4. Badge collections include first fast, hydration, consistency, recovery,
   support use, and personal best categories.
5. A private weekly league compares the user only with an anonymous local
   cohort model and explicitly avoids public ranking pressure.
6. Completion feedback shows earned XP and new milestones in the existing seal.

## Calculation rules

- Finalized session: 40 XP.
- Completed target: additional 60 XP.
- Each completed fasting hour: 4 XP, capped at the selected target.
- Current streak day: 15 XP, capped at seven days for the weekly bonus.
- Daily hydration: up to 50 XP.
- Support-mode reflection: 20 XP each, capped at five recorded uses.
- No XP for fasting beyond the selected target.

## State and privacy

Session and water facts remain in Drift. Lightweight reward preferences and
reflection counts remain in SharedPreferences. No remote leaderboard, account,
tracking SDK, or social graph is introduced.

## UX and accessibility

- Progress is readable without color.
- Celebrations respect reduced-motion settings.
- Copy avoids shame, loss threats, and countdown pressure.
- Missed days use recovery language and never erase historical achievement.
- Haptics and sound follow existing user preferences.

## Delivery tasks

1. Add derived gamification models and provider.
2. Build the Progress Hub, quests, season path, badges, records, and league.
3. Route the existing achievements tab to the new hub.
4. Add XP to completion feedback.
5. Add a profile preference to reduce gamification intensity.
6. Format and statically verify all touched Dart and localization sources.
