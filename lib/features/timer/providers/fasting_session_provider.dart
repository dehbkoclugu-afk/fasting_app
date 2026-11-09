import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/fasting_streak.dart';
import '../../../data/database/app_database.dart';
import 'water_provider.dart';

class FastingSessionNotifier
    extends StateNotifier<AsyncValue<List<FastingSession>>> {
  final AppDatabase _db;
  int _loadRevision = 0;

  FastingSessionNotifier(this._db, {void Function()? onDeleted})
    : _onDeleted = onDeleted,
      super(const AsyncValue.loading()) {
    loadSessions();
  }

  final void Function()? _onDeleted;

  Future<void> loadSessions() async {
    if (!mounted) return;
    final revision = ++_loadRevision;
    try {
      final sessions = await _db.getAllSessions();
      if (mounted && revision == _loadRevision) {
        state = AsyncValue.data(sessions);
      }
    } catch (e, st) {
      if (mounted && revision == _loadRevision) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<bool> deleteSession(int id) async {
    if (!mounted) return false;
    final deleted = await _db.deleteFinishedSession(id);
    if (deleted == 0) return false;
    if (mounted) {
      _onDeleted?.call();
      await loadSessions();
    }
    return true;
  }

  Future<List<FastingSession>> getSessionsForWeek() async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    return _db.getSessionsInRange(start, now);
  }

  int getStreak(List<FastingSession> sessions) {
    return fastingStreakFor(
      sessions.where((s) => s.completed),
      DateTime.now(),
    ).$1;
  }
}

final fastingHistoryRevisionProvider = StateProvider<int>((ref) => 0);

final fastingSessionProvider =
    StateNotifierProvider<
      FastingSessionNotifier,
      AsyncValue<List<FastingSession>>
    >((ref) {
      final db = ref.watch(databaseProvider);
      return FastingSessionNotifier(
        db,
        onDeleted: () =>
            ref.read(fastingHistoryRevisionProvider.notifier).state++,
      );
    });

final streakProvider = Provider<int>((ref) {
  final sessionsAsync = ref.watch(fastingSessionProvider);
  return sessionsAsync.when(
    data: (sessions) {
      return fastingStreakFor(
        sessions.where((s) => s.completed),
        DateTime.now(),
      ).$1;
    },
    loading: () => 0,
    error: (_, __) => 0,
  );
});
