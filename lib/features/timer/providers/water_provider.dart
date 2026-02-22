import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../data/database/app_database.dart';

class WaterState {
  final int totalMl;
  final int goalMl;
  final List<WaterIntakeData> entries;

  const WaterState({
    this.totalMl = 0,
    this.goalMl = 2500,
    this.entries = const [],
  });

  double get progress => goalMl > 0 ? (totalMl / goalMl).clamp(0.0, 1.0) : 0;

  WaterState copyWith({
    int? totalMl,
    int? goalMl,
    List<WaterIntakeData>? entries,
  }) {
    return WaterState(
      totalMl: totalMl ?? this.totalMl,
      goalMl: goalMl ?? this.goalMl,
      entries: entries ?? this.entries,
    );
  }
}

class WaterNotifier extends StateNotifier<WaterState> {
  final AppDatabase _db;

  WaterNotifier(this._db) : super(const WaterState()) {
    _loadToday();
  }

  Future<void> _loadToday() async {
    final today = DateTime.now();
    final entries = await _db.getWaterForDate(today);
    final total = entries.fold<int>(0, (sum, e) => sum + e.amountMl);
    state = state.copyWith(totalMl: total, entries: entries);
  }

  Future<void> addWater(int ml) async {
    await _db.insertWater(
      WaterIntakeCompanion(
        amountMl: Value(ml),
        date: Value(DateTime.now()),
      ),
    );
    await _loadToday();
  }

  Future<void> setGoal(int ml) async {
    state = state.copyWith(goalMl: ml);
  }
}

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final waterProvider = StateNotifierProvider<WaterNotifier, WaterState>((ref) {
  final db = ref.watch(databaseProvider);
  return WaterNotifier(db);
});
