import 'dart:convert';
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
  setUpAll(() async {
    if (Platform.environment['CAPTURE_MARKETING_SCREENSHOTS'] != '1') {
      return;
    }
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
    Future<ByteData> fontBytes(String path) async =>
        ByteData.sublistView(await File(path).readAsBytes());
    final fontLoaders = {
      'Inter_regular': 'Inter-Regular.ttf',
      'Inter_500': 'Inter-Medium.ttf',
      'Inter_600': 'Inter-SemiBold.ttf',
      'Inter_700': 'Inter-Bold.ttf',
      'Inter_800': 'Inter-ExtraBold.ttf',
      'MaterialIcons': 'MaterialIcons-Regular.otf',
    }.entries.map((entry) {
      final loader = FontLoader(entry.key)
        ..addFont(fontBytes('test/fonts/${entry.value}'));
      return loader.load();
    });
    await Future.wait(fontLoaders);

    final messenger =
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
    messenger.setMockMessageHandler('flutter/assets', (ByteData? message) async {
      final key = utf8.decode(message!.buffer.asUint8List());
      if (key.startsWith('test/fonts/')) {
        final bytes = await File(key).readAsBytes();
        return ByteData.sublistView(bytes);
      }
      if (key != 'AssetManifest.json') {
        return null;
      }
      const fontAssets = [
        'test/fonts/Inter-Regular.ttf',
        'test/fonts/Inter-Medium.ttf',
        'test/fonts/Inter-SemiBold.ttf',
        'test/fonts/Inter-Bold.ttf',
        'test/fonts/Inter-ExtraBold.ttf',
      ];
      final manifest = {
        for (final asset in fontAssets) asset: [asset],
      };
      return ByteData.sublistView(utf8.encode(jsonEncode(manifest)));
    });
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
