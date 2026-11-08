import 'dart:async';

import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:fasting_app/services/revenue_cat_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

final monthly = Package(
  r'$rc_monthly',
  PackageType.monthly,
  StoreProduct('monthly', 'Monthly', 'Monthly', 10, '10', 'USD'),
  const PresentedOfferingContext('default', null, null),
);

SubscriptionNotifier notifierFor(
  FakeSubscriptionStore store, {
  SubscriptionState state = const SubscriptionState(),
}) => SubscriptionNotifier(initialState: state, store: store);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a store that never configured is not proof of no subscription', () async {
    final store = FakeSubscriptionStore()
      ..configured = false
      ..canConfigure = false;
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);

    await notifier.loadProducts();

    expect(notifier.state.isLoadingProducts, isFalse);
    expect(notifier.state.isStoreAvailable, isFalse);
    expect(notifier.state.entitlementVerified, isFalse);
  });

  test('purchase can finish after disposal without writing dead state', () async {
    final store = FakeSubscriptionStore()
      ..purchaseResult = Completer<PurchaseOutcome>();
    final notifier = notifierFor(store);
    final operation = notifier.purchase(monthly);
    notifier.dispose();
    store.purchaseResult!.complete(PurchaseOutcome.success);

    expect(await operation, PurchaseOutcome.success);
  });

  test('restore can finish after disposal without writing dead state', () async {
    final store = FakeSubscriptionStore()
      ..restoreResult = Completer<RestoreOutcome>();
    final notifier = notifierFor(store);
    final operation = notifier.restore();
    notifier.dispose();
    store.restoreResult!.complete(RestoreOutcome.success);

    expect(await operation, RestoreOutcome.success);
  });

  test('disposed initialization attaches no listener and makes no queries', () async {
    final store = FakeSubscriptionStore()
      ..configured = false
      ..initialization = Completer<void>();
    final notifier = notifierFor(store);
    final operation = notifier.loadProducts();
    notifier.dispose();
    store.initialization!.complete();
    await operation;

    expect(store.listenerAdds, 0);
    expect(store.premiumCalls, 0);
    expect(store.packageCalls, 0);
  });

  test('a purchase blocks duplicate purchases and simultaneous restore', () async {
    final store = FakeSubscriptionStore()
      ..purchaseResult = Completer<PurchaseOutcome>();
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);
    final operation = notifier.purchase(monthly);

    expect(await notifier.purchase(monthly), PurchaseOutcome.failed);
    expect(await notifier.restore(), RestoreOutcome.failed);
    expect(store.purchaseCalls, 1);
    expect(store.restoreCalls, 0);

    store.purchaseResult!.complete(PurchaseOutcome.success);
    await operation;
    expect(notifier.state.isLoading, isFalse);
    expect(notifier.state.isPremium, isTrue);
  });

  test('a restore blocks purchase and duplicate restore until it finishes', () async {
    final store = FakeSubscriptionStore()
      ..restoreResult = Completer<RestoreOutcome>();
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);
    final operation = notifier.restore();

    expect(await notifier.restore(), RestoreOutcome.failed);
    expect(await notifier.purchase(monthly), PurchaseOutcome.failed);
    expect(store.restoreCalls, 1);
    expect(store.purchaseCalls, 0);
    store.restoreResult!.complete(RestoreOutcome.success);
    await operation;
  });

  test('old product reload cannot revoke a newly purchased entitlement', () async {
    final store = FakeSubscriptionStore()
      ..packages = Completer<List<Package>>();
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);
    final load = notifier.loadProducts();
    await pumpEventQueue();
    expect(store.packageCalls, 1);

    await notifier.purchase(monthly);
    store.packages!.complete([monthly]);
    await load;

    expect(notifier.state.isPremium, isTrue);
    expect(notifier.state.entitlementVerified, isTrue);
    expect(notifier.state.availablePackages, [monthly]);
  });

  test('a stale refresh cannot replace a newer store listener update', () async {
    final store = FakeSubscriptionStore();
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);
    await notifier.loadProducts();
    store.premiumResult = Completer<bool>();
    final refresh = notifier.refreshStatus();
    store.listener!(true);
    store.premiumResult!.complete(false);
    await refresh;

    expect(notifier.state.isPremium, isTrue);
  });

  test('disposing detaches the SDK listener and ignores its late callbacks', () async {
    final store = FakeSubscriptionStore();
    final notifier = notifierFor(store);
    await notifier.loadProducts();
    await notifier.loadProducts();
    final lateListener = store.listener!;
    notifier.dispose();
    lateListener(true);

    expect(store.listenerAdds, 1);
    expect(store.listenerRemoves, 1);
    expect(store.listener, isNull);
  });

  test('network failure preserves the last verified premium entitlement', () async {
    final store = FakeSubscriptionStore()..premiumError = StateError('offline');
    final notifier = notifierFor(
      store,
      state: const SubscriptionState(isPremium: true, entitlementVerified: true),
    );
    addTearDown(notifier.dispose);

    await notifier.loadProducts();
    await notifier.refreshStatus();

    expect(notifier.state.isPremium, isTrue);
    expect(notifier.state.entitlementVerified, isTrue);
    expect(notifier.state.isLoadingProducts, isFalse);
  });

  test('verified restore with no entitlement clears stale premium', () async {
    final store = FakeSubscriptionStore()
      ..restoreResult = Completer<RestoreOutcome>();
    final notifier = notifierFor(
      store,
      state: const SubscriptionState(isPremium: true, entitlementVerified: true),
    );
    addTearDown(notifier.dispose);
    final operation = notifier.restore();
    store.restoreResult!.complete(RestoreOutcome.nothingToRestore);
    await operation;

    expect(notifier.state.isPremium, isFalse);
    expect(notifier.state.entitlementVerified, isTrue);
    expect(notifier.state.errorMessage, 'nothing_to_restore');
  });

  test('unexpected purchase failure releases the busy guard for retry', () async {
    final store = FakeSubscriptionStore()..purchaseError = StateError('offline');
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);

    expect(await notifier.purchase(monthly), PurchaseOutcome.failed);
    expect(notifier.state.isLoading, isFalse);
    expect(notifier.state.errorMessage, 'purchase_failed');
    store.purchaseError = null;
    expect(await notifier.purchase(monthly), PurchaseOutcome.success);
    expect(store.purchaseCalls, 2);
  });

  test('concurrent product reloads share a single store round-trip', () async {
    final store = FakeSubscriptionStore()
      ..packages = Completer<List<Package>>();
    final notifier = notifierFor(store);
    addTearDown(notifier.dispose);
    final first = notifier.loadProducts();
    final second = notifier.loadProducts();
    await pumpEventQueue();
    expect(store.packageCalls, 1);
    expect(store.premiumCalls, 1);
    store.packages!.complete([monthly]);
    await Future.wait([first, second]);

    expect(notifier.state.isLoadingProducts, isFalse);
  });
}

