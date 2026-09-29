import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../services/revenue_cat_service.dart';

class SubscriptionState {
  final bool isPremium;

  /// A purchase or restore is running.
  final bool isLoading;

  /// The product list is being fetched from the store.
  final bool isLoadingProducts;

  /// Purchasable packages, shortest duration first.
  final List<Package> availablePackages;

  /// True when the SDK never configured (missing API key / failed configure).
  final bool isStoreAvailable;

  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.isLoading = false,
    this.isLoadingProducts = false,
    this.availablePackages = const [],
    this.isStoreAvailable = true,
    this.errorMessage,
  });

  SubscriptionState copyWith({
    bool? isPremium,
    bool? isLoading,
    bool? isLoadingProducts,
    List<Package>? availablePackages,
    bool? isStoreAvailable,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      isLoading: isLoading ?? this.isLoading,
      isLoadingProducts: isLoadingProducts ?? this.isLoadingProducts,
      availablePackages: availablePackages ?? this.availablePackages,
      isStoreAvailable: isStoreAvailable ?? this.isStoreAvailable,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  /// True when there is nothing to sell — the paywall then offers a retry
  /// instead of a disabled purchase button.
  bool get hasNoProducts => availablePackages.isEmpty && !isLoadingProducts;
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  /// [initialState] is a test seam: passing one skips the store round-trip.
  SubscriptionNotifier({SubscriptionState? initialState})
    : super(initialState ?? const SubscriptionState()) {
    if (initialState == null) _init();
  }

  final _service = RevenueCatService();
  bool _premiumListenerAttached = false;

  Future<void> _init() => loadProducts();

  void _ensurePremiumListener() {
    if (_premiumListenerAttached || !_service.isConfigured) return;
    _service.addPremiumListener((isPremium) {
      if (mounted) state = state.copyWith(isPremium: isPremium);
    });
    _premiumListenerAttached = true;
  }

  /// Loads entitlement status and the purchasable packages. Safe to call
  /// again — the paywall's retry button does exactly that.
  Future<void> loadProducts() async {
    state = state.copyWith(isLoadingProducts: true, clearError: true);
    try {
      // The SDK may not have configured yet on a cold start (or configure
      // failed); try once more before giving up on the store.
      if (!_service.isConfigured) await _service.initialize();
      _ensurePremiumListener();

      final isPremium = await _service.isPremium();
      final packages = await _service.getPackages();
      state = state.copyWith(
        isPremium: isPremium,
        availablePackages: packages,
        isStoreAvailable: _service.isConfigured,
        isLoadingProducts: false,
      );
    } catch (e) {
      debugPrint('Subscription load error: $e');
      state = state.copyWith(
        isLoadingProducts: false,
        isStoreAvailable: _service.isConfigured,
      );
    }
  }

  Future<PurchaseOutcome> purchase(Package package) async {
    state = state.copyWith(isLoading: true, clearError: true);
    final outcome = await _service.purchasePackage(package);
    final error = switch (outcome) {
      PurchaseOutcome.success || PurchaseOutcome.cancelled => null,
      PurchaseOutcome.alreadyOwned => 'already_owned',
      PurchaseOutcome.notConfigured => 'store_unavailable',
      PurchaseOutcome.failed => 'purchase_failed',
    };
    state = state.copyWith(
      isPremium: outcome == PurchaseOutcome.success ? true : state.isPremium,
      isLoading: false,
      errorMessage: error,
      clearError: error == null,
    );
    return outcome;
  }

  Future<RestoreOutcome> restore() async {
    state = state.copyWith(isLoading: true, clearError: true);
    final outcome = await _service.restorePurchases();
    final error = switch (outcome) {
      RestoreOutcome.success => null,
      RestoreOutcome.nothingToRestore => 'nothing_to_restore',
      RestoreOutcome.notConfigured => 'store_unavailable',
      RestoreOutcome.failed => 'restore_failed',
    };
    state = state.copyWith(
      isPremium: outcome == RestoreOutcome.success ? true : state.isPremium,
      isLoading: false,
      errorMessage: error,
      clearError: error == null,
    );
    return outcome;
  }

  Future<void> refreshStatus() async {
    try {
      final isPremium = await _service.isPremium();
      if (mounted) state = state.copyWith(isPremium: isPremium);
    } catch (error) {
      debugPrint('Subscription refresh failed: $error');
      // Keep the last verified entitlement on transient store failures.
    }
  }
}

final subscriptionProvider =
    StateNotifierProvider<SubscriptionNotifier, SubscriptionState>((ref) {
      return SubscriptionNotifier();
    });

/// Convenience provider for premium status check
final isPremiumProvider = Provider<bool>((ref) {
  return ref.watch(subscriptionProvider).isPremium;
});
