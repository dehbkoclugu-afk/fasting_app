import 'package:drift/native.dart';
import 'package:fasting_app/core/utils/fasting_safety.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/onboarding/screens/safety_screen.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => database.close());

  Future<void> pumpGate(
    WidgetTester tester, {
    Map<String, Object> prefs = const {},
  }) async {
    SharedPreferences.setMockInitialValues(prefs);
    final router = GoRouter(
      initialLocation: '/safety',
      routes: [
        GoRoute(path: '/safety', builder: (_, __) => const SafetyScreen()),
        GoRoute(path: '/timer', builder: (_, __) => const Text('timer')),
        GoRoute(
          path: '/onboarding/goals',
          builder: (_, __) => const Text('goals'),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(database)],
        child: MaterialApp.router(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tapContinue(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Continue'));
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
  }

  Future<String?> status() async => (await SharedPreferences.getInstance())
      .getString(FastingSafety.statusKey);

  testWidgets('continue does nothing until a choice is made', (tester) async {
    await pumpGate(tester);

    await tapContinue(tester);

    expect(find.text('goals'), findsNothing);
    expect(await status(), isNull);
  });

  testWidgets('a blocking answer stops the user at the gate', (tester) async {
    await pumpGate(tester);

    await tester.tap(find.text('I am pregnant or breastfeeding'));
    await tester.pump();
    await tapContinue(tester);

    expect(find.text('This app is not a safe fit for you'), findsOneWidget);
    expect(find.text('goals'), findsNothing);
    expect(await status(), FastingSafety.blocked);
  });

  testWidgets('diabetes needs the doctor acknowledgement', (tester) async {
    await pumpGate(tester);

    await tester.tap(
      find.text('I have diabetes or take medication that affects blood sugar'),
    );
    await tester.pump();
    await tapContinue(tester);
    expect(find.text('goals'), findsNothing);

    await tester.ensureVisible(
      find.text('I will talk to my doctor before fasting'),
    );
    await tester.tap(find.text('I will talk to my doctor before fasting'));
    await tester.pump();
    await tapContinue(tester);

    expect(find.text('goals'), findsOneWidget);
    expect(await status(), FastingSafety.cleared);
  });

  testWidgets('someone already onboarded returns to the timer', (tester) async {
    await pumpGate(tester, prefs: {'onboardingCompleted': true});

    await tester.ensureVisible(find.text('None of these apply to me'));
    await tester.tap(find.text('None of these apply to me'));
    await tester.pump();
    await tapContinue(tester);

    expect(find.text('timer'), findsOneWidget);
  });
}
