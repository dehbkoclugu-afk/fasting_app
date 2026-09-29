import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/fasting_streak.dart';
import '../../../data/database/app_database.dart';
import 'water_provider.dart';

class FastingSessionNotifier
    extends StateNotifier<AsyncValue<List<FastingSession>>> {
  final AppDatabase _db;

  FastingSessionNotifier(this._db) : super(const AsyncValue.loading()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    try {
      final sessions = await _db.getAllSessions();
      state = AsyncValue.data(sessions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<List<FastingSession>> getSessionsForWeek() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return _db.getSessionsInRange(start, now);
  }

  int getStreak(List<FastingSession> sessions) {
    return currentFastingStreak(
      sessions.where((s) => s.completed).map((s) => s.startTime),
      DateTime.now(),
    );
  }
}

final fastingSessionProvider =
    StateNotifierProvider<
      FastingSessionNotifier,
      AsyncValue<List<FastingSession>>
    >((ref) {
      final db = ref.watch(databaseProvider);
      return FastingSessionNotifier(db);
    });

final streakProvider = Provider<int>((ref) {
  final sessionsAsync = ref.watch(fastingSessionProvider);
  return sessionsAsync.when(
    data: (sessions) {
      return currentFastingStreak(
        sessions.where((s) => s.completed).map((s) => s.startTime),
        DateTime.now(),
      );
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});
