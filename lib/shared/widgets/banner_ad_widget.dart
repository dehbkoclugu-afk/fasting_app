import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../features/paywall/providers/subscription_provider.dart';
import '../../services/admob_service.dart';

class BannerAdWidget extends ConsumerStatefulWidget {
  const BannerAdWidget({super.key});

  @override
  ConsumerState<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends ConsumerState<BannerAdWidget> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _syncAd());
  }

  Future<void> _syncAd() async {
    if (!mounted) return;
    final subscription = ref.read(subscriptionProvider);
    if (subscription.isPremium || !subscription.entitlementVerified) {
      _bannerAd?.dispose();
      _bannerAd = null;
      if (_isLoaded) setState(() => _isLoaded = false);
      return;
    }
    if (_loading || _bannerAd != null) return;
    _loading = true;
    try {
      final ads = AdmobService();
      await ads.initialize();
      if (!mounted ||
          !ads.canLoadAds ||
          ref.read(subscriptionProvider).isPremium ||
          !ref.read(subscriptionProvider).entitlementVerified)
        return;
      _bannerAd = BannerAd(
        adUnitId: AdmobService.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            if (mounted &&
                ref.read(subscriptionProvider).entitlementVerified &&
                !ref.read(subscriptionProvider).isPremium) {
              setState(() => _isLoaded = true);
            } else {
              ad.dispose();
              _bannerAd = null;
            }
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            _bannerAd = null;
          },
        ),
      )..load();
    } catch (error) {
      debugPrint('Banner ad setup failed: $error');
    } finally {
      _loading = false;
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subscription = ref.watch(subscriptionProvider);
    ref.listen<SubscriptionState>(subscriptionProvider, (_, __) => _syncAd());

    if (subscription.isPremium ||
        !subscription.entitlementVerified ||
        !_isLoaded ||
        _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      width: _bannerAd!.size.width.toDouble(),
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
