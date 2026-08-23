import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() => database.close());

  test('meal day query excludes midnight of the following day', () async {
    final day = DateTime(2026, 8, 23);
    await database.insertMeal(
      MealsCompanion.insert(
        name: 'Today',
        calories: 100,
        protein: 1,
        carbs: 1,
        fat: 1,
        mealType: 'snack',
        dateTime_: day.add(const Duration(hours: 23, minutes: 59)),
      ),
    );
    await database.insertMeal(
      MealsCompanion.insert(
        name: 'Tomorrow',
        calories: 200,
        protein: 2,
        carbs: 2,
        fat: 2,
        mealType: 'snack',
        dateTime_: day.add(const Duration(days: 1)),
      ),
    );

    final meals = await database.getMealsForDate(day);

    expect(meals.map((meal) => meal.name), ['Today']);
  });

  test('water day query and total exclude following midnight', () async {
    final day = DateTime(2026, 8, 23);
    await database.insertWater(
      WaterIntakeCompanion.insert(
        amountMl: 250,
        date: day.add(const Duration(hours: 23, minutes: 59)),
      ),
    );
    await database.insertWater(
      WaterIntakeCompanion.insert(
        amountMl: 500,
        date: day.add(const Duration(days: 1)),
      ),
    );

    final entries = await database.getWaterForDate(day);
    final total = await database.watchTotalWaterForDate(day).first;

    expect(entries.map((entry) => entry.amountMl), [250]);
    expect(total, 250);
  });
}
