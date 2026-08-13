import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// Result of a purchase attempt, so the UI can tell a user cancel (say
/// nothing) apart from a real failure (show an error).
enum PurchaseOutcome { success, cancelled, alreadyOwned, notConfigured, failed }

/// Result of a restore attempt.
enum RestoreOutcome { success, nothingToRestore, notConfigured, failed }

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._();
  RevenueCatService._();
  factory RevenueCatService() => _instance;

  // Build-time values from --dart-define / --dart-define-from-file.
  static const _iosApiKeyEnv = String.fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const _androidApiKeyEnv = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );

  // ---------------------------------------------------------------------------
  // PASTE THE REVENUECAT PUBLIC SDK KEYS HERE
  //
  // RevenueCat > Project settings > Apps > (the app) > Show key.
  //
  // These are *public* keys: they ship inside every build and can be read out
  // of any APK or IPA, and they cannot read or change account data. Keeping
  // them in source is safe, and it means a build made without the dart-defines
  // still sells subscriptions instead of silently disabling purchases — which
  // is exactly how a release shipped with the paywall dead.
  //
  // A --dart-define of the same name still wins, so release.json keeps working.
  //
  // NEVER paste a RevenueCat secret key (sk_…) or the Play service account
  // JSON here. Those are credentials and must stay out of the repository.
  // ---------------------------------------------------------------------------
  static const _iosApiKeyFallback = ''; // App Store key, starts with appl_
  static const _androidApiKeyFallback = ''; // Play Store key, starts with goog_

  static String get _apiKey {
    final fromEnv = Platform.isIOS ? _iosApiKeyEnv : _androidApiKeyEnv;
    if (fromEnv.isNotEmpty) return fromEnv;
    return Platform.isIOS ? _iosApiKeyFallback : _androidApiKeyFallback;
  }

  // Entitlement ID configured in RevenueCat dashboard
  static const entitlementId = 'premium';

  bool _initialized = false;

  /// True once the SDK is configured. When false the store cannot be reached
  /// at all (missing API key or a failed configure), so the paywall shows the
  /// "unavailable" state instead of a dead purchase button.
  bool get isConfigured => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = _apiKey;
    if (apiKey.isEmpty) {
      debugPrint(
        'RevenueCat disabled: no API key. Pass '
        '${Platform.isIOS ? 'REVENUECAT_IOS_API_KEY' : 'REVENUECAT_ANDROID_API_KEY'} '
        'with --dart-define, or paste the public SDK key into '
        'RevenueCatService.',
      );
      return;
    }

    // A throwing configure() used to take the whole app launch down with it,
    // and left the paywall permanently empty. Swallow it and stay retryable:
    // `_initialized` is only set on success, so a later call can try again.
    try {
      await Purchases.configure(PurchasesConfiguration(apiKey));
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }
      _initialized = true;
    } catch (e) {
      debugPrint('RevenueCat configure error: $e');
    }
  }

  bool _hasEntitlement(CustomerInfo info) {
    final isActive = info.entitlements.all[entitlementId]?.isActive ?? false;
    if (!isActive && info.entitlements.active.isNotEmpty) {
      // A completed purchase that unlocks nothing almost always means the
      // products hang off a differently named entitlement in the dashboard.
      debugPrint(
        'RevenueCat: active entitlements are '
        '${info.entitlements.active.keys.toList()}, '
        'but "$entitlementId" was expected.',
      );
    }
    return isActive;
  }

  /// Fires whenever RevenueCat pushes new customer info (renewals, purchases
  /// made on another device, subscription expiry).
  void addPremiumListener(void Function(bool isPremium) listener) {
    if (!_initialized) return;
    Purchases.addCustomerInfoUpdateListener(
      (info) => listener(_hasEntitlement(info)),
    );
  }

  Future<bool> isPremium() async {
    if (!_initialized) return false;
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return _hasEntitlement(customerInfo);
    } catch (e) {
      debugPrint('RevenueCat isPremium error: $e');
      return false;
    }
  }

  /// All packages that can actually be sold, in display order.
  ///
  /// Falls back to any non-empty offering when no *current* offering is set in
  /// the RevenueCat dashboard — otherwise a dashboard misconfiguration leaves
  /// the paywall with nothing to buy.
  Future<List<Package>> getPackages() async {
    if (!_initialized) return const [];
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;
      if (current != null && current.availablePackages.isNotEmpty) {
        return _sorted(current.availablePackages);
      }
      for (final offering in offerings.all.values) {
        if (offering.availablePackages.isNotEmpty) {
          debugPrint(
            'RevenueCat: no current offering, falling back to '
            '"${offering.identifier}".',
          );
          return _sorted(offering.availablePackages);
        }
      }
      debugPrint('RevenueCat: offerings contain no available packages.');
      return const [];
    } catch (e) {
      debugPrint('RevenueCat getPackages error: $e');
      return const [];
    }
  }

  static const _typeOrder = <PackageType, int>{
    PackageType.weekly: 0,
    PackageType.monthly: 1,
    PackageType.twoMonth: 2,
    PackageType.threeMonth: 3,
    PackageType.sixMonth: 4,
    PackageType.annual: 5,
    PackageType.lifetime: 6,
  };

  /// Shortest duration first, lifetime last. Custom packages keep their
  /// dashboard order after the known ones, sorted by price.
  List<Package> _sorted(List<Package> packages) {
    final sorted = [...packages];
    sorted.sort((a, b) {
      final orderA = _typeOrder[a.packageType] ?? 7;
      final orderB = _typeOrder[b.packageType] ?? 7;
      if (orderA != orderB) return orderA.compareTo(orderB);
      return a.storeProduct.price.compareTo(b.storeProduct.price);
    });
    return sorted;
  }

  Future<PurchaseOutcome> purchasePackage(Package package) async {
    if (!_initialized) return PurchaseOutcome.notConfigured;
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return _hasEntitlement(customerInfo)
          ? PurchaseOutcome.success
          : PurchaseOutcome.failed;
    } on PlatformException catch (e) {
      final code = PurchasesErrorHelper.getErrorCode(e);
      debugPrint('RevenueCat purchase error: $code (${e.message})');
      return switch (code) {
        PurchasesErrorCode.purchaseCancelledError => PurchaseOutcome.cancelled,
        PurchasesErrorCode.productAlreadyPurchasedError ||
        PurchasesErrorCode
            .receiptAlreadyInUseError => PurchaseOutcome.alreadyOwned,
        _ => PurchaseOutcome.failed,
      };
    } catch (e) {
      debugPrint('RevenueCat purchase error: $e');
      return PurchaseOutcome.failed;
    }
  }

  Future<RestoreOutcome> restorePurchases() async {
    if (!_initialized) return RestoreOutcome.notConfigured;
    try {
      final customerInfo = await Purchases.restorePurchases();
      return _hasEntitlement(customerInfo)
          ? RestoreOutcome.success
          : RestoreOutcome.nothingToRestore;
    } catch (e) {
      debugPrint('RevenueCat restore error: $e');
      return RestoreOutcome.failed;
    }
  }
}
