import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/fasting_streak.dart';
import '../../timer/providers/water_provider.dart';

class StatsData {
  final int totalSessions;
  final double averageDurationHours;
  final int currentStreak;
  final int longestStreak;
  final double completionRate;
  final int totalFastingHours;
  final List<double> weeklyHours; // 7 gün, Pzt-Paz

  const StatsData({
    this.totalSessions = 0,
    this.averageDurationHours = 0,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.completionRate = 0,
    this.totalFastingHours = 0,
    this.weeklyHours = const [0, 0, 0, 0, 0, 0, 0],
  });
}

final statsProvider = FutureProvider.family<StatsData, int>((
  ref,
  periodDays,
) async {
  final db = ref.watch(databaseProvider);
  final now = DateTime.now();
  final start = now.subtract(Duration(days: periodDays));

  final sessions = await db.getSessionsInRange(start, now);
  final completedSessions = sessions.where((s) => s.completed).toList();

  // Haftalık saat dağılımı
  final weeklyHours = List<double>.filled(7, 0);
  final weekStart = now.subtract(Duration(days: now.weekday - 1));
  for (final session in sessions) {
    final dayIndex = session.startTime
        .difference(DateTime(weekStart.year, weekStart.month, weekStart.day))
        .inDays;
    if (dayIndex >= 0 && dayIndex < 7 && session.actualMinutes != null) {
      weeklyHours[dayIndex] += session.actualMinutes! / 60;
    }
  }

  // Streak hesapla
  final allCompleted = await db.getCompletedSessions();
  final currentStreak = currentFastingStreak(
    allCompleted.map((session) => session.startTime),
    now,
  );
  int longestStreak = 0;
  int tempStreak = 0;
  DateTime? lastDate;

  final sortedDates =
      allCompleted
          .map(
            (s) =>
                DateTime(s.startTime.year, s.startTime.month, s.startTime.day),
          )
          .toSet()
          .toList()
        ..sort((a, b) => b.compareTo(a));

  // En uzun streak
  for (final date in sortedDates.reversed) {
    if (lastDate == null ||
        date == DateTime(lastDate.year, lastDate.month, lastDate.day + 1)) {
      tempStreak++;
    } else {
      if (tempStreak > longestStreak) longestStreak = tempStreak;
      tempStreak = 1;
    }
    lastDate = date;
  }
  if (tempStreak > longestStreak) longestStreak = tempStreak;

  final finishedSessions = sessions
      .where((s) => s.actualMinutes != null)
      .toList();
  final totalMinutes = finishedSessions.fold<int>(
    0,
    (sum, s) => sum + (s.actualMinutes ?? 0),
  );

  return StatsData(
    totalSessions: sessions.length,
    averageDurationHours: finishedSessions.isEmpty
        ? 0
        : totalMinutes / finishedSessions.length / 60,
    currentStreak: currentStreak,
    longestStreak: longestStreak,
    completionRate: sessions.isEmpty
        ? 0
        : completedSessions.length / sessions.length,
    totalFastingHours: totalMinutes ~/ 60,
    weeklyHours: weeklyHours,
  );
});

/// DB'den en son kilo
final latestWeightProvider = FutureProvider<double?>((ref) async {
  final db = ref.watch(databaseProvider);
  final metrics = await db.getWeightHistory();
  final withWeight = metrics.where((m) => m.weight != null).toList();
  if (withWeight.isEmpty) return null;
  return withWeight.last.weight;
});

/// Kilo geçmişi verisi
final weightHistoryProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final db = ref.watch(databaseProvider);
  final metrics = await db.getWeightHistory();
  return metrics
      .map((m) => {'date': m.date, 'weight': m.weight})
      .where((m) => m['weight'] != null)
      .toList();
});

/// Aylık heatmap verileri: {DateTime(yıl, ay, gün): oruç saati}
final heatmapProvider = FutureProvider.family<Map<DateTime, double>, DateTime>((
  ref,
  month,
) async {
  final db = ref.watch(databaseProvider);
  final start = DateTime(month.year, month.month, 1);
  final end = DateTime(month.year, month.month + 1, 0, 23, 59, 59);
  final sessions = await db.getSessionsInRange(start, end);

  final Map<DateTime, double> data = {};
  for (final session in sessions) {
    final day = DateTime(
      session.startTime.year,
      session.startTime.month,
      session.startTime.day,
    );
    final hours = (session.actualMinutes ?? 0) / 60.0;
    data[day] = (data[day] ?? 0) + hours;
  }
  return data;
});
