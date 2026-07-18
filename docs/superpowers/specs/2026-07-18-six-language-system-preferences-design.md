# Six-Language and System Preferences Design

## Goal

Ship complete English, Turkish, Spanish, Brazilian Portuguese, German, and French support. On first launch, the app follows the device language and appearance. Users can override language and theme, and can return either preference to system-controlled behavior.

## Locale Resolution

- Store locale override as nullable: `null` means follow the system.
- If the device locale matches `tr`, `es`, `pt`, `de`, or `fr`, use it.
- Treat Portuguese regions as Brazilian Portuguese for the current translation set.
- Use English for unsupported device locales.
- Persist explicit overrides and expose “System language” plus all six languages in Settings.
- Date, weekday, number, and unit formatting use the resolved locale.

## Theme Resolution

- Default to `ThemeMode.system`.
- Expose System, Light, and Dark choices in Settings.
- Persist explicit choices.
- System mode responds to device appearance changes without restarting the app.

## Translation Scope

- Translate all existing ARB messages into Spanish, Brazilian Portuguese, German, and French.
- Move every user-visible hardcoded Turkish/English string in `lib` into ARB.
- Include onboarding, timer, phase explanations, support mode, tracking, statistics, achievements, gamification, Explore safety content and sources, circle, paywall, profile, dialogs, errors, and empty states.
- Keep brand names, product identifiers, source titles, URLs, and measurement abbreviations unchanged where appropriate.
- Preserve placeholders, plural meaning, and medical uncertainty language.

## Layout and Accessibility

- Verify German and French expansion on compact widths.
- Allow labels to wrap where truncation would hide meaning.
- Keep 48×48 touch targets and system text scaling.
- Verify light and dark themes for every locale.
- RTL is outside this six-language scope.

## Verification

- Generate Flutter localization output successfully.
- Scan `lib` for remaining user-visible hardcoded strings.
- Run formatting, analysis, and widget tests.
- Add locale-resolution tests for supported and unsupported device locales.
- Build a release APK after verification.
