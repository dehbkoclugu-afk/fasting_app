import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../timer/providers/fasting_session_provider.dart';

enum _Metric { fasts, streak, hours }

enum _JourneyStage { start, rhythm, endurance, mastery }

class _Achievement {
  const _Achievement({
    required this.icon,
    required this.id,
    required this.metric,
    required this.target,
    required this.stage,
  });

  final IconData icon;
  final String id;
  final _Metric metric;
  final int target;
  final _JourneyStage stage;

  int value(int fasts, int streak, int hours) => switch (metric) {
    _Metric.fasts => fasts,
    _Metric.streak => streak,
    _Metric.hours => hours,
  };

  double progress(int fasts, int streak, int hours) =>
      (value(fasts, streak, hours) / target).clamp(0, 1);

  String title(AppLocalizations l10n) => switch (id) {
    'first' => l10n.award_first_title,
    'rhythm3' => l10n.award_rhythm3_title,
    'hours24' => l10n.award_hours24_title,
    'week' => l10n.award_week_title,
    'fasts10' => l10n.award_fasts10_title,
    'hours100' => l10n.award_hours100_title,
    'rhythm30' => l10n.award_rhythm30_title,
    'fasts50' => l10n.award_fasts50_title,
    'hours500' => l10n.award_hours500_title,
    'fasts100' => l10n.award_fasts100_title,
    'rhythm90' => l10n.award_rhythm90_title,
    _ => l10n.award_year_title,
  };

  String description(AppLocalizations l10n) => switch (id) {
    'first' => l10n.award_first_desc,
    'rhythm3' => l10n.award_rhythm3_desc,
    'hours24' => l10n.award_hours24_desc,
    'week' => l10n.award_week_desc,
    'fasts10' => l10n.award_fasts10_desc,
    'hours100' => l10n.award_hours100_desc,
    'rhythm30' => l10n.award_rhythm30_desc,
    'fasts50' => l10n.award_fasts50_desc,
    'hours500' => l10n.award_hours500_desc,
    'fasts100' => l10n.award_fasts100_desc,
    'rhythm90' => l10n.award_rhythm90_desc,
    _ => l10n.award_year_desc,
  };
}

final _achievements = [
  _Achievement(
    icon: PhosphorIcons.leaf(),
    id: 'first',
    metric: _Metric.fasts,
    target: 1,
    stage: _JourneyStage.start,
  ),
  _Achievement(
    icon: PhosphorIcons.fire(),
    id: 'rhythm3',
    metric: _Metric.streak,
    target: 3,
    stage: _JourneyStage.start,
  ),
  _Achievement(
    icon: PhosphorIcons.timer(),
    id: 'hours24',
    metric: _Metric.hours,
    target: 24,
    stage: _JourneyStage.start,
  ),
  _Achievement(
    icon: PhosphorIcons.star(),
    id: 'week',
    metric: _Metric.streak,
    target: 7,
    stage: _JourneyStage.rhythm,
  ),
  _Achievement(
    icon: PhosphorIcons.checkCircle(),
    id: 'fasts10',
    metric: _Metric.fasts,
    target: 10,
    stage: _JourneyStage.rhythm,
  ),
  _Achievement(
    icon: PhosphorIcons.dna(),
    id: 'hours100',
    metric: _Metric.hours,
    target: 100,
    stage: _JourneyStage.rhythm,
  ),
  _Achievement(
    icon: PhosphorIcons.trophy(),
    id: 'rhythm30',
    metric: _Metric.streak,
    target: 30,
    stage: _JourneyStage.endurance,
  ),
  _Achievement(
    icon: PhosphorIcons.diamond(),
    id: 'fasts50',
    metric: _Metric.fasts,
    target: 50,
    stage: _JourneyStage.endurance,
  ),
  _Achievement(
    icon: PhosphorIcons.crown(),
    id: 'hours500',
    metric: _Metric.hours,
    target: 500,
    stage: _JourneyStage.endurance,
  ),
  _Achievement(
    icon: PhosphorIcons.sparkle(),
    id: 'fasts100',
    metric: _Metric.fasts,
    target: 100,
    stage: _JourneyStage.mastery,
  ),
  _Achievement(
    icon: PhosphorIcons.shieldStar(),
    id: 'rhythm90',
    metric: _Metric.streak,
    target: 90,
    stage: _JourneyStage.mastery,
  ),
  _Achievement(
    icon: PhosphorIcons.medal(),
    id: 'year',
    metric: _Metric.streak,
    target: 365,
    stage: _JourneyStage.mastery,
  ),
];

