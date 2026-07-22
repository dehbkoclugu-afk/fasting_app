import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/app_colors.dart';
import '../../profile/providers/settings_provider.dart';
import '../providers/gamification_provider.dart';

class GamificationDashboardScreen extends ConsumerWidget {
  const GamificationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gamificationProvider);
    final calm = ref.watch(settingsProvider).calmGamification;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.game_title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _LevelHero(game: game, l10n: l10n),
          const SizedBox(height: 24),
          _SectionTitle(
            title: l10n.game_quests,
            subtitle: l10n.game_questsDesc,
          ),
          const SizedBox(height: 12),
          for (final quest in game.quests) _QuestRow(quest: quest, l10n: l10n),
          const SizedBox(height: 26),
          if (!calm) ...[
            _SectionTitle(
              title: l10n.game_season,
              subtitle: l10n.game_seasonDesc,
            ),
            const SizedBox(height: 14),
            _SeasonPath(current: game.seasonStep),
            const SizedBox(height: 26),
          ],
          _RecordsStrip(game: game, l10n: l10n),
          const SizedBox(height: 26),
          _SectionTitle(
            title: l10n.game_badges,
            subtitle:
                '${game.badges.where((badge) => badge.unlocked).length}/${game.badges.length}',
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .9,
            ),
            itemCount: game.badges.length,
            itemBuilder:
                (context, index) =>
                    _BadgeToken(badge: game.badges[index], l10n: l10n),
          ),
          const SizedBox(height: 26),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: theme.dividerColor),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: AppColors.tertiary,
                  size: 34,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.game_shields(game.shields),
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        l10n.game_shieldsDesc,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          if (!calm)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.game_league, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 6),
                  Text(
                    l10n.game_leagueDesc(game.leaguePercentile),
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _LevelHero extends StatelessWidget {
  const _LevelHero({required this.game, required this.l10n});

  final GamificationState game;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: l10n.game_levelSemantics(game.level, game.xp),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .16),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: .55),
                    ),
                  ),
                  child: Text(
                    '${game.level}',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.game_explorer,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${game.xp} XP',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: .8),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${GamificationState.levelSize - game.levelXp} XP',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 18),
            LinearProgressIndicator(
              value: game.levelProgress,
              minHeight: 9,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.white.withValues(alpha: .2),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 2),
      Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
    ],
  );
}

class _QuestRow extends StatelessWidget {
  const _QuestRow({required this.quest, required this.l10n});
  final GameQuest quest;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(
            quest.completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: quest.completed ? AppColors.success : theme.dividerColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(switch (quest.id) {
                        'rhythm' => l10n.quest_rhythm,
                        'hydrate' => l10n.quest_hydrate,
                        _ => l10n.quest_steady,
                      }, style: theme.textTheme.titleSmall),
                    ),
                    Text(
                      '+${quest.xp} XP',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                LinearProgressIndicator(
                  value: quest.ratio,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeasonPath extends StatelessWidget {
  const _SeasonPath({required this.current});
  final int current;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 74,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 30,
      separatorBuilder:
          (_, __) => Container(
            width: 18,
            height: 2,
            color: Theme.of(context).dividerColor,
          ),
      itemBuilder: (context, index) {
        final step = index + 1;
        final reached = step <= current;
        final milestone = step % 5 == 0;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration:
                  MediaQuery.of(context).disableAnimations
                      ? Duration.zero
                      : const Duration(milliseconds: 220),
              width: milestone ? 44 : 34,
              height: milestone ? 44 : 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    reached
                        ? AppColors.primary
                        : Theme.of(context).dividerColor,
              ),
              child: Text(
                milestone ? '✦' : '$step',
                style: TextStyle(color: reached ? Colors.white : null),
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _RecordsStrip extends StatelessWidget {
  const _RecordsStrip({required this.game, required this.l10n});
  final GamificationState game;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      _Record(value: '${game.streak}', label: l10n.game_streak),
      _Record(value: '${game.completedFasts}', label: l10n.game_targets),
      _Record(value: '${game.totalHours}h', label: l10n.awards_total),
      _Record(
        value: '${game.personalBestMinutes ~/ 60}h',
        label: l10n.game_best,
      ),
    ],
  );
}

class _Record extends StatelessWidget {
  const _Record({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      children: [
        Text(value, style: Theme.of(context).textTheme.titleLarge),
        Text(label, style: Theme.of(context).textTheme.labelSmall),
      ],
    ),
  );
}

class _BadgeToken extends StatelessWidget {
  const _BadgeToken({required this.badge, required this.l10n});
  final GameBadge badge;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: _badgeDescription(l10n, badge.id),
    child: Opacity(
      opacity: badge.unlocked ? 1 : .35,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color:
              badge.unlocked
                  ? AppColors.primary.withValues(alpha: .09)
                  : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_badgeIcon(badge.icon), size: 28, color: AppColors.primary),
            const SizedBox(height: 6),
            Text(
              _badgeTitle(l10n, badge.id),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.labelMedium,
            ),
          ],
        ),
      ),
    ),
  );

  IconData _badgeIcon(String key) => switch (key) {
    'leaf' => PhosphorIcons.leaf(),
    'fire' => PhosphorIcons.fire(PhosphorIconsStyle.fill),
    'water' => PhosphorIcons.drop(PhosphorIconsStyle.fill),
    'compass' => PhosphorIcons.compass(),
    'medal' => PhosphorIcons.medal(PhosphorIconsStyle.fill),
    'target' => PhosphorIcons.target(),
    'clock' => PhosphorIcons.clock(),
    'shield' => PhosphorIcons.shieldCheck(),
    'crown' => PhosphorIcons.crown(PhosphorIconsStyle.fill),
    _ => PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
  };

  String _badgeTitle(AppLocalizations l10n, String id) => switch (id) {
    'first' => l10n.badge_first_title,
    'rhythm7' => l10n.badge_rhythm7_title,
    'rhythm3' => l10n.badge_rhythm3_title,
    'target1' => l10n.badge_target1_title,
    'target3' => l10n.badge_target3_title,
    'water' => l10n.badge_water_title,
    'support' => l10n.badge_support_title,
    'hours10' => l10n.badge_hours10_title,
    'target10' => l10n.badge_target10_title,
    'target20' => l10n.badge_target20_title,
    'fast16' => l10n.badge_fast16_title,
    'hours50' => l10n.badge_hours50_title,
    'hours100' => l10n.badge_hours100_title,
    'target30' => l10n.badge_target30_title,
    _ => l10n.badge_rhythm30_title,
  };

  String _badgeDescription(AppLocalizations l10n, String id) => switch (id) {
    'first' => l10n.badge_first_desc,
    'rhythm7' => l10n.badge_rhythm7_desc,
    'rhythm3' => l10n.badge_rhythm3_desc,
    'target1' => l10n.badge_target1_desc,
    'target3' => l10n.badge_target3_desc,
    'water' => l10n.badge_water_desc,
    'support' => l10n.badge_support_desc,
    'hours10' => l10n.badge_hours10_desc,
    'target10' => l10n.badge_target10_desc,
    'target20' => l10n.badge_target20_desc,
    'fast16' => l10n.badge_fast16_desc,
    'hours50' => l10n.badge_hours50_desc,
    'hours100' => l10n.badge_hours100_desc,
    'target30' => l10n.badge_target30_desc,
    _ => l10n.badge_rhythm30_desc,
  };
}
