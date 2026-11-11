import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../services/revenue_cat_service.dart';

class SubscriptionState {
  final bool isPremium;
  final bool entitlementVerified;

  /// A purchase or restore is running.
  final bool isLoading;

  /// The product list is being fetched from the store.
  final bool isLoadingProducts;

  /// Purchasable packages, shortest duration first.
  final List<Package> availablePackages;

  /// True once the SDK is configured.
  final bool isStoreAvailable;

  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.entitlementVerified = false,
    this.isLoading = false,
    this.isLoadingProducts = false,
    this.availablePackages = const [],
    this.isStoreAvailable = true,
    this.errorMessage,
  });

  SubscriptionState copyWith({
    bool? isPremium,
    bool? entitlementVerified,
    bool? isLoading,
    bool? isLoadingProducts,
    List<Package>? availablePackages,
    bool? isStoreAvailable,
    String? errorMessage,
    bool clearError = false,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      entitlementVerified: entitlementVerified ?? this.entitlementVerified,
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
  /// [initialState] skips the initial store round-trip in tests.
  SubscriptionNotifier({
    SubscriptionState? initialState,
    SubscriptionStore? store,
  }) : _service = store ?? RevenueCatService(),
       super(initialState ?? const SubscriptionState()) {
    if (initialState == null) _init();
  }

  final SubscriptionStore _service;
  VoidCallback? _removePremiumListener;
  Future<void>? _pendingLoad;
  Timer? _retry;
  int _retriesLeft = 3;
  int _entitlementRevision = 0;

  @override
  void dispose() {
    _retry?.cancel();
    _removePremiumListener?.call();
    super.dispose();
  }

  void _scheduleRetry() {
    if (!mounted || state.entitlementVerified || _retriesLeft == 0) return;
    _retriesLeft--;
    _retry = Timer(const Duration(seconds: 30), loadProducts);
  }

  Future<void> _init() => loadProducts();

  void _ensurePremiumListener() {
    if (!mounted ||
        _removePremiumListener != null ||
        !_service.isConfigured) {
      return;
    }
    _removePremiumListener = _service.addPremiumListener((isPremium) {
      if (!mounted) return;
      _entitlementRevision++;
      state = state.copyWith(
        isPremium: isPremium,
        entitlementVerified: true,
      );
    });
  }

  /// Coalesces product reloads and keeps newer entitlement updates intact.
  Future<void> loadProducts() async {
    if (!mounted) return;
    final pending = _pendingLoad;
    if (pending != null) return pending;
    final operation = _loadProducts();
    _pendingLoad = operation;
    try {
      await operation;
    } finally {
      _pendingLoad = null;
    }
  }

  Future<void> _loadProducts() async {
    _retry?.cancel();
    state = state.copyWith(isLoadingProducts: true, clearError: true);
    final revision = _entitlementRevision;
    try {
      if (!_service.isConfigured) await _service.initialize();
      if (!mounted) return;
      _ensurePremiumListener();

      final isPremium = await _service.isPremium();
      if (!mounted) return;
      final packages = await _service.getPackages();
      if (!mounted) return;
      final configured = _service.isConfigured;
      final canApply = configured && revision == _entitlementRevision;
      if (canApply) _entitlementRevision++;
      state = state.copyWith(
        isPremium: canApply ? isPremium : null,
        entitlementVerified: canApply ? true : null,
        availablePackages: packages,
        isStoreAvailable: configured,
        isLoadingProducts: false,
      );
    } catch (error) {
      debugPrint('Subscription load error: $error');
      if (!mounted) return;
      state = state.copyWith(
        isLoadingProducts: false,
        isStoreAvailable: _service.isConfigured,
      );
    }
    _scheduleRetry();
  }

  Future<PurchaseOutcome> purchase(Package package) async {
    if (!mounted || state.isLoading) return PurchaseOutcome.failed;
    state = state.copyWith(isLoading: true, clearError: true);
    PurchaseOutcome outcome;
    try {
      outcome = await _service.purchasePackage(package);
    } catch (error) {
      debugPrint('Subscription purchase failed: $error');
      outcome = PurchaseOutcome.failed;
    }
    if (!mounted) return outcome;
    final error = switch (outcome) {
      PurchaseOutcome.success || PurchaseOutcome.cancelled => null,
      PurchaseOutcome.alreadyOwned => 'already_owned',
      PurchaseOutcome.notConfigured => 'store_unavailable',
      PurchaseOutcome.failed => 'purchase_failed',
    };
    if (outcome == PurchaseOutcome.success) _entitlementRevision++;
    state = state.copyWith(
      isPremium: outcome == PurchaseOutcome.success ? true : null,
      entitlementVerified: outcome == PurchaseOutcome.success ? true : null,
      isLoading: false,
      errorMessage: error,
      clearError: error == null,
    );
    return outcome;
  }

  Future<RestoreOutcome> restore() async {
    if (!mounted || state.isLoading) return RestoreOutcome.failed;
    state = state.copyWith(isLoading: true, clearError: true);
    RestoreOutcome outcome;
    try {
      outcome = await _service.restorePurchases();
    } catch (error) {
      debugPrint('Subscription restore failed: $error');
      outcome = RestoreOutcome.failed;
    }
    if (!mounted) return outcome;
    final error = switch (outcome) {
      RestoreOutcome.success => null,
      RestoreOutcome.nothingToRestore => 'nothing_to_restore',
      RestoreOutcome.notConfigured => 'store_unavailable',
      RestoreOutcome.failed => 'restore_failed',
    };
    final verified = outcome == RestoreOutcome.success ||
        outcome == RestoreOutcome.nothingToRestore;
    if (verified) _entitlementRevision++;
    state = state.copyWith(
      isPremium: verified ? outcome == RestoreOutcome.success : null,
      entitlementVerified: verified ? true : null,
      isLoading: false,
      errorMessage: error,
      clearError: error == null,
    );
    return outcome;
  }

  Future<void> refreshStatus() async {
    if (!mounted || !_service.isConfigured) return;
    final revision = _entitlementRevision;
    try {
      final isPremium = await _service.isPremium();
      if (mounted && revision == _entitlementRevision) {
        _entitlementRevision++;
        state = state.copyWith(
          isPremium: isPremium,
          entitlementVerified: true,
        );
      }
    } catch (error) {
      debugPrint('Subscription refresh failed: $error');
      // Preserve the last verified entitlement on transient store failures.
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
