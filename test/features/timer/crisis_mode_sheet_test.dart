import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:fasting_app/features/timer/providers/timer_provider.dart';
import 'package:fasting_app/features/timer/widgets/crisis_mode_sheet.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });
  tearDown(() => database.close());

  Future<void> openSheet(WidgetTester tester, {TimerNotifier? timer}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(database),
          if (timer != null) timerProvider.overrideWith((ref) => timer),
        ],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: Builder(
              builder: (context) => TextButton(
                onPressed: () => showCrisisMode(context),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('feeling unwell leads only to ending the fast', (tester) async {
    await openSheet(tester);

    await tester.tap(find.text('I feel unwell'));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('End your fast now'), findsOneWidget);
    expect(find.textContaining('emergency number'), findsOneWidget);
    expect(find.text('Give it 10 minutes'), findsNothing);
    expect(find.widgetWithText(FilledButton, 'End my fast'), findsOneWidget);
  });

  testWidgets('a failed safety exit stays open and offers a retry', (tester) async {
    await openSheet(tester, timer: FailingSafetyTimer(database));
    await tester.tap(find.text('I feel unwell'));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'End my fast'));
    await tester.pumpAndSettle();

    expect(find.text('End your fast now'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('other reasons still offer a real way to end', (tester) async {
    await openSheet(tester);

    await tester.tap(find.text('Hunger'));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(OutlinedButton, 'End my fast'), findsOneWidget);
  });
}

class FailingSafetyTimer extends TimerNotifier {
  FailingSafetyTimer(super.database) : super(restoreOnCreate: false);

  @override
  Future<void> endFastQuietly() async {
    throw StateError('write failed');
  }
}
