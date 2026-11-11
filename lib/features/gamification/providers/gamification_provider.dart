import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/utils/fasting_streak.dart';
import '../../timer/providers/fasting_session_provider.dart';
import '../../timer/providers/water_provider.dart';

class GameQuest {
  const GameQuest({
    required this.id,
    required this.progress,
    required this.target,
    required this.xp,
  });

  final String id;
  final int progress;
  final int target;
  final int xp;

  bool get completed => progress >= target;
  double get ratio => target == 0 ? 0 : (progress / target).clamp(0.0, 1.0);
}

class GameBadge {
  const GameBadge({
    required this.id,
    required this.icon,
    required this.unlocked,
    this.progress = 0,
    this.target = 1,
  });

  final String id;
  final String icon;
  final bool unlocked;
  final int progress;
  final int target;

  double get ratio => target <= 0 ? 0 : (progress / target).clamp(0.0, 1.0);
  int get remaining => math.max(0, target - progress);
}

class GamificationState {
  const GamificationState({
    required this.xp,
    required this.level,
    required this.levelXp,
    required this.streak,
    required this.shields,
    required this.completedFasts,
    required this.totalHours,
    required this.personalBestMinutes,
    required this.quests,
    required this.badges,
  });

  final int xp;
  final int level;
  final int levelXp;
  final int streak;
  final int shields;
  final int completedFasts;
  final int totalHours;
  final int personalBestMinutes;
  final List<GameQuest> quests;
  final List<GameBadge> badges;

  static const levelSize = 500;
  double get levelProgress => levelXp / levelSize;

  /// Completed steps in the current 30-step season.
  /// A new account starts at 0/30; progress is never presented as earned
  /// before the user has accumulated the first 250 XP.
  int get seasonStep => math.min(30, xp ~/ 250);
}

/// Adds today's newly finished quests to the banked total. Quest progress
/// resets daily, so anything earned has to be banked or it is lost tomorrow.
///
/// [bank] is null for rewards saved before banking existed: the gap between
/// the old high-water mark and [baseXp] becomes the opening balance, so nobody
/// loses XP or has to earn it twice.
({int bank, Set<String> claimed}) settleQuestXp({
  required int? bank,
  required int xpFloor,
  required int baseXp,
  required Set<String> claimedToday,
  required Iterable<GameQuest> quests,
}) {
  var total = bank ?? math.max(0, xpFloor - baseXp);
  final claimed = {...claimedToday};
  for (final quest in quests) {
    if (quest.completed && claimed.add(quest.id)) total += quest.xp;
  }
  return (bank: total, claimed: claimed);
}

class _RewardLedger {
  const _RewardLedger(
    this.xpFloor,
    this.unlockedBadges, {
    this.questBank,
    this.questDay = '',
    this.claimedQuests = const {},
    this.loaded = false,
  });
  final int xpFloor;
  final Set<String> unlockedBadges;
  final int? questBank;
  final String questDay;
  final Set<String> claimedQuests;

  /// Nothing is awarded until storage has been read: an empty ledger would
  /// claim today's quests a second time.
  final bool loaded;
}

class _RewardLedgerNotifier extends StateNotifier<_RewardLedger> {
  _RewardLedgerNotifier() : super(const _RewardLedger(0, <String>{})) {
    _load();
  }

