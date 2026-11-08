import 'package:fasting_app/features/gamification/providers/gamification_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const done = GameQuest(id: 'rhythm', progress: 1, target: 1, xp: 100);
  const water = GameQuest(id: 'hydrate', progress: 1, target: 1, xp: 50);
  const open = GameQuest(id: 'steady', progress: 0, target: 1, xp: 75);

  test('quest XP earned today is still there tomorrow', () {
    final today = settleQuestXp(
      bank: 0,
      xpFloor: 0,
      baseXp: 300,
      claimedToday: const {},
      quests: const [done, open],
    );
    expect(today.bank, 100);

    final tomorrow = settleQuestXp(
      bank: today.bank,
      xpFloor: 400,
      baseXp: 300,
      claimedToday: const {},
      quests: const [water, open],
    );
    expect(tomorrow.bank, 150);
    expect(300 + tomorrow.bank, greaterThan(400));
  });

  test('a quest pays once a day however often state rebuilds', () {
    final first = settleQuestXp(
      bank: 10,
      xpFloor: 0,
      baseXp: 0,
      claimedToday: const {},
      quests: const [done],
    );
    final again = settleQuestXp(
      bank: first.bank,
      xpFloor: 0,
      baseXp: 0,
      claimedToday: first.claimed,
      quests: const [done],
    );
    expect(again.bank, first.bank);
  });

  test('rewards saved before banking become the opening balance', () {
    final migrated = settleQuestXp(
      bank: null,
      xpFloor: 454,
      baseXp: 354,
      claimedToday: const {},
      quests: const [open],
    );
    expect(migrated.bank, 100);
    expect(354 + migrated.bank, 454);
  });
}
