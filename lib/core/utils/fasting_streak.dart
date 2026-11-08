import '../../data/database/app_database.dart';

/// The streak every screen shows, and the shields left after it.
///
/// A fast counts for the day it ended, so one that crosses midnight leaves no
/// gap. One shield is earned per seven completed fasts.
(int, int) fastingStreakFor(Iterable<FastingSession> completed, DateTime now) {
  final fasts = completed.toList();
  return shieldedFastingStreak(
    fasts.map((fast) => fast.endTime ?? fast.startTime),
    fasts.length ~/ 7,
    now,
  );
}

(int, int) shieldedFastingStreak(
  Iterable<DateTime> dates,
  int shields,
  DateTime now,
) {
  final days = dates
      .map((date) => DateTime(date.year, date.month, date.day))
      .toSet();
  final today = DateTime(now.year, now.month, now.day);
  var day = days.contains(today)
      ? today
      : DateTime(today.year, today.month, today.day - 1);
  var streak = 0;
  var remaining = shields;
  for (var i = 0; i < 365; i++) {
    if (days.contains(day)) {
      streak++;
    } else if (remaining > 0) {
      remaining--;
    } else {
      break;
    }
    day = DateTime(day.year, day.month, day.day - 1);
  }
  return (streak, remaining);
}

/// A completed day keeps its streak through the following day.
int currentFastingStreak(Iterable<DateTime> completed, DateTime now) {
  final days = completed
      .map((date) => DateTime(date.year, date.month, date.day))
      .toSet();
  final today = DateTime(now.year, now.month, now.day);
  var day = days.contains(today)
      ? today
      : DateTime(today.year, today.month, today.day - 1);
  var streak = 0;
  while (days.contains(day)) {
    streak++;
    day = DateTime(day.year, day.month, day.day - 1);
  }
  return streak;
}
