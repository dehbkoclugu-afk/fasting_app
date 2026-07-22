import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobService {
  static final AdmobService _instance = AdmobService._();
  factory AdmobService() => _instance;
  AdmobService._();

  // Banner Ad Unit IDs
  static String get bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    // TODO: Gerçek reklam ID'leri
    return Platform.isAndroid
        ? const String.fromEnvironment('ADMOB_ANDROID_BANNER_ID')
        : const String.fromEnvironment('ADMOB_IOS_BANNER_ID');
  }

  // Interstitial Ad Unit IDs
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return Platform.isAndroid
        ? const String.fromEnvironment('ADMOB_ANDROID_INTERSTITIAL_ID')
        : const String.fromEnvironment('ADMOB_IOS_INTERSTITIAL_ID');
  }

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isInitialized = false;
  bool _canRequestAds = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    final consentUpdated = Completer<void>();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () async {
        await ConsentForm.loadAndShowConsentFormIfRequired((_) {});
        _canRequestAds = await ConsentInformation.instance.canRequestAds();
        consentUpdated.complete();
      },
      (_) async {
        _canRequestAds = await ConsentInformation.instance.canRequestAds();
        consentUpdated.complete();
      },
    );
    await consentUpdated.future;
    if (!_canRequestAds) return;
    await MobileAds.instance.initialize();
    _isInitialized = true;
  }

  // Banner Ad
  BannerAd? get bannerAd => _bannerAd;

  void loadBannerAd({Function(BannerAd)? onLoaded}) {
    if (!_isInitialized || bannerAdUnitId.isEmpty) return;
    _bannerAd?.dispose();
    _bannerAd = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _bannerAd = ad as BannerAd;
          onLoaded?.call(_bannerAd!);
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner ad failed to load: $error');
          ad.dispose();
          _bannerAd = null;
        },
      ),
    )..load();
  }

  void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  // Interstitial Ad
  void loadInterstitialAd() {
    if (!_isInitialized || interstitialAdUnitId.isEmpty) return;
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              _interstitialAd = null;
              loadInterstitialAd(); // Preload next
            },
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              _interstitialAd = null;
            },
          );
        },
        onAdFailedToLoad: (error) {
          debugPrint('Interstitial ad failed to load: $error');
          _interstitialAd = null;
        },
      ),
    );
  }

  Future<void> showInterstitialAd() async {
    if (!_isInitialized) return;
    if (_interstitialAd != null) {
      await _interstitialAd!.show();
    } else {
      loadInterstitialAd();
    }
  }

  Future<bool> showPrivacyOptions() async {
    final result = Completer<bool>();
    ConsentForm.showPrivacyOptionsForm(
      (error) => result.complete(error == null),
    );
    return result.future;
  }

  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
  }
}
