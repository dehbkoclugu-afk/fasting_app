# FastTrack release configuration

The app deliberately keeps purchases and ads disabled when production values
are missing. Do not commit `android/key.properties` or the upload keystore.

## Products

App Store Connect uses one product per plan:

- `fasttrack_premium_monthly` — auto-renewing monthly subscription
- `fasttrack_premium_yearly` — auto-renewing yearly subscription
- `fasttrack_premium_lifetime` — non-consumable lifetime purchase

Google Play groups the recurring plans under a single subscription with two
base plans, so RevenueCat lists them as `<subscription>:<base plan>`:

- `fasttrack_premium_monthly:monthly`
- `fasttrack_premium_monthly:yearly`
- `fasttrack_premium_lifetime` — one-time product

Attach every product to the `premium` entitlement — that exact identifier is
what the app checks — and add them as packages to the **current** offering.
A product that is published and entitled but missing from the offering never
reaches the paywall. Prices and introductory offers are read from the stores.

## Free trial configuration

Start with a **7-day free trial on the yearly base plan only**. Keep monthly
without a trial as the lower-commitment comparison option, and never attach a
trial to the lifetime product.

1. Google Play Console → Monetize → Products → Subscriptions →
   `fasttrack_premium_monthly`.
2. Open the `yearly` auto-renewing base plan and choose **Add offer**.
3. Use Google-managed **new customer acquisition** eligibility (customers who
   have never had a subscription in this app), add one 7-day free-trial pricing
   phase, select the same regions as the base plan, then activate the offer.
4. In RevenueCat, re-import/sync the Play product if necessary. Keep
   `fasttrack_premium_monthly:yearly` in the annual package of the current
   offering and attached to the `premium` entitlement.
5. Test from a Play internal-testing build with a license-tester account that
   has not used this app's trial before. Offer changes can take time to reach
   devices.

Do not unlock seven days locally in the app. The store owns trial eligibility,
billing, cancellation and conversion to paid. RevenueCat automatically selects
an eligible free-trial offer when the app purchases the package. FastTrack reads
the zero-price introductory period returned by the store and only then displays
free-trial copy; ineligible users see the normal premium offer.

## Required build values

Pass production values with `--dart-define`:

```text
REVENUECAT_ANDROID_API_KEY
REVENUECAT_IOS_API_KEY
ADMOB_ANDROID_BANNER_ID
ADMOB_IOS_BANNER_ID
ADMOB_ANDROID_INTERSTITIAL_ID
ADMOB_IOS_INTERSTITIAL_ID
PRIVACY_POLICY_URL
TERMS_OF_USE_URL
ANDROID_STORE_URL
IOS_STORE_URL
GEMINI_API_KEY
```

Replace the Google test AdMob application IDs in AndroidManifest.xml and
Info.plist with the production application IDs before enabling ad unit IDs.

### GEMINI_API_KEY — the AI food scan

The premium "scan a meal photo" feature calls Google's Generative Language
API. Create the key at <https://aistudio.google.com/apikey>; the free tier
covers the feature and no billing account is required to start.

Two optional overrides go with it:

```text
GEMINI_MODEL             # default gemini-2.5-flash
GEMINI_DAILY_SCAN_LIMIT  # scans per device per day, default 20, 0 = unlimited
```

`GEMINI_API_KEY` is the one build value here that is **not** public
information — unlike the RevenueCat and AdMob ids it bills a Google Cloud
project, so it has no fallback constant in `build_config.dart` and must never
be committed. Pass it from CI secrets only. A build without it hides the scan
entry points and drops the feature row from the paywall, so nothing sells a
capability that build cannot deliver.

The key still ships inside the binary and can be extracted from it. Restrict
it in Google Cloud to the Generative Language API and set a quota cap. If the
feature ever carries real volume, move the call behind a small backend proxy
and have the app talk to that instead.

The photo is uploaded to Google for analysis, which is a data disclosure the
store listings have to declare: Play Data safety needs "Photos and videos —
collected, not stored, for app functionality", and the App Store privacy
questionnaire the equivalent. The privacy policy needs the same line.

### In-source fallbacks

Every one of these values also has a fallback constant in
`lib/core/config/build_config.dart`, under "PASTE PRODUCTION VALUES HERE". A
`--dart-define` of the same name always wins; the constant is what a build made
without `--dart-define-from-file` falls back to, so it ships working instead of
quietly disabling purchases and ads. That is what happened to 1.0.0+5: the
build carried no dart-defines, so the RevenueCat key, both AdMob unit ids and
the store links were all empty.

The store and legal URLs are already filled in. Still to paste: the four AdMob
ad unit ids and, when the app is live on iOS, the App Store listing URL.

Public SDK keys (`appl_…`, `goog_…`), AdMob unit ids and public URLs ship
inside every build and cannot read or change account data, so they belong in
source. Secret keys (`sk_…`), the Play service account JSON and the upload
keystore must never be committed.

## Paywall shows no purchase option

The paywall only renders plans it actually receives from the store. When it
shows the "unavailable" card with a retry button, the cause is configuration,
not the app — work through this list in order:

1. `REVENUECAT_IOS_API_KEY` / `REVENUECAT_ANDROID_API_KEY` were passed to the
   release build. An empty key disables the SDK entirely.
2. RevenueCat → Offerings: one offering is marked **Current** and contains
   packages. (The app falls back to any non-empty offering, but Current is
   what the pricing is designed around.)
3. Every product is attached to the `premium` entitlement — without it a
   purchase completes at the store but the app never unlocks.
4. App Store Connect: the three IAP products are at least "Ready to Submit"
   and the **Paid Applications Agreement** is active. An unsigned agreement
   makes `getOfferings()` return nothing on real devices.
5. Google Play: the app is published on a track and the subscriptions are
   active; products stay invisible to the license tester otherwise.

## Android signing

Copy `android/key.properties.example` to `android/key.properties`, point it to
the private upload keystore, then build:

```powershell
flutter build appbundle --release --dart-define-from-file=release.json
```

Keep `release.json`, `key.properties`, and the keystore outside version control.

Run the preflight check before every store build:

```powershell
powershell -ExecutionPolicy Bypass -File tool/release_check.ps1
```
