import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a store that never configured is not proof of no subscription', () async {
    // No RevenueCat plugin exists under test, so configure fails as it would
    // on a device with a transient store problem.
    final notifier = SubscriptionNotifier();
    addTearDown(notifier.dispose);

    await pumpEventQueue();

    expect(notifier.state.isStoreAvailable, isFalse);
    expect(notifier.state.entitlementVerified, isFalse);
  });
}
