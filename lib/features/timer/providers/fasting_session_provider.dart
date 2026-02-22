import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/database/app_database.dart';
import 'water_provider.dart';

class FastingSessionNotifier extends StateNotifier<AsyncValue<List<FastingSession>>> {
  final AppDatabase _db;

  FastingSessionNotifier(this._db) : super(const AsyncValue.loading()) {
    loadSessions();
  }

  Future<void> loadSessions() async {
    try {
      final sessions = await _db.getCompletedSessions();
      state = AsyncValue.data(sessions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveSession({
    required String planType,
    required DateTime startTime,
    required int targetMinutes,
    required int actualMinutes,
    required bool completed,
  }) async {
    await _db.insertSession(
      FastingSessionsCompanion(
        planType: Value(planType),
        startTime: Value(startTime),
        endTime: Value(DateTime.now()),
        targetMinutes: Value(targetMinutes),
        actualMinutes: Value(actualMinutes),
        completed: Value(completed),
      ),
    );
    await loadSessions();
  }

  Future<List<FastingSession>> getSessionsForWeek() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return _db.getSessionsInRange(start, now);
  }

  int getStreak(List<FastingSession> sessions) {
    if (sessions.isEmpty) return 0;
    final completedDates = sessions
        .where((s) => s.completed)
        .map((s) => s.startTime)
        .toList();
    if (completedDates.isEmpty) return 0;

    completedDates.sort((a, b) => b.compareTo(a));
    final today = DateTime.now();
    var checkDate = DateTime(today.year, today.month, today.day);
    int streak = 0;

    for (final date in completedDates) {
      final dateOnly = DateTime(date.year, date.month, date.day);
      if (dateOnly == checkDate) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else if (dateOnly.isBefore(checkDate)) {
        break;
      }
    }
    return streak;
  }
}

final fastingSessionProvider =
    StateNotifierProvider<FastingSessionNotifier, AsyncValue<List<FastingSession>>>((ref) {
  final db = ref.watch(databaseProvider);
  return FastingSessionNotifier(db);
});

final streakProvider = FutureProvider<int>((ref) async {
  final db = ref.watch(databaseProvider);
  final sessions = await db.getCompletedSessions();
  final notifier = FastingSessionNotifier(db);
  return notifier.getStreak(sessions);
});
