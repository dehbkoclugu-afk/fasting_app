import 'package:fasting_app/core/utils/fasting_streak.dart';
import 'package:fasting_app/data/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

FastingSession _fast(DateTime start, DateTime end) => FastingSession(
  id: start.millisecondsSinceEpoch,
  planType: '16_8',
  startTime: start,
  endTime: end,
  targetMinutes: 960,
  actualMinutes: 960,
  completed: true,
  createdAt: start,
);

void main() {
  test('a fast crossing midnight leaves no gap in the streak', () {
    final fasts = [
      _fast(DateTime(2026, 9, 28, 23, 50), DateTime(2026, 9, 29, 15, 50)),
      _fast(DateTime(2026, 9, 30, 0, 10), DateTime(2026, 9, 30, 16, 10)),
    ];

    expect(fastingStreakFor(fasts, DateTime(2026, 9, 30, 20)).$1, 2);
  });

  test('a shield bridges one missed day', () {
    final fasts = [
      for (var day = 1; day <= 6; day++)
        _fast(DateTime(2026, 9, day, 6), DateTime(2026, 9, day, 22)),
      _fast(DateTime(2026, 9, 8, 6), DateTime(2026, 9, 8, 22)),
    ];

    final (streak, shieldsLeft) = fastingStreakFor(
      fasts,
      DateTime(2026, 9, 8, 23),
    );

    expect(streak, 7);
    expect(shieldsLeft, 0);
  });

  test('no shield, no bridge', () {
    final fasts = [
      _fast(DateTime(2026, 9, 6, 6), DateTime(2026, 9, 6, 22)),
      _fast(DateTime(2026, 9, 8, 6), DateTime(2026, 9, 8, 22)),
    ];

    expect(fastingStreakFor(fasts, DateTime(2026, 9, 8, 23)).$1, 1);
  });
}