class AchievementsScreen extends ConsumerWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final sessionsAsync = ref.watch(fastingSessionProvider);
    final streak = ref.watch(streakProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.tab_achievements)),
      body: sessionsAsync.when(
        loading: () => const _AchievementsLoading(),
        error:
            (error, _) => _AchievementsError(
              message: l10n.awards_loadError,
              onRetry: () => ref.invalidate(fastingSessionProvider),
            ),
        data: (sessions) {
          final totalFasts =
              sessions.where((session) => session.completed).length;
          final totalHours =
              sessions
                  .where((session) => session.completed)
                  .fold<int>(
                    0,
                    (sum, session) => sum + (session.actualMinutes ?? 0),
                  ) ~/
              60;
          return _Journey(
            totalFasts: totalFasts,
            streak: streak,
            totalHours: totalHours,
          );
        },
      ),
    );
  }
}

class _Journey extends StatelessWidget {
  const _Journey({
    required this.totalFasts,
    required this.streak,
    required this.totalHours,
  });

  final int totalFasts;
  final int streak;
  final int totalHours;

  @override
  Widget build(BuildContext context) {
    final next = _achievements.cast<_Achievement?>().firstWhere(
      (achievement) =>
          achievement!.progress(totalFasts, streak, totalHours) < 1,
      orElse: () => null,
    );
    final unlocked =
        _achievements
            .where(
              (achievement) =>
                  achievement.progress(totalFasts, streak, totalHours) >= 1,
            )
            .length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        _NextGoal(
          achievement: next,
          unlocked: unlocked,
          totalFasts: totalFasts,
          streak: streak,
          totalHours: totalHours,
        ),
        const SizedBox(height: 18),
        _LifetimeSummary(
          totalFasts: totalFasts,
          streak: streak,
          totalHours: totalHours,
        ),
        const SizedBox(height: 28),
        for (final stage in _JourneyStage.values) ...[
          _StageSection(
            stage: stage,
            achievements: _achievements.where(
              (achievement) => achievement.stage == stage,
            ),
            totalFasts: totalFasts,
            streak: streak,
            totalHours: totalHours,
          ),
          const SizedBox(height: 24),
        ],
      ],
    );
  }
}

class _NextGoal extends StatelessWidget {
  const _NextGoal({
    required this.achievement,
    required this.unlocked,
    required this.totalFasts,
    required this.streak,
    required this.totalHours,
  });

  final _Achievement? achievement;
  final int unlocked;
  final int totalFasts;
  final int streak;
  final int totalHours;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final progress =
        achievement?.progress(totalFasts, streak, totalHours) ?? 1.0;
    final current =
        achievement?.value(totalFasts, streak, totalHours) ?? unlocked;
    final target = achievement?.target ?? _achievements.length;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .09),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .11),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  achievement?.icon ?? PhosphorIcons.checkCircle(),
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      achievement == null
                          ? l10n.awards_journeyComplete
                          : l10n.awards_nextGoal,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement == null
                          ? l10n.awards_allYours
                          : achievement!.title(l10n),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      achievement == null
                          ? '$unlocked/${_achievements.length}'
                          : _remaining(
                            achievement!,
                            totalFasts,
                            streak,
                            totalHours,
                            l10n,
                          ),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _JourneyMeter(
            progress: progress,
            current: current,
            target: target,
            color: achievement == null ? AppColors.success : AppColors.primary,
          ),
        ],
      ),
    );
  }
}

class _LifetimeSummary extends StatelessWidget {
  const _LifetimeSummary({
    required this.totalFasts,
    required this.streak,
    required this.totalHours,
  });

  final int totalFasts;
  final int streak;
  final int totalHours;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        _SummaryItem(value: '$streak', label: l10n.awards_dayStreak),
        const _SummaryDivider(),
        _SummaryItem(value: '$totalFasts', label: l10n.awards_fasts),
        const _SummaryDivider(),
        _SummaryItem(value: '${totalHours}h', label: l10n.awards_total),
      ],
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SummaryDivider extends StatelessWidget {
  const _SummaryDivider();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 32,
    child: VerticalDivider(color: Theme.of(context).colorScheme.outlineVariant),
  );
}

class _StageSection extends StatelessWidget {
  const _StageSection({
    required this.stage,
    required this.achievements,
    required this.totalFasts,
    required this.streak,
    required this.totalHours,
  });

