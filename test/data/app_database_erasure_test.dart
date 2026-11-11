import 'package:drift/drift.dart' hide isNull;
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() => database = AppDatabase.forTesting(NativeDatabase.memory()));
  tearDown(() => database.close());

  Future<int> addWeight(double weight) => database.insertMetric(
    BodyMetricsCompanion.insert(date: DateTime(2026, 8, 23), weight: Value(weight)),
  );

  test('deleteMetric removes only that entry', () async {
    final first = await addWeight(70);
    await addWeight(71);

    await database.deleteMetric(first);

    expect((await database.getAllMetrics()).single.weight, 71);
  });

  test('deleteAllUserData empties every table', () async {
    await addWeight(70);
    await database.insertWater(
      WaterIntakeCompanion.insert(amountMl: 250, date: DateTime(2026, 8, 23)),
    );
    await database.createOrGetActiveSession(
      FastingSessionsCompanion.insert(
        planType: '16_8',
        startTime: DateTime(2026, 8, 23),
        targetMinutes: 960,
      ),
    );
    await database.setSetting('k', 'v');

    await database.deleteAllUserData();

    expect(await database.getAllMetrics(), isEmpty);
    expect(await database.getWaterForDate(DateTime(2026, 8, 23)), isEmpty);
    expect(await database.getActiveSession(), isNull);
    expect(await database.getSetting('k'), isNull);
  });
}
