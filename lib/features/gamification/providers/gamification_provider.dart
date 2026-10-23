import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  int get leaguePercentile => math.min(95, 35 + level * 4 + streak * 2);
}

class _RewardLedger {
  const _RewardLedger(this.xpFloor, this.unlockedBadges);
  final int xpFloor;
  final Set<String> unlockedBadges;
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
      );
    } catch (_) {
      // Continue with the current session's earned rewards if storage fails.
    }
  }

  Future<void> _pending = Future.value();

  void record(int xp, Iterable<String> badgeIds) {
    if (!mounted) return;
    final badges = {...state.unlockedBadges, ...badgeIds};
    if (xp <= state.xpFloor && badges.length == state.unlockedBadges.length)
      return;
    state = _RewardLedger(math.max(xp, state.xpFloor), badges);
    _pending = _pending.catchError((_) {}).then((_) async {
      try {
        final prefs = await SharedPreferences.getInstance();
        if (!mounted) return;
        await prefs.setInt('gamification_xp_floor', state.xpFloor);
        await prefs.setStringList(
          'gamification_badges',
          state.unlockedBadges.toList(),
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

final _supportCountProvider = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('crisis_support_count') ?? 0;
});

final gamificationProvider = Provider<GamificationState>((ref) {
  final ledger = ref.watch(_rewardLedgerProvider);
  final sessions = ref.watch(fastingSessionProvider).valueOrNull ?? const [];
  final water = ref.watch(waterProvider);
  final rawStreak = ref.watch(streakProvider);
  final supportCount = ref.watch(_supportCountProvider).valueOrNull ?? 0;
  final finalized = sessions
      .where((session) => session.endTime != null)
      .toList();
  final completed = finalized.where((session) => session.completed).toList();
  final recovery = _shieldedStreak(
    completed.map((session) => session.startTime),
    completed.length ~/ 7,
  );
  final streak = math.max(rawStreak, recovery.$1);
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
  final hydrationXp = (water.progress * 50).round().clamp(0, 50);
  final baseXp =
      completed.length * 100 +
      (totalRewardedMinutes ~/ 60) * 4 +
      math.min(streak, 7) * 15 +
      hydrationXp +
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
  final questXp = quests
      .where((quest) => quest.completed)
      .fold<int>(0, (sum, quest) => sum + quest.xp);
  final calculatedXp = baseXp + questXp;
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
  if (calculatedXp > ledger.xpFloor ||
      unlockedNow.difference(ledger.unlockedBadges).isNotEmpty) {
    final notifier = ref.read(_rewardLedgerProvider.notifier);
    Future.microtask(() => notifier.record(calculatedXp, unlockedNow));
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

(int, int) _shieldedStreak(Iterable<DateTime> dates, int shields) {
  final dayKeys = dates
      .map((date) => '${date.year}-${date.month}-${date.day}')
      .toSet();
  final today = DateTime.now();
  var expected = DateTime(today.year, today.month, today.day);
  if (!dayKeys.contains('${today.year}-${today.month}-${today.day}')) {
    expected = DateTime(today.year, today.month, today.day - 1);
  }
  var streak = 0;
  var remaining = shields;
  for (var day = 0; day < 365; day++) {
    final key = '${expected.year}-${expected.month}-${expected.day}';
    if (dayKeys.contains(key)) {
      streak++;
    } else if (remaining > 0) {
      remaining--;
    } else {
      break;
    }
    expected = DateTime(expected.year, expected.month, expected.day - 1);
  }
  return (streak, remaining);
}