  Future<void> _load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;
      state = _RewardLedger(
        math.max(state.xpFloor, prefs.getInt('gamification_xp_floor') ?? 0),
        {
          ...state.unlockedBadges,
          ...?prefs.getStringList('gamification_badges'),
        },
        questBank: prefs.getInt('gamification_quest_bank'),
        questDay: prefs.getString('gamification_quest_day') ?? '',
        claimedQuests: {...?prefs.getStringList('gamification_quests_claimed')},
        loaded: true,
      );
    } catch (_) {
      // Continue with the current session's earned rewards if storage fails.
      if (mounted) {
        state = _RewardLedger(state.xpFloor, state.unlockedBadges, loaded: true);
      }
    }
  }

  Future<void> _pending = Future.value();

  void record(
    int xp,
    Iterable<String> badgeIds, {
    required int questBank,
    required String questDay,
    required Set<String> claimedQuests,
  }) {
    if (!mounted) return;
    state = _RewardLedger(
      math.max(xp, state.xpFloor),
      {...state.unlockedBadges, ...badgeIds},
      questBank: questBank,
      questDay: questDay,
      claimedQuests: claimedQuests,
      loaded: true,
    );
    _pending = _pending.catchError((_) {}).then((_) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        if (!mounted) return;
        await prefs.setInt('gamification_xp_floor', state.xpFloor);
        await prefs.setStringList(
          'gamification_badges',
          state.unlockedBadges.toList(),
        );
        await prefs.setInt('gamification_quest_bank', state.questBank ?? 0);
        await prefs.setString('gamification_quest_day', state.questDay);
        await prefs.setStringList(
          'gamification_quests_claimed',
          state.claimedQuests.toList(),
        );
      } catch (_) {
        // Keep the in-memory award; a later award retries the write.
      }
    });
  }
}

final _rewardLedgerProvider =
    StateNotifierProvider<_RewardLedgerNotifier, _RewardLedger>((ref) {
      return _RewardLedgerNotifier();
    });

final supportCountProvider = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('crisis_support_count') ?? 0;
});

/// Drops the in-memory rewards after the user erases their data.
void invalidateGamification(WidgetRef ref) {
  ref
    ..invalidate(_rewardLedgerProvider)
    ..invalidate(supportCountProvider);
}

