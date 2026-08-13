import 'dart:io';

/// Every value the app needs from outside the source tree, in one place.
///
/// Each value is read from a `--dart-define` first (so `release.json` and the
/// CI workflows keep working unchanged) and falls back to the constant below
/// it. A release built without the dart-defines therefore still works instead
/// of silently shipping with purchases and ads switched off — which is exactly
/// how 1.0.0+5 reached the Play Store.
///
/// Everything here is public information that ships inside the binary anyway:
/// RevenueCat *public* SDK keys, AdMob unit ids, and public URLs. None of it
/// can read or change account data.
///
/// NEVER put a RevenueCat secret key (`sk_…`), the Play service account JSON,
/// or the upload keystore here — those are credentials and stay out of the
/// repository.
class BuildConfig {
  BuildConfig._();

  // ===========================================================================
  // PASTE PRODUCTION VALUES HERE
  // ===========================================================================

  /// RevenueCat > Project settings > Apps > fasttrack (App Store) > Show key.
  static const _revenueCatIosKeyFallback = ''; // starts with appl_

  /// RevenueCat > Project settings > Apps > fasttrack (Play Store) > Show key.
  static const _revenueCatAndroidKeyFallback =
      'goog_pbvdYlYnKpjUqxDiMCCdBOJhjuP';

  /// AdMob > Apps > FastTrack > Ad units. Format: ca-app-pub-…/…
  static const _admobAndroidBannerFallback = '';
  static const _admobIosBannerFallback = '';
  static const _admobAndroidInterstitialFallback = '';
  static const _admobIosInterstitialFallback = '';

  /// App Store listing URL, from App Store Connect once the app is live.
  static const _iosStoreUrlFallback = '';

  // ===========================================================================
  // Already filled in — change only if the addresses change.
  // ===========================================================================

  static const _androidStoreUrlFallback =
      'https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack';
  static const _privacyPolicyUrlFallback =
      'https://dehbkoclugu-afk.github.io/privacy/';
  static const _termsOfUseUrlFallback =
      'https://dehbkoclugu-afk.github.io/terms/';

  // ===========================================================================
  // Build-time overrides (--dart-define / --dart-define-from-file).
  // ===========================================================================

  static const _revenueCatIosKeyEnv = String.fromEnvironment(
    'REVENUECAT_IOS_API_KEY',
  );
  static const _revenueCatAndroidKeyEnv = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );
  static const _admobAndroidBannerEnv = String.fromEnvironment(
    'ADMOB_ANDROID_BANNER_ID',
  );
  static const _admobIosBannerEnv = String.fromEnvironment(
    'ADMOB_IOS_BANNER_ID',
  );
  static const _admobAndroidInterstitialEnv = String.fromEnvironment(
    'ADMOB_ANDROID_INTERSTITIAL_ID',
  );
  static const _admobIosInterstitialEnv = String.fromEnvironment(
    'ADMOB_IOS_INTERSTITIAL_ID',
  );
  static const _androidStoreUrlEnv = String.fromEnvironment(
    'ANDROID_STORE_URL',
  );
  static const _iosStoreUrlEnv = String.fromEnvironment('IOS_STORE_URL');
  static const _privacyPolicyUrlEnv = String.fromEnvironment(
    'PRIVACY_POLICY_URL',
  );
  static const _termsOfUseUrlEnv = String.fromEnvironment('TERMS_OF_USE_URL');

  static String _pick(String fromEnv, String fallback) =>
      fromEnv.isNotEmpty ? fromEnv : fallback;

  /// RevenueCat public SDK key for the current platform.
  static String get revenueCatApiKey =>
      Platform.isIOS
          ? _pick(_revenueCatIosKeyEnv, _revenueCatIosKeyFallback)
          : _pick(_revenueCatAndroidKeyEnv, _revenueCatAndroidKeyFallback);

  /// The dart-define name for the current platform's key, for error messages.
  static String get revenueCatApiKeyName =>
      Platform.isIOS ? 'REVENUECAT_IOS_API_KEY' : 'REVENUECAT_ANDROID_API_KEY';

  static String get admobBannerId =>
      Platform.isAndroid
          ? _pick(_admobAndroidBannerEnv, _admobAndroidBannerFallback)
          : _pick(_admobIosBannerEnv, _admobIosBannerFallback);

  static String get admobInterstitialId =>
      Platform.isAndroid
          ? _pick(
            _admobAndroidInterstitialEnv,
            _admobAndroidInterstitialFallback,
          )
          : _pick(_admobIosInterstitialEnv, _admobIosInterstitialFallback);

  /// Store listing for the current platform, used by rate and share.
  static String get storeUrl =>
      Platform.isIOS
          ? _pick(_iosStoreUrlEnv, _iosStoreUrlFallback)
          : _pick(_androidStoreUrlEnv, _androidStoreUrlFallback);

  static String get privacyPolicyUrl =>
      _pick(_privacyPolicyUrlEnv, _privacyPolicyUrlFallback);

  static String get termsOfUseUrl =>
      _pick(_termsOfUseUrlEnv, _termsOfUseUrlFallback);
}
