import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../core/config/build_config.dart';

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
    return BuildConfig.admobBannerId;
  }

  // Interstitial Ad Unit IDs
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return BuildConfig.admobInterstitialId;
  }

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isInitialized = false;
  bool _canRequestAds = false;

  Future<void> initialize() async {
    if (_isInitialized) return;

    final consentUpdated = Completer<void>();

    void completeConsent() {
      if (!consentUpdated.isCompleted) consentUpdated.complete();
    }

    try {
      ConsentInformation.instance.requestConsentInfoUpdate(
        ConsentRequestParameters(),
        () async {
          try {
            await ConsentForm.loadAndShowConsentFormIfRequired((_) {});
            _canRequestAds =
                await ConsentInformation.instance.canRequestAds();
          } catch (error) {
            debugPrint('Ad consent form error: $error');
            _canRequestAds = false;
          } finally {
            completeConsent();
          }
        },
        (error) async {
          debugPrint('Ad consent update error: $error');
          try {
            _canRequestAds =
                await ConsentInformation.instance.canRequestAds();
          } catch (_) {
            _canRequestAds = false;
          } finally {
            completeConsent();
          }
        },
      );
    } catch (error) {
      debugPrint('Ad consent initialization error: $error');
      _canRequestAds = false;
      completeConsent();
    }

    try {
      await consentUpdated.future.timeout(const Duration(seconds: 8));
    } on TimeoutException {
      debugPrint('Ad consent initialization timed out.');
      _canRequestAds = false;
    }

    if (!_canRequestAds) return;

    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
    } catch (error) {
      debugPrint('Mobile ads initialization error: $error');
    }
  }

  // Banner Ad Unit IDs
  static String get bannerAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716';
    }
    return BuildConfig.admobBannerId;
  }

  // Interstitial Ad Unit IDs
  static String get interstitialAdUnitId {
    if (kDebugMode) {
      return Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/1033173712'
          : 'ca-app-pub-3940256099942544/4411468910';
    }
    return BuildConfig.admobInterstitialId;
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