class FakeSubscriptionStore implements SubscriptionStore {
  bool configured = true;
  bool canConfigure = true;
  Completer<void>? initialization;
  Completer<List<Package>>? packages;
  Completer<bool>? premiumResult;
  Completer<PurchaseOutcome>? purchaseResult;
  Completer<RestoreOutcome>? restoreResult;
  Object? premiumError;
  Object? purchaseError;
  int premiumCalls = 0;
  int packageCalls = 0;
  int purchaseCalls = 0;
  int restoreCalls = 0;
  int listenerAdds = 0;
  int listenerRemoves = 0;
  void Function(bool)? listener;

  @override
  bool get isConfigured => configured;

  @override
  Future<void> initialize() async {
    await initialization?.future;
    configured = canConfigure;
  }

  @override
  VoidCallback addPremiumListener(void Function(bool) callback) {
    listenerAdds++;
    listener = callback;
    return () {
      listenerRemoves++;
      listener = null;
    };
  }

  @override
  Future<bool> isPremium() async {
    premiumCalls++;
    if (premiumError != null) throw premiumError!;
    final pending = premiumResult;
    if (pending != null) return pending.future;
    return false;
  }

  @override
  Future<List<Package>> getPackages() async {
    packageCalls++;
    final pending = packages;
    if (pending != null) return pending.future;
    return const [];
  }

  @override
  Future<PurchaseOutcome> purchasePackage(Package package) async {
    purchaseCalls++;
    if (purchaseError != null) throw purchaseError!;
    final pending = purchaseResult;
    if (pending != null) return pending.future;
    return PurchaseOutcome.success;
  }

  @override
  Future<RestoreOutcome> restorePurchases() async {
    restoreCalls++;
    final pending = restoreResult;
    if (pending != null) return pending.future;
    return RestoreOutcome.success;
  }
}
