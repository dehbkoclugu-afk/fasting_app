import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a store that never configured is not proof of no subscription', () async {
    // Skip constructor initialization so this test can await the complete
    // store round-trip instead of racing the native platform response.
    final notifier = SubscriptionNotifier(
      initialState: const SubscriptionState(),
    );
    addTearDown(notifier.dispose);

    // No RevenueCat plugin exists under test, so configure fails as it would
    // on a device with a transient store problem.
    await notifier.loadProducts();

    expect(notifier.state.isLoadingProducts, isFalse);
    expect(notifier.state.isStoreAvailable, isFalse);
    expect(notifier.state.entitlementVerified, isFalse);
  });
}
