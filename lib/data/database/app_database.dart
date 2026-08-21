import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/fasting_sessions.dart';
import 'tables/body_metrics.dart';
import 'tables/meals.dart';
import 'tables/water_intake.dart';
import 'tables/settings.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [FastingSessions, BodyMetrics, Meals, WaterIntake, Settings],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  // --- Fasting Sessions ---

  Future<List<FastingSession>> getAllSessions() =>
      select(fastingSessions).get();

  Future<List<FastingSession>> getSessionsInRange(
    DateTime start,
    DateTime end,
  ) {
    return (select(fastingSessions)
          ..where((s) => s.startTime.isBetweenValues(start, end))
          ..orderBy([(s) => OrderingTerm.desc(s.startTime)]))
        .get();
  }

  Future<FastingSession?> getActiveSession() {
    return (select(fastingSessions)
          ..where((s) => s.endTime.isNull())
          ..orderBy([(s) => OrderingTerm.asc(s.id)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<FastingSession> createOrGetActiveSession(
    FastingSessionsCompanion session,
  ) {
    return transaction(() async {
      final active = await getActiveSession();
      if (active != null) return active;
      final id = await into(fastingSessions).insert(session);
      return (select(fastingSessions)
        ..where((s) => s.id.equals(id))).getSingle();
    });
  }

  Future<bool> finalizeActiveSession({
    required int id,
    required DateTime endTime,
    required int actualMinutes,
    required bool completed,
  }) async {
    final changed = await (update(fastingSessions)
      ..where((s) => s.id.equals(id) & s.endTime.isNull())).write(
      FastingSessionsCompanion(
        endTime: Value(endTime),
        actualMinutes: Value(actualMinutes),
        completed: Value(completed),
      ),
    );
    return changed == 1;
  }

  Future<List<FastingSession>> getCompletedSessions() {
    return (select(fastingSessions)
          ..where((s) => s.completed.equals(true))
          ..orderBy([(s) => OrderingTerm.desc(s.startTime)]))
        .get();
  }

  // --- Body Metrics ---

  Future<List<BodyMetric>> getAllMetrics() {
    return (select(bodyMetrics)
      ..orderBy([(m) => OrderingTerm.desc(m.date)])).get();
  }

  Future<BodyMetric?> getLatestMetric() {
    return (select(bodyMetrics)
          ..orderBy([(m) => OrderingTerm.desc(m.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> insertMetric(BodyMetricsCompanion metric) {
    return into(bodyMetrics).insert(metric);
  }

  Future<List<BodyMetric>> getWeightHistory() {
    return (select(bodyMetrics)
          ..where((m) => m.weight.isNotNull())
          ..orderBy([(m) => OrderingTerm.asc(m.date)]))
        .get();
  }

  // --- Meals ---

  Future<List<Meal>> getMealsForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(meals)
          ..where((m) => m.dateTime_.isBetweenValues(start, end))
          ..orderBy([(m) => OrderingTerm.asc(m.dateTime_)]))
        .get();
  }

  Future<int> insertMeal(MealsCompanion meal) {
    return into(meals).insert(meal);
  }

  Future<int> deleteMeal(int id) {
    return (delete(meals)..where((m) => m.id.equals(id))).go();
  }

  // --- Water Intake ---

  Future<List<WaterIntakeData>> getWaterForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(waterIntake)
      ..where((w) => w.date.isBetweenValues(start, end))).get();
  }

  Future<int> insertWater(WaterIntakeCompanion entry) {
    return into(waterIntake).insert(entry);
  }

  Future<int> deleteWater(int id) {
    return (delete(waterIntake)..where((entry) => entry.id.equals(id))).go();
  }

  Stream<int> watchTotalWaterForDate(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (selectOnly(waterIntake)
          ..addColumns([waterIntake.amountMl.sum()])
          ..where(waterIntake.date.isBetweenValues(start, end)))
        .map((row) => row.read(waterIntake.amountMl.sum()) ?? 0)
        .watchSingle();
  }

  // --- Settings ---

  Future<String?> getSetting(String key) async {
    final result =
        await (select(settings)
          ..where((s) => s.key.equals(key))).getSingleOrNull();
    return result?.value;
  }

  Future<void> setSetting(String key, String value) {
    return into(settings).insertOnConflictUpdate(
      SettingsCompanion(key: Value(key), value: Value(value)),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'fasting_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
