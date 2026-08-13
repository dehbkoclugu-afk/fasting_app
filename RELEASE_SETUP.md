# FastTrack release configuration

The app deliberately keeps purchases and ads disabled when production values
are missing. Do not commit `android/key.properties` or the upload keystore.

## Products

Create these exact products in Google Play, App Store Connect, and RevenueCat:

- `fasttrack_premium_monthly` — auto-renewing monthly subscription
- `fasttrack_premium_yearly` — auto-renewing yearly subscription
- `fasttrack_premium_lifetime` — non-consumable lifetime purchase

Attach all three to the `premium` entitlement and the current RevenueCat
offering. Prices and introductory offers are read from the stores.

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
```

Replace the Google test AdMob application IDs in AndroidManifest.xml and
Info.plist with the production application IDs before enabling ad unit IDs.

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
