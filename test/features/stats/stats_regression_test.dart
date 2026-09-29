import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:fasting_app/features/stats/providers/stats_provider.dart';
import 'package:fasting_app/features/timer/providers/water_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test(
    'same-day sessions add up and finished-session average is consistent',
    () async {
      final db = AppDatabase.forTesting(NativeDatabase.memory());
      final now = DateTime.now();
      final day = DateTime(now.year, now.month, now.day);
      for (final (minutes, completed) in [(120, true), (180, false)]) {
        await db
            .into(db.fastingSessions)
            .insert(
              FastingSessionsCompanion.insert(
                planType: '16_8',
                startTime: day,
                targetMinutes: 960,
                endTime: Value(day.add(const Duration(hours: 5))),
                actualMinutes: Value(minutes),
                completed: Value(completed),
              ),
            );
      }
      final container = ProviderContainer(
        overrides: [databaseProvider.overrideWithValue(db)],
      );
      final stats = await container.read(statsProvider(7).future);
      expect(stats.weeklyHours[now.weekday - 1], 5);
      expect(stats.averageDurationHours, 2.5);
      expect(stats.totalFastingHours, 5);
      expect(stats.completionRate, 0.5);
      container.dispose();
      await db.close();
    },
  );

  test('latest weight skips older readings', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final today = DateTime.now();
    await db.insertMetric(
      BodyMetricsCompanion.insert(
        date: today.subtract(const Duration(days: 5)),
        weight: const Value(80),
      ),
    );
    await db.insertMetric(
      BodyMetricsCompanion.insert(date: today, weight: const Value(75)),
    );
    final container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
    expect(await container.read(latestWeightProvider.future), 75);
    container.dispose();
    await db.close();
  });
}
