import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import '../../timer/providers/water_provider.dart';

class DailyMealState {
  final List<Meal> meals;
  final int totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final int calorieGoal;

  const DailyMealState({
    this.meals = const [],
    this.totalCalories = 0,
    this.totalProtein = 0,
    this.totalCarbs = 0,
    this.totalFat = 0,
    this.calorieGoal = 2000,
  });

  int get remainingCalories => calorieGoal - totalCalories;
}

class MealNotifier extends StateNotifier<DailyMealState> {
  final AppDatabase _db;

  MealNotifier(this._db) : super(const DailyMealState()) {
    loadToday();
  }

  Future<void> loadToday() async {
    final today = DateTime.now();
    final meals = await _db.getMealsForDate(today);

    int totalCal = 0;
    double totalP = 0, totalC = 0, totalF = 0;
    for (final meal in meals) {
      totalCal += meal.calories;
      totalP += meal.protein;
      totalC += meal.carbs;
      totalF += meal.fat;
    }

    state = DailyMealState(
      meals: meals,
      totalCalories: totalCal,
      totalProtein: totalP,
      totalCarbs: totalC,
      totalFat: totalF,
      calorieGoal: state.calorieGoal,
    );
  }

  Future<void> addMeal({
    required String name,
    required int calories,
    required double protein,
    required double carbs,
    required double fat,
    required String mealType,
  }) async {
    await _db.insertMeal(
      MealsCompanion(
        name: Value(name),
        calories: Value(calories),
        protein: Value(protein),
        carbs: Value(carbs),
        fat: Value(fat),
        mealType: Value(mealType),
        dateTime_: Value(DateTime.now()),
      ),
    );
    await loadToday();
  }

  Future<void> removeMeal(int id) async {
    await _db.deleteMeal(id);
    await loadToday();
  }

  void setCalorieGoal(int goal) {
    state = DailyMealState(
      meals: state.meals,
      totalCalories: state.totalCalories,
      totalProtein: state.totalProtein,
      totalCarbs: state.totalCarbs,
      totalFat: state.totalFat,
      calorieGoal: goal,
    );
  }
}

final mealProvider = StateNotifierProvider<MealNotifier, DailyMealState>((ref) {
  final db = ref.watch(databaseProvider);
  return MealNotifier(db);
});
