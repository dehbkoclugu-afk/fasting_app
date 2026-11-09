import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/stats/providers/stats_provider.dart';
import 'package:fasting_app/features/timer/providers/fasting_session_provider.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

Future<int> insertFast(
  AppDatabase db, {
  required DateTime start,
  DateTime? end,
  bool completed = false,
  int minutes = 120,
}) => db
    .into(db.fastingSessions)
    .insert(
      FastingSessionsCompanion.insert(
        planType: '16_8',
        startTime: start,
        endTime: Value(end),
        targetMinutes: 120,
        actualMinutes: Value(end == null ? null : minutes),
        completed: Value(completed),
      ),
    );

FastingSession record(int id) => FastingSession(
  id: id,
  planType: '16_8',
  startTime: DateTime(2026, 11, 1),
  endTime: DateTime(2026, 11, 1, 2),
  targetMinutes: 120,
  actualMinutes: 120,
  completed: true,
  createdAt: DateTime(2026, 11, 1),
);

class ControlledDatabase extends AppDatabase {
  ControlledDatabase(this.queries) : super.forTesting(NativeDatabase.memory());

  final List<Completer<List<FastingSession>>> queries;

  @override
  Future<List<FastingSession>> getAllSessions() => queries.removeAt(0).future;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('individual fasting record deletion', () {
    late AppDatabase db;
    setUp(() => db = AppDatabase.forTesting(NativeDatabase.memory()));
    tearDown(() => db.close());

    test(
      'deletes only the requested ended record and preserves other data',
      () async {
        final start = DateTime(2026, 11, 1);
        final removed = await insertFast(
          db,
          start: start,
          end: start.add(const Duration(hours: 2)),
          completed: true,
        );
        final retained = await insertFast(
          db,
          start: start,
          end: start.add(const Duration(hours: 1)),
          minutes: 60,
        );
        await db.insertWater(
          WaterIntakeCompanion.insert(amountMl: 250, date: start),
        );

        expect(await db.deleteFinishedSession(removed), 1);
        expect((await db.getAllSessions()).map((s) => s.id), [retained]);
        expect((await db.getWaterForDate(start)).single.amountMl, 250);
      },
    );

    test(
      'early-ended records can be deleted without reaching their target',
      () async {
        final start = DateTime(2026, 11, 1);
        final id = await insertFast(
          db,
          start: start,
          end: start.add(const Duration(minutes: 10)),
          minutes: 10,
        );

        expect(await db.deleteFinishedSession(id), 1);
        expect(await db.getAllSessions(), isEmpty);
      },
    );

    test(
      'active and unknown IDs cannot be deleted through the history API',
      () async {
        final id = await insertFast(db, start: DateTime(2026, 11, 1));

        expect(await db.deleteFinishedSession(id), 0);
        expect(await db.deleteFinishedSession(id + 100), 0);
        expect((await db.getActiveSession())!.id, id);
      },
    );

    test(
      'deletion refreshes warm statistics, heatmap and streak providers',
      () async {
        final now = DateTime.now();
        final start = now.subtract(const Duration(hours: 2));
        final id = await insertFast(
          db,
          start: start,
          end: now,
          completed: true,
        );
        final yesterday = DateTime(now.year, now.month, now.day - 1, 12);
        await insertFast(
          db,
          start: yesterday.subtract(const Duration(hours: 1)),
          end: yesterday,
          minutes: 60,
          completed: true,
        );
        final container = ProviderContainer(
          overrides: [databaseProvider.overrideWithValue(db)],
        );
        addTearDown(container.dispose);
        final notifier = container.read(fastingSessionProvider.notifier);
        await notifier.loadSessions();
        final month = DateTime(start.year, start.month);
        final before = await container.read(statsProvider(7).future);
        final beforeHeatmap = await container.read(
          heatmapProvider(month).future,
        );
        final previousHours = beforeHeatmap.values.fold<double>(
          0,
          (sum, hours) => sum + hours,
        );
        expect(before.totalSessions, 2);
        expect(container.read(streakProvider), 2);

        expect(await notifier.deleteSession(id), isTrue);

        final after = await container.read(statsProvider(7).future);
        final afterHeatmap = await container.read(
          heatmapProvider(month).future,
        );
        expect(after.totalSessions, 1);
        expect(after.totalFastingHours, 1);
        expect(after.averageDurationHours, 1);
        expect(after.currentStreak, 1);
        expect(container.read(streakProvider), 1);
        expect(
          afterHeatmap.values.fold<double>(0, (sum, hours) => sum + hours),
          previousHours - 2,
        );
      },
    );

    test(
      'notifier reports a rejected active-record deletion without removing it',
      () async {
        final id = await insertFast(db, start: DateTime.now());
        final notifier = FastingSessionNotifier(db);
        addTearDown(notifier.dispose);
        await notifier.loadSessions();

        expect(await notifier.deleteSession(id), isFalse);
        expect(notifier.state.requireValue.single.id, id);
        expect((await db.getActiveSession())!.id, id);
      },
    );
  });

  test(
    'an obsolete load cannot replace a more recent history snapshot',
    () async {
      final old = Completer<List<FastingSession>>();
      final latest = Completer<List<FastingSession>>();
      final db = ControlledDatabase([old, latest]);
      addTearDown(db.close);
      final notifier = FastingSessionNotifier(db);
      addTearDown(notifier.dispose);
      final reload = notifier.loadSessions();
      latest.complete([record(2)]);
      await reload;
      old.complete([record(1), record(2)]);
      await pumpEventQueue();

      expect(notifier.state.requireValue.map((s) => s.id), [2]);
    },
  );

  test(
    'a pending history query may finish after the notifier is disposed',
    () async {
      final initial = Completer<List<FastingSession>>();
      final pending = Completer<List<FastingSession>>();
      final db = ControlledDatabase([initial, pending]);
      addTearDown(db.close);
      final notifier = FastingSessionNotifier(db);
      initial.complete([]);
      await pumpEventQueue();
      final load = notifier.loadSessions();
      notifier.dispose();
      pending.complete([record(1)]);

      await expectLater(load, completes);
    },
  );
}
