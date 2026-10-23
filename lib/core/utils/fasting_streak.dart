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
