import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._();
  RevenueCatService._();
  factory RevenueCatService() => _instance;

  static const _iosApiKey = String.fromEnvironment('REVENUECAT_IOS_API_KEY');
  static const _androidApiKey = String.fromEnvironment(
    'REVENUECAT_ANDROID_API_KEY',
  );

  // Entitlement ID configured in RevenueCat dashboard
  static const entitlementId = 'premium';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = Platform.isIOS ? _iosApiKey : _androidApiKey;
    if (apiKey.isEmpty) {
      debugPrint('RevenueCat disabled: API key is not configured.');
      return;
    }

    final configuration = PurchasesConfiguration(apiKey);
    await Purchases.configure(configuration);

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    _initialized = true;
  }

  Future<bool> isPremium() async {
    if (!_initialized) return false;
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat isPremium error: $e');
      return false;
    }
  }

  Future<Offerings?> getOfferings() async {
    if (!_initialized) return null;
    try {
      final offerings = await Purchases.getOfferings();
      return offerings;
    } catch (e) {
      debugPrint('RevenueCat getOfferings error: $e');
      return null;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    if (!_initialized) return false;
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat purchase error: $e');
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    if (!_initialized) return false;
    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat restore error: $e');
      return false;
    }
  }
}
