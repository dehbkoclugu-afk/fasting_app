# Android Monetization Release Design

## Goal

Publish a new FastTrack closed-test Android build with production AdMob configuration and working Premium purchase infrastructure.

## Scope

- Keep the existing ad placements: a banner on Statistics and an interstitial after a fasting session completes.
- Never show ads to users with the RevenueCat `premium` entitlement.
- Keep Google's test ad unit IDs for debug builds.
- Use the production Android AdMob app and ad unit IDs for release builds.
- Configure monthly, yearly, and lifetime products in Google Play and RevenueCat.
- Build and verify a version-code-incremented Android App Bundle for the existing closed-test track.

## Configuration

- Android package: `com.dehbkoclugu.fasttrack`
- AdMob app ID: `ca-app-pub-2554058432197193~9748460094`
- Banner unit ID: `ca-app-pub-2554058432197193/6471439925`
- Interstitial unit ID: `ca-app-pub-2554058432197193/5809215089`
- RevenueCat entitlement: `premium`
- Store products:
  - `fasttrack_premium_monthly`: auto-renewing monthly subscription
  - `fasttrack_premium_yearly`: auto-renewing yearly subscription
  - `fasttrack_premium_lifetime`: non-consumable one-time purchase

## Implementation

Replace the Android test AdMob application ID in the release manifest configuration with the production app ID. Supply production banner and interstitial IDs through the existing Dart define configuration. Preserve test IDs in debug mode and the existing consent flow.

Increment the Flutter build number from `2` to `3`. Do not change ad frequency or introduce new formats.

In Google Play Console, create and activate the three products. Connect them to the FastTrack Android app in RevenueCat, attach all three to the `premium` entitlement, and place their packages in the current default offering.

## Validation

- Run static analysis and relevant tests.
- Build the release AAB with `--dart-define-from-file=release.json`.
- Confirm the merged release manifest contains the production AdMob app ID.
- Confirm the compiled configuration receives both production ad unit IDs.
- Install a release APK on a test device without clearing application data.
- Verify consent handling, banner placement, post-completion interstitial behavior, paywall product loading, purchase restoration, and Premium ad suppression.
- Upload the verified AAB as a new closed-test release; do not withdraw the currently submitted release before the replacement is ready.

## Failure Handling

If AdMob has not approved the app, retain the production IDs; limited serving is expected until approval. If Play products or RevenueCat offerings are unavailable, the paywall must show its existing products-unavailable state instead of presenting placeholder prices. A failed build or validation blocks upload.

## Out of Scope

- New ad placements or formats
- Changes to pricing strategy
- Apple monetization and Codemagic configuration
- Redesigning the paywall
