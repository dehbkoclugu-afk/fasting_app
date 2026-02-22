import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../services/revenue_cat_service.dart';

class SubscriptionState {
  final bool isPremium;
  final bool isLoading;
  final Offerings? offerings;
  final String? errorMessage;

  const SubscriptionState({
    this.isPremium = false,
    this.isLoading = false,
    this.offerings,
    this.errorMessage,
  });

  SubscriptionState copyWith({
    bool? isPremium,
    bool? isLoading,
    Offerings? offerings,
    String? errorMessage,
  }) {
    return SubscriptionState(
      isPremium: isPremium ?? this.isPremium,
      isLoading: isLoading ?? this.isLoading,
      offerings: offerings ?? this.offerings,
      errorMessage: errorMessage,
    );
  }

  /// Get available packages sorted by duration
  List<Package> get availablePackages {
    final offering = offerings?.current;
    if (offering == null) return [];
    return offering.availablePackages;
  }
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  SubscriptionNotifier() : super(const SubscriptionState()) {
    _init();
  }

  final _service = RevenueCatService();

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final isPremium = await _service.isPremium();
      final offerings = await _service.getOfferings();
      state = state.copyWith(
        isPremium: isPremium,
        offerings: offerings,
        isLoading: false,
      );
    } catch (e) {
      debugPrint('Subscription init error: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<bool> purchase(Package package) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _service.purchasePackage(package);
      state = state.copyWith(isPremium: success, isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Satın alma başarısız oldu',
      );
      return false;
    }
  }

  Future<bool> purchaseByProductId(String productId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _service.purchaseProduct(productId);
      state = state.copyWith(isPremium: success, isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Satın alma başarısız oldu',
      );
      return false;
    }
  }

  Future<bool> restore() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await _service.restorePurchases();
      state = state.copyWith(isPremium: success, isLoading: false);
      if (!success) {
        state = state.copyWith(
          errorMessage: 'Geri yüklenecek satın alma bulunamadı',
        );
      }
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Geri yükleme başarısız oldu',
      );
      return false;
    }
  }

  Future<void> refreshStatus() async {
    final isPremium = await _service.isPremium();
    state = state.copyWith(isPremium: isPremium);
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
