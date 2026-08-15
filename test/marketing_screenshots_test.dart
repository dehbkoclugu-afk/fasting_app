import 'dart:convert';
import 'dart:ui';

import 'package:fasting_app/app.dart';
import 'package:fasting_app/features/profile/providers/settings_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMessageHandler('flutter/assets', (ByteData? message) async {
          final key = utf8.decode(message!.buffer.asUint8List());
          if (key == 'AssetManifest.json') {
            return ByteData.sublistView(utf8.encode('{}'));
          }
          return null;
        });
  });

  testWidgets('captures Turkish dark-mode marketing screens', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    SharedPreferences.setMockInitialValues({
      'onboardingCompleted': true,
      'themeMode': 2,
      'locale': 'tr',
      'selectedPlanId': '16_8',
      'userName': 'Kullanıcı',
      'waterReminders': true,
    });

    await tester.pumpWidget(
      const ProviderScope(child: FastingApp(showOnboarding: false)),
    );
    await tester.pumpAndSettle();

    expect(find.text('Bugünün ritmi'), findsOneWidget);
    await expectLater(
      find.byType(FastingApp),
      matchesGoldenFile('goldens/fasttrack-timer-dark-tr.png'),
    );

    await tester.tap(find.text('Rapor'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(FastingApp),
      matchesGoldenFile('goldens/fasttrack-stats-dark-tr.png'),
    );

    await tester.tap(find.text('Keşfet'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(FastingApp),
      matchesGoldenFile('goldens/fasttrack-explore-dark-tr.png'),
    );

    await tester.tap(find.text('Hesap'));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(FastingApp),
      matchesGoldenFile('goldens/fasttrack-profile-dark-tr.png'),
    );

    await tester.drag(find.byType(Scrollable).first, const Offset(0, -1200));
    await tester.pumpAndSettle();
    expect(find.text('Gizlilik Politikası'), findsOneWidget);
    await expectLater(
      find.byType(FastingApp),
      matchesGoldenFile('goldens/fasttrack-privacy-dark-tr.png'),
    );
  });
}
