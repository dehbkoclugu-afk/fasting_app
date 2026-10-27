import 'dart:async';
import 'dart:typed_data';

import 'package:fasting_app/features/meals/providers/food_scan_provider.dart';
import 'package:fasting_app/features/meals/screens/food_scan_screen.dart';
import 'package:fasting_app/features/paywall/providers/subscription_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:fasting_app/services/food_vision_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _Subscription extends SubscriptionNotifier {
  _Subscription() : super(initialState: const SubscriptionState());
  void unlock() => state = state.copyWith(isPremium: true);
}

class _Vision extends FoodVisionService {
  _Vision() : super(apiKey: 'test-key');
  int calls = 0;
  final result = Completer<FoodAnalysis>();
  @override
  Future<FoodAnalysis> analyze({
    required Uint8List imageBytes,
    required String languageCode,
    String mimeType = 'image/jpeg',
  }) {
    calls++;
    return result.future;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  Future<GoRouter> openScanner(
    WidgetTester tester,
    _Subscription subscription,
    _Vision service, {
    Uint8List? recovered,
    TextScaler textScaler = TextScaler.noScaling,
    Locale locale = const Locale('en'),
  }) async {
    final router = GoRouter(
      initialLocation: '/food-scan',
      routes: [
        GoRoute(
          path: '/timer',
          builder: (_, __) => const Scaffold(body: Text('Home')),
        ),
        GoRoute(
          path: '/food-scan',
          builder: (_, __) => FoodScanScreen(initialImageBytes: recovered),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          subscriptionProvider.overrideWith((ref) => subscription),
          foodScanProvider.overrideWith(
            (ref) => FoodScanNotifier(service: service, dailyLimit: 0),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          locale: locale,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: textScaler),
            child: child!,
          ),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        ),
      ),
    );
    await tester.pump();
    return router;
  }

  testWidgets('recovered photo waits for premium and starts only once', (
    tester,
  ) async {
    final subscription = _Subscription();
    final service = _Vision();
    await openScanner(
      tester,
      subscription,
      service,
      recovered: Uint8List.fromList([1, 2, 3]),
    );
    expect(service.calls, 0);
    subscription.unlock();
    await tester.pump();
    await tester.pump();
    expect(service.calls, 1);
    subscription.unlock();
    await tester.pump();
    expect(service.calls, 1);
    // The invalid preview must render its fallback rather than throw.
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('cold recovery root can close to the home route', (tester) async {
    final router = await openScanner(tester, _Subscription(), _Vision());
    expect(router.canPop(), isFalse);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsOneWidget);
  });

  testWidgets('locked and premium screens fit a narrow large-text display', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320 * 3, 568 * 3);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    final subscription = _Subscription();
    await openScanner(
      tester,
      subscription,
      _Vision(),
      textScaler: const TextScaler.linear(2),
      locale: const Locale('ar'),
    );
    expect(tester.takeException(), isNull);
    subscription.unlock();
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(find.byType(Scrollable), findsWidgets);
  });

  testWidgets('first scan asks before sending a photo to Gemini', (
    tester,
  ) async {
    final subscription = _Subscription()..unlock();
    final service = _Vision();
    await openScanner(tester, subscription, service);
    await tester.pump();

    final takePhoto = find.text('Take photo');
    await tester.ensureVisible(takePhoto);
    await tester.tap(takePhoto);
    await tester.pumpAndSettle();
    expect(find.text('Send photos to Google Gemini?'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Send photos to Google Gemini?'), findsNothing);
    expect(service.calls, 0);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getBool('foodScanAiConsent'), isNull);
  });
}
