# Store privacy declarations — draft, 11 November 2026

Draft answers for Play Data Safety and App Store privacy details, derived from
the code of `fix/release-blockers`. The release owner submits them; check each
answer against the console wording and the providers' current SDK disclosures.

## Release configuration this assumes

| Feature | State in 1.3.0+31 | Effect on the forms |
| --- | --- | --- |
| Photo food scan (Gemini) | Off: no `GEMINI_API_KEY`, scanner hidden | No photos leave the device. Revise both forms before enabling it. |
| Crash reporting (Sentry) | Off: no `SENTRY_DSN` | No crash logs leave the device. |
| Analytics (PostHog) | Off: no key; opt-in only when configured | No app interactions leave the device. |
| Ads (AdMob) | On for free users, UMP consent form, ATT on iOS | Declared below. |
| Purchases (RevenueCat) | On | Declared below. |

Fasting, weight, meal, water, name, age, height and target weight stay in the
encrypted on-device database. Data processed only on the device is not
"collected" in Play's definition, and not "collected" in Apple's either.

## Google Play — Data Safety

- Does the app collect or share required user data types? **Yes.**
- Is all collected data encrypted in transit? **Yes** (HTTPS to RevenueCat and Google).
- Can users request deletion? **Yes**: Profile → Delete all my data removes local
  data; the delete-account page covers anything held by the developer.

| Data type | Collected | Shared | Purpose | Optional | Source |
| --- | --- | --- | --- | --- | --- |
| Device or other IDs (advertising ID) | Yes | Yes, Google | Advertising, analytics, fraud prevention | No (free tier) | AdMob |
| Device or other IDs (anonymous app user ID) | Yes | No | App functionality | No | RevenueCat |
| Purchase history | Yes | No | App functionality | No | RevenueCat, Google Play Billing |
| Approximate location (from IP) | Yes | Yes, Google | Advertising, fraud prevention | No (free tier) | AdMob |
| App interactions (ad interactions) | Yes | Yes, Google | Advertising, analytics | No (free tier) | AdMob |
| Crash logs / diagnostics | Yes | Yes, Google | Analytics, fraud prevention | No (free tier) | AdMob SDK diagnostics |

Not collected: health and fitness, name, email, photos, contacts, precise
location, messages, files.

## App Store — App Privacy

- Tracking: **Yes**, only after the user grants App Tracking Transparency.
  Identifier: Device ID (IDFA), used for Third-Party Advertising.
- Data linked to the user: **none**. Data not linked to the user:

| Category | Data type | Purposes |
| --- | --- | --- |
| Identifiers | Device ID | Third-Party Advertising |
| Purchases | Purchase History | App Functionality |
| Location | Coarse Location | Third-Party Advertising |
| Usage Data | Advertising Data, Product Interaction | Third-Party Advertising, Analytics |
| Diagnostics | Other Diagnostic Data | Analytics |

Health & Fitness is **not** declared: it never leaves the device.

## If a disabled feature is turned on

- Photo scan: Play adds Photos (collected, shared with Google, optional,
  app functionality). Apple adds Photos (not linked, App Functionality). Google's
  unpaid tier may use photos to improve products; the in-app consent says so.
- Sentry: add Crash logs and Diagnostics for App functionality.
- PostHog: add App interactions for Analytics, optional (opt-in).
