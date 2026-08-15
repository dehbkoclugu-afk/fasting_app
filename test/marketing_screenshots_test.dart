import 'dart:io';
import 'dart:ui';

import 'package:fasting_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/google_mobile_ads'),
      (_) async => null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('purchases_flutter'),
      (_) async => null,
    );
    messenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (_) async => '/tmp',
    );
  });

  testWidgets(
    'captures Turkish dark-mode marketing screens',
    (tester) async {
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

      expect(find.text('Bugünkü ritmin'), findsOneWidget);
      await expectLater(
        find.byType(FastingApp),
        matchesGoldenFile('goldens/fasttrack-timer-dark-tr.png'),
      );

      await tester.drag(find.byType(Scrollable).first, const Offset(0, -480));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(FastingApp),
        matchesGoldenFile('goldens/fasttrack-hydration-dark-tr.png'),
      );

      await tester.drag(find.byType(Scrollable).first, const Offset(0, -480));
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(FastingApp),
        matchesGoldenFile('goldens/fasttrack-details-dark-tr.png'),
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
    },
    skip: Platform.environment['CAPTURE_MARKETING_SCREENSHOTS'] != '1',
  );
}
