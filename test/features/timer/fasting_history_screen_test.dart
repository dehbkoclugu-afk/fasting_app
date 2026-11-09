import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:fasting_app/features/timer/screens/fasting_history_screen.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class RetryDatabase extends AppDatabase {
  RetryDatabase() : super.forTesting(NativeDatabase.memory());

  bool failLoad = true;
  bool failDelete = true;

  @override
  Future<List<FastingSession>> getAllSessions() async {
    if (failLoad) throw StateError('load failed');
    return super.getAllSessions();
  }

  @override
  Future<int> deleteFinishedSession(int id) async {
    if (failDelete) throw StateError('delete failed');
    return super.deleteFinishedSession(id);
  }
}

Widget historyApp(
  AppDatabase db, {
  Locale locale = const Locale('en'),
  double scale = 1,
}) => ProviderScope(
  overrides: [databaseProvider.overrideWithValue(db)],
  child: MaterialApp(
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    builder: (context, child) => MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(scale)),
      child: child!,
    ),
    home: const FastingHistoryScreen(),
  ),
);

void main() {
  testWidgets('failed load and delete can be retried to an empty history', (
    tester,
  ) async {
    final db = RetryDatabase();
    addTearDown(db.close);
    await tester.runAsync(
      () => db
          .into(db.fastingSessions)
          .insert(
            FastingSessionsCompanion.insert(
              planType: '16_8',
              startTime: DateTime(2026, 11, 2),
              endTime: Value(DateTime(2026, 11, 2, 12)),
              targetMinutes: 960,
            ),
          ),
    );
    await tester.pumpWidget(historyApp(db));
    await tester.pumpAndSettle();
    db.failLoad = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Could not delete this record.'), findsOneWidget);
    expect(find.text('16:8'), findsOneWidget);
    db.failDelete = false;
    await tester.tap(find.text('Try again'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('No data yet'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('narrow RTL history supports large text and unknown plan IDs', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.runAsync(
      () => db
          .into(db.fastingSessions)
          .insert(
            FastingSessionsCompanion.insert(
              planType: 'old_plan_identifier',
              startTime: DateTime(2026, 11, 2),
              endTime: Value(DateTime(2026, 11, 2, 12)),
              targetMinutes: 960,
            ),
          ),
    );
    await tester.pumpWidget(
      historyApp(db, locale: const Locale('ar'), scale: 2),
    );
    await tester.pumpAndSettle();
    expect(find.text('old_plan_identifier'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.text('old_plan_identifier'))),
      TextDirection.rtl,
    );
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('history lists ended fasts and only deletes after confirmation', (
    tester,
  ) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    addTearDown(db.close);
    await tester.runAsync(() async {
      for (final (plan, day, ended) in [
        ('12_12', 1, true),
        ('16_8', 2, true),
        ('18_6', 3, false),
      ]) {
        await db
            .into(db.fastingSessions)
            .insert(
              FastingSessionsCompanion.insert(
                planType: plan,
                startTime: DateTime(2026, 11, day),
                endTime: Value(ended ? DateTime(2026, 11, day, 12) : null),
                targetMinutes: 960,
                actualMinutes: Value(ended ? 720 : null),
              ),
            );
      }
    });
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const FastingHistoryScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('18:6'), findsNothing);
    expect(
      tester.getTopLeft(find.text('16:8')).dy,
      lessThan(tester.getTopLeft(find.text('12:12')).dy),
    );

    await tester.tap(find.byTooltip('Delete').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('16:8'), findsOneWidget);

    await tester.tap(find.byTooltip('Delete').first);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('16:8'), findsNothing);
    expect(find.text('12:12'), findsOneWidget);
    expect((await db.getActiveSession())?.planType, '18_6');
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
