import 'package:fasting_app/features/gamification/providers/gamification_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  GamificationState state(int xp) => GamificationState(
    xp: xp,
    level: 1,
    levelXp: xp,
    streak: 0,
    shields: 0,
    completedFasts: 0,
    totalHours: 0,
    personalBestMinutes: 0,
    quests: const [],
    badges: const [],
  );

  test('30-step season starts at zero and advances every 250 XP', () {
    expect(state(0).seasonStep, 0);
    expect(state(249).seasonStep, 0);
    expect(state(250).seasonStep, 1);
    expect(state(500).seasonStep, 2);
  });

  test('30-step season is capped at thirty', () {
    expect(state(7500).seasonStep, 30);
    expect(state(50000).seasonStep, 30);
  });
}