  final _JourneyStage stage;
  final Iterable<_Achievement> achievements;
  final int totalFasts;
  final int streak;
  final int totalHours;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = achievements.toList();
    final title = switch (stage) {
      _JourneyStage.start => l10n.awards_stageStart,
      _JourneyStage.rhythm => l10n.awards_stageRhythm,
      _JourneyStage.endurance => l10n.awards_stageEndurance,
      _JourneyStage.mastery => l10n.awards_stageMastery,
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          child: Column(
            children: [
              for (var index = 0; index < items.length; index++) ...[
                _AchievementRow(
                  achievement: items[index],
                  totalFasts: totalFasts,
                  streak: streak,
                  totalHours: totalHours,
                ),
                if (index < items.length - 1)
                  const Divider(height: 1, indent: 72),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementRow extends StatelessWidget {
  const _AchievementRow({
    required this.achievement,
    required this.totalFasts,
    required this.streak,
    required this.totalHours,
  });

  final _Achievement achievement;
  final int totalFasts;
  final int streak;
  final int totalHours;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final progress = achievement.progress(totalFasts, streak, totalHours);
    final unlocked = progress >= 1;
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color:
                  unlocked
                      ? AppColors.primary.withValues(alpha: .1)
                      : theme.colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              achievement.icon,
              color:
                  unlocked
                      ? AppColors.primary
                      : theme.colorScheme.onSurface.withValues(alpha: .45),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        achievement.title(AppLocalizations.of(context)!),
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Text(
                      '${achievement.value(totalFasts, streak, totalHours).clamp(0, achievement.target)}/${achievement.target}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color:
                            unlocked
                                ? AppColors.success
                                : theme.colorScheme.onSurface.withValues(
                                  alpha: .55,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  unlocked
                      ? l10n.awards_completed
                      : _remaining(
                        achievement,
                        totalFasts,
                        streak,
                        totalHours,
                        l10n,
                      ),
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                _JourneyMeter(
                  progress: progress,
                  current: achievement
                      .value(totalFasts, streak, totalHours)
                      .clamp(0, achievement.target),
                  target: achievement.target,
                  color: unlocked ? AppColors.success : AppColors.primary,
                  showValue: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JourneyMeter extends StatelessWidget {
  const _JourneyMeter({
    required this.progress,
    required this.current,
    required this.target,
    required this.color,
    this.showValue = true,
  });

  final double progress;
  final int current;
  final int target;
  final Color color;
  final bool showValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (showValue) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).round()}%',
                style: theme.textTheme.labelSmall?.copyWith(color: color),
              ),
              Text('$current / $target', style: theme.textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: 7),
        ],
        TweenAnimationBuilder<double>(
          tween: Tween(end: progress.clamp(0, 1)),
          duration:
              reduceMotion ? Duration.zero : const Duration(milliseconds: 420),
          curve: Curves.easeOutCubic,
          builder:
              (context, value, _) => LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final dotLeft = (width * value - 5).clamp(0.0, width - 10);
                  return SizedBox(
                    height: 10,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          top: 2,
                          bottom: 2,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainer,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 2,
                          bottom: 2,
                          width: width * value,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                        Positioned(
                          left: dotLeft,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color,
                              border: Border.all(
                                color: theme.colorScheme.surface,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}

String _remaining(
  _Achievement achievement,
  int fasts,
  int streak,
  int hours,
  AppLocalizations l10n,
) {
  final remaining = (achievement.target -
          achievement.value(fasts, streak, hours))
      .clamp(0, achievement.target);
  return switch (achievement.metric) {
    _Metric.fasts => l10n.awards_fastsRemaining(remaining),
    _Metric.streak => l10n.awards_daysRemaining(remaining),
    _Metric.hours => l10n.awards_hoursRemaining(remaining),
  };
}

class _AchievementsLoading extends StatelessWidget {
  const _AchievementsLoading();

  @override
  Widget build(BuildContext context) => const Center(
    child: SizedBox.square(
      dimension: 32,
      child: CircularProgressIndicator(strokeWidth: 3),
    ),
  );
}

class _AchievementsError extends StatelessWidget {
  const _AchievementsError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIcons.warningCircle(),
            color: Theme.of(context).colorScheme.error,
            size: 36,
          ),
          const SizedBox(height: 12),
          Text(message),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onRetry,
            child: Text(AppLocalizations.of(context)!.common_retry),
          ),
        ],
      ),
    ),
  );
}
