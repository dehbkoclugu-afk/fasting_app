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
  double get ratio => target == 0 ? 0 : (progress / target).clamp(0, 1);
}

class GameBadge {
  const GameBadge({
    required this.id,
    required this.icon,
    required this.unlocked,
  });

  final String id;
  final String icon;
  final bool unlocked;
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
  int get seasonStep => math.min(30, xp ~/ 250 + 1);
  int get leaguePercentile => math.min(95, 35 + level * 4 + streak * 2);
}

final _supportCountProvider = FutureProvider<int>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('crisis_support_count') ?? 0;
});

final gamificationProvider = Provider<GamificationState>((ref) {
  final sessions = ref.watch(fastingSessionProvider).valueOrNull ?? const [];
  final water = ref.watch(waterProvider);
  final rawStreak = ref.watch(streakProvider);
  final supportCount = ref.watch(_supportCountProvider).valueOrNull ?? 0;
  final finalized =
      sessions.where((session) => session.endTime != null).toList();
  final completed = finalized.where((session) => session.completed).toList();
  final recovery = _shieldedStreak(
    completed.map((session) => session.startTime),
    completed.length ~/ 7,
  );
  final streak = math.max(rawStreak, recovery.$1);
  final totalRewardedMinutes = finalized.fold<int>(
    0,
    (sum, session) =>
        sum + math.min(session.actualMinutes ?? 0, session.targetMinutes),
  );
  final best = finalized.fold<int>(
    0,
    (value, session) => math.max(value, session.actualMinutes ?? 0),
  );
  final hydrationXp = (water.progress * 50).round().clamp(0, 50);
  final baseXp =
      finalized.length * 40 +
      completed.length * 60 +
      (totalRewardedMinutes ~/ 60) * 4 +
      math.min(streak, 7) * 15 +
      hydrationXp +
      math.min(supportCount, 5) * 20;
  final today = DateTime.now();
  final todaySessions =
      finalized.where((session) {
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
  final xp = baseXp + questXp;
  final level = xp ~/ GamificationState.levelSize + 1;

  final badges = [
    GameBadge(id: 'first', icon: 'leaf', unlocked: finalized.isNotEmpty),
    GameBadge(id: 'rhythm7', icon: 'fire', unlocked: streak >= 7),
    GameBadge(id: 'rhythm3', icon: 'shield', unlocked: streak >= 3),
    GameBadge(id: 'target1', icon: 'target', unlocked: completed.isNotEmpty),
    GameBadge(id: 'target3', icon: 'leaf', unlocked: completed.length >= 3),
    GameBadge(id: 'water', icon: 'water', unlocked: water.progress >= 1),
    GameBadge(id: 'support', icon: 'compass', unlocked: supportCount > 0),
    GameBadge(
      id: 'hours10',
      icon: 'clock',
      unlocked: totalRewardedMinutes >= 600,
    ),
    GameBadge(id: 'target10', icon: 'medal', unlocked: completed.length >= 10),
    GameBadge(id: 'target20', icon: 'target', unlocked: completed.length >= 20),
    GameBadge(id: 'fast16', icon: 'shield', unlocked: best >= 960),
    GameBadge(
      id: 'hours50',
      icon: 'clock',
      unlocked: totalRewardedMinutes >= 3000,
    ),
    GameBadge(
      id: 'hours100',
      icon: 'sparkle',
      unlocked: totalRewardedMinutes >= 6000,
    ),
    GameBadge(id: 'target30', icon: 'medal', unlocked: completed.length >= 30),
    GameBadge(id: 'rhythm30', icon: 'crown', unlocked: streak >= 30),
  ];

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
    badges: badges,
  );
});

(int, int) _shieldedStreak(Iterable<DateTime> dates, int shields) {
  final dayKeys =
      dates.map((date) => '${date.year}-${date.month}-${date.day}').toSet();
  var expected = DateTime.now();
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
    expected = expected.subtract(const Duration(days: 1));
  }
  return (streak, remaining);
}