final gamificationProvider = Provider<GamificationState>((ref) {
  final ledger = ref.watch(_rewardLedgerProvider);
  final sessions = ref.watch(fastingSessionProvider).valueOrNull ?? const [];
  final water = ref.watch(waterProvider);
  final supportCount = ref.watch(supportCountProvider).valueOrNull ?? 0;
  final finalized = sessions
      .where((session) => session.endTime != null)
      .toList();
  final completed = finalized.where((session) => session.completed).toList();
  final recovery = fastingStreakFor(completed, DateTime.now());
  final streak = recovery.$1;
  // Only target-complete fasts award XP, streak, season or badge progress.
  // Early stops remain in history, but are deliberately neutral here.
  final totalRewardedMinutes = completed.fold<int>(
    0,
    (sum, session) =>
        sum + math.min(session.actualMinutes ?? 0, session.targetMinutes),
  );
  final best = completed.fold<int>(
    0,
    (value, session) => math.max(value, session.actualMinutes ?? 0),
  );
  final baseXp =
      completed.length * 100 +
      (totalRewardedMinutes ~/ 60) * 4 +
      math.min(streak, 7) * 15 +
      math.min(supportCount, 5) * 20;
  final today = DateTime.now();
  final todaySessions = completed.where((session) {
    final date = session.startTime;
    return date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;
  }).length;

  final quests = [
    GameQuest(id: 'rhythm', progress: todaySessions, target: 1, xp: 100),
    GameQuest(
      id: 'hydrate',
      progress: water.totalMl,
      target: math.max(1, water.goalMl ~/ 2),
      xp: 50,
    ),
    GameQuest(id: 'steady', progress: streak > 0 ? 1 : 0, target: 1, xp: 75),
  ];
  final questDay = '${today.year}-${today.month}-${today.day}';
  final settled = settleQuestXp(
    bank: ledger.questBank,
    xpFloor: ledger.xpFloor,
    baseXp: baseXp,
    claimedToday: ledger.questDay == questDay ? ledger.claimedQuests : const {},
    quests: quests,
  );
  final calculatedXp = baseXp + settled.bank;
  final xp = math.max(calculatedXp, ledger.xpFloor);
  final level = xp ~/ GamificationState.levelSize + 1;

  final badges = [
    GameBadge(
      id: 'first',
      icon: 'leaf',
      unlocked: completed.isNotEmpty,
      progress: completed.length,
    ),
    GameBadge(
      id: 'rhythm7',
      icon: 'fire',
      unlocked: streak >= 7,
      progress: streak,
      target: 7,
    ),
    GameBadge(
      id: 'rhythm3',
      icon: 'shield',
      unlocked: streak >= 3,
      progress: streak,
      target: 3,
    ),
    GameBadge(
      id: 'target1',
      icon: 'target',
      unlocked: completed.isNotEmpty,
      progress: completed.length,
    ),
    GameBadge(
      id: 'target3',
      icon: 'leaf',
      unlocked: completed.length >= 3,
      progress: completed.length,
      target: 3,
    ),
    GameBadge(
      id: 'water',
      icon: 'water',
      unlocked: water.progress >= 1,
      progress: water.totalMl,
      target: water.goalMl,
    ),
    GameBadge(
      id: 'support',
      icon: 'compass',
      unlocked: supportCount > 0,
      progress: supportCount,
    ),
    GameBadge(
      id: 'hours10',
      icon: 'clock',
      unlocked: totalRewardedMinutes >= 600,
      progress: totalRewardedMinutes,
      target: 600,
    ),
    GameBadge(
      id: 'target10',
      icon: 'medal',
      unlocked: completed.length >= 10,
      progress: completed.length,
      target: 10,
    ),
    GameBadge(
      id: 'target20',
      icon: 'target',
      unlocked: completed.length >= 20,
      progress: completed.length,
      target: 20,
    ),
    GameBadge(
      id: 'fast16',
      icon: 'shield',
      unlocked: best >= 960,
      progress: best,
      target: 960,
    ),
    GameBadge(
      id: 'hours50',
      icon: 'clock',
      unlocked: totalRewardedMinutes >= 3000,
      progress: totalRewardedMinutes,
      target: 3000,
    ),
    GameBadge(
      id: 'hours100',
      icon: 'sparkle',
      unlocked: totalRewardedMinutes >= 6000,
      progress: totalRewardedMinutes,
      target: 6000,
    ),
    GameBadge(
      id: 'target30',
      icon: 'medal',
      unlocked: completed.length >= 30,
      progress: completed.length,
      target: 30,
    ),
    GameBadge(
      id: 'rhythm30',
      icon: 'crown',
      unlocked: streak >= 30,
      progress: streak,
      target: 30,
    ),
  ];

  final unlockedNow = badges
      .where((badge) => badge.unlocked)
      .map((badge) => badge.id)
      .toSet();
  if (ledger.loaded &&
      (calculatedXp > ledger.xpFloor ||
          settled.bank != ledger.questBank ||
          ledger.questDay != questDay ||
          settled.claimed.length != ledger.claimedQuests.length ||
          unlockedNow.difference(ledger.unlockedBadges).isNotEmpty)) {
    final notifier = ref.read(_rewardLedgerProvider.notifier);
    Future.microtask(
      () => notifier.record(
        calculatedXp,
        unlockedNow,
        questBank: settled.bank,
        questDay: questDay,
        claimedQuests: settled.claimed,
      ),
    );
  }

  return GamificationState(
    xp: xp,
    level: level,
    levelXp: xp % GamificationState.levelSize,
    streak: streak,
    shields: recovery.$2,
    completedFasts: completed.length,
    totalHours: totalRewardedMinutes ~/ 60,
    personalBestMinutes: best,
    quests: quests,
    badges: [
      for (final badge in badges)
        GameBadge(
          id: badge.id,
          icon: badge.icon,
          unlocked: badge.unlocked || ledger.unlockedBadges.contains(badge.id),
          progress: badge.progress,
          target: badge.target,
        ),
    ],
  );
});

