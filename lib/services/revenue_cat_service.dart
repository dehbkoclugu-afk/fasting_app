import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._();
  RevenueCatService._();
  factory RevenueCatService() => _instance;

  // TODO: Replace with your actual RevenueCat API keys
  static const _iosApiKey = 'appl_YOUR_IOS_KEY';
  static const _androidApiKey = 'goog_YOUR_ANDROID_KEY';

  // Entitlement ID configured in RevenueCat dashboard
  static const entitlementId = 'premium';

  // Product identifiers
  static const weeklyProductId = 'fasting_premium_weekly';
  static const monthlyProductId = 'fasting_premium_monthly';
  static const yearlyProductId = 'fasting_premium_yearly';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    final apiKey = Platform.isIOS ? _iosApiKey : _androidApiKey;

    final configuration = PurchasesConfiguration(apiKey);
    await Purchases.configure(configuration);

    if (kDebugMode) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    _initialized = true;
  }

  Future<bool> isPremium() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat isPremium error: $e');
      return false;
    }
  }

  Future<List<StoreProduct>> getProducts() async {
    try {
      final products = await Purchases.getProducts(
        [weeklyProductId, monthlyProductId, yearlyProductId],
      );
      return products;
    } catch (e) {
      debugPrint('RevenueCat getProducts error: $e');
      return [];
    }
  }

  Future<Offerings?> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      return offerings;
    } catch (e) {
      debugPrint('RevenueCat getOfferings error: $e');
      return null;
    }
  }

  Future<bool> purchasePackage(Package package) async {
    try {
      final customerInfo = await Purchases.purchasePackage(package);
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat purchase error: $e');
      return false;
    }
  }

  Future<bool> purchaseProduct(String productId) async {
    try {
      final products = await Purchases.getProducts([productId]);
      if (products.isEmpty) return false;

      final customerInfo =
          await Purchases.purchaseStoreProduct(products.first);
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat purchaseProduct error: $e');
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('RevenueCat restore error: $e');
      return false;
    }
  }
}
