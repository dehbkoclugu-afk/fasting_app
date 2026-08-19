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
  ///
  /// Matched on the unit's *format*, not its name: the Android banner unit is
  /// the one AdMob calls "FastTrack Android Interstitial", and the interstitial
  /// is "FastTrack Android Interstitial2".
  static const _admobAndroidBannerFallback =
      'ca-app-pub-2554058432197193/6471439925';
  static const _admobIosBannerFallback = '';
  static const _admobAndroidInterstitialFallback =
      'ca-app-pub-2554058432197193/5809215089';
  static const _admobIosInterstitialFallback = '';

  /// App Store listing URL, from App Store Connect once the app is live.
  static const _iosStoreUrlFallback = '';

  // ===========================================================================
  // Gemini — the AI food photo analysis (premium only).
  // ===========================================================================

  /// Google AI Studio API key (https://aistudio.google.com/apikey). The free
  /// tier is enough for the feature; billing is only needed past its quota.
  ///
  /// Unlike the keys above this one is NOT public information: it bills a
  /// Google Cloud project and anyone who pulls it out of the binary can spend
  /// the quota. So there is deliberately no fallback constant — pass it with
  /// `--dart-define=GEMINI_API_KEY=…` from CI secrets and keep it out of git.
  /// A build without it simply hides the feature instead of failing.
  ///
  /// The key still ships inside the binary and can be extracted from it. Lock
  /// it down in Google Cloud (restrict to the Generative Language API, set a
  /// quota cap), and move the call behind a backend proxy if the spend ever
  /// justifies one.
  static const _geminiApiKeyEnv = String.fromEnvironment('GEMINI_API_KEY');

  /// Overridable so a model swap does not need an app update on the store
  /// side — it is just a build flag.
  static const _geminiModelFallback = 'gemini-3.1-flash-lite';
  static const _geminiModelEnv = String.fromEnvironment('GEMINI_MODEL');

  /// Scans allowed per device per day. Guards the shared free-tier quota from
  /// a single user burning it for everyone. 0 disables the cap.
  static const _geminiDailyLimitFallback = 20;
  static const _geminiDailyLimitEnv = int.fromEnvironment(
    'GEMINI_DAILY_SCAN_LIMIT',
    defaultValue: -1,
  );

  // ===========================================================================
  // Already filled in — change only if the addresses change.
  // ===========================================================================

  static const _androidStoreUrlFallback =
      'https://play.google.com/store/apps/details?id=com.dehbkoclugu.fasttrack';
  static const _privacyPolicyUrlFallback =
      'https://fasting-app-mauve.vercel.app/privacy/';
  static const _termsOfUseUrlFallback =
      'https://fasting-app-mauve.vercel.app/terms/';

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

  /// Google AI Studio key for the food photo analysis. Empty when the build
  /// carried no `GEMINI_API_KEY`.
  static String get geminiApiKey => _geminiApiKeyEnv;

  /// False when the build has no key: the scan entry points stay hidden
  /// instead of leading to a feature that can only fail.
  static bool get isFoodScanEnabled => _geminiApiKeyEnv.isNotEmpty;

  static String get geminiModel => _pick(_geminiModelEnv, _geminiModelFallback);

  static int get geminiDailyScanLimit =>
      _geminiDailyLimitEnv >= 0
          ? _geminiDailyLimitEnv
          : _geminiDailyLimitFallback;
}
