import 'package:fasting_app/core/utils/fasting_streak.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('yesterday keeps the streak until today ends', () {
    final now = DateTime(2026, 9, 29, 12);
    expect(
      currentFastingStreak([
        DateTime(2026, 9, 28, 15),
        DateTime(2026, 9, 28, 18),
        DateTime(2026, 9, 27),
      ], now),
      2,
    );
    expect(currentFastingStreak([DateTime(2026, 9, 27)], now), 0);
  });

  test('today and yesterday count once each', () {
    expect(
      currentFastingStreak([
        DateTime(2026, 9, 29, 8),
        DateTime(2026, 9, 29, 16),
        DateTime(2026, 9, 28),
      ], DateTime(2026, 9, 29)),
      2,
    );
  });
}
