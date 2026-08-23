import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
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
    final visibleBadges = (calm
            ? game.badges.where((badge) => badge.unlocked)
            : game.badges)
        .toList()
      ..sort((a, b) {
        if (a.unlocked != b.unlocked) return a.unlocked ? -1 : 1;
        if (!a.unlocked) return b.ratio.compareTo(a.ratio);
        return game.badges.indexOf(a).compareTo(game.badges.indexOf(b));
      });

    return Scaffold(
      appBar: AppBar(title: Text(l10n.game_title)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 48),
        children: [
          _LevelHero(game: game, l10n: l10n, calm: calm),
          const SizedBox(height: 22),
          _QuestPanel(game: game, l10n: l10n, calm: calm),
          const SizedBox(height: 28),
          if (!calm) ...[
            _SectionTitle(
              title: l10n.game_season,
              subtitle: l10n.game_seasonDesc,
            ),
            const SizedBox(height: 14),
            _SeasonPath(current: game.seasonStep),
            const SizedBox(height: 26),
          ],
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
            itemCount: visibleBadges.length,
            itemBuilder:
                (context, index) =>
                    _BadgeToken(badge: visibleBadges[index], l10n: l10n),
          ),
          const SizedBox(height: 26),
          FastingSplitArtCard(
            assetPath: 'assets/images/editorial/v4/rhythm-shield.webp',
            minHeight: 152,
            artWidth: 136,
            borderRadius: 22,
            semanticLabel: l10n.game_shields(game.shields),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: .90),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.game_shields(game.shields),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.game_shieldsDesc,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (!calm)
            FastingSplitArtCard(
              assetPath: 'assets/images/editorial/v4/weekly-league.webp',
              minHeight: 184,
              artWidth: 132,
              borderRadius: 22,
              semanticLabel: l10n.game_league,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(alpha: .90),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.game_league,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.game_leagueDesc(game.leaguePercentile),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _LevelHero extends StatelessWidget {
  const _LevelHero({required this.game, required this.l10n, required this.calm});

  final GamificationState game;
  final AppLocalizations l10n;
  final bool calm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tr = Localizations.localeOf(context).languageCode == 'tr';
    return Semantics(
      label: l10n.game_levelSemantics(game.level, game.xp),
      child: FastingSplitArtCard(
        assetPath: 'assets/images/editorial/v4/weekly-league.webp',
        minHeight: 190,
        artWidth: 122,
        borderRadius: 26,
        semanticLabel: l10n.game_explorer,
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                l10n.game_explorer,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: fastingArtForeground(context),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                calm
                    ? l10n.game_questsDesc
                    : '${tr ? 'Seviye' : 'Level'} ${game.level} • ${game.xp} XP',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: fastingArtMutedForeground(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (!calm) ...[
                const SizedBox(height: 16),
                Text(
                  '${game.levelXp} / ${GamificationState.levelSize} XP',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: fastingArtForeground(context),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                LinearProgressIndicator(
                  value: game.levelProgress,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: fastingArtDivider(context),
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
                const SizedBox(height: 5),
                Text(
                  '${GamificationState.levelSize - game.levelXp} XP ${tr ? 'kaldı' : 'left'}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: fastingArtMutedForeground(context),
                  ),
                ),
              ],
            ],
          ),
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

class _QuestPanel extends StatelessWidget {
  const _QuestPanel({required this.game, required this.l10n, required this.calm});

  final GamificationState game;
  final AppLocalizations l10n;
  final bool calm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completed = game.quests.where((quest) => quest.completed).length;
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.game_quests,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(l10n.game_questsDesc, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '$completed/${game.quests.length}',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          for (final quest in game.quests)
            _QuestRow(quest: quest, l10n: l10n, calm: calm),
        ],
      ),
    );
  }
}

class _QuestRow extends StatelessWidget {
  const _QuestRow({required this.quest, required this.l10n, required this.calm});
  final GameQuest quest;
  final AppLocalizations l10n;
  final bool calm;

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
                    if (!calm)
                      Text(
                        '+${quest.xp} XP',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
                if (!calm) ...[
                  const SizedBox(height: 6),
                  LinearProgressIndicator(
                    value: quest.ratio,
                    minHeight: 5,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nextReward = current >= 30 ? 30 : ((current ~/ 5) + 1) * 5;
    final remaining = (nextReward - current).clamp(0, 30);
    final isTurkish = Localizations.localeOf(context).languageCode == 'tr';
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: .5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('$current / 30', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
              const Spacer(),
              Text(
                current >= 30
                    ? (isTurkish ? 'Sezon tamamlandı' : 'Season complete')
                    : (isTurkish ? 'Mühre $remaining adım' : '$remaining steps to seal'),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              const gap = 7.0;
              final nodeSize = (constraints.maxWidth - gap * 9) / 10;
              return Wrap(
                spacing: gap,
                runSpacing: 10,
                children: List.generate(30, (index) {
                  final step = index + 1;
                  final complete = step <= current;
                  final reward = step % 5 == 0;
                  return SizedBox.square(
                    dimension: nodeSize,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: complete
                            ? AppColors.primary
                            : theme.colorScheme.surfaceContainerHighest,
                        border: Border.all(
                          color: reward
                              ? AppColors.primary
                              : theme.colorScheme.outlineVariant,
                          width: reward ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: reward
                            ? Icon(
                                complete ? Icons.check_rounded : Icons.star_outline_rounded,
                                size: nodeSize * .55,
                                color: complete ? Colors.white : AppColors.primary,
                              )
                            : Text(
                                '$step',
                                style: TextStyle(
                                  fontSize: nodeSize * .34,
                                  fontWeight: FontWeight.w700,
                                  color: complete
                                      ? Colors.white
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _BadgeToken extends StatelessWidget {
  const _BadgeToken({required this.badge, required this.l10n});
  final GameBadge badge;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final labelColor = isDark ? Colors.white : theme.colorScheme.onSurface;
    return Tooltip(
      message: _badgeDescription(l10n, badge.id),
      child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _showBadgeDetails(context),
      child: LayoutBuilder(
      builder: (context, constraints) => Opacity(
        opacity: badge.unlocked ? 1 : .82,
        child: FastingArtSlot(
          assetPath: _badgeArtwork(badge.id),
          height: constraints.maxHeight,
          borderRadius: 18,
          variant: FastingArtVariant.bare,
          fit: BoxFit.contain,
          semanticLabel: _badgeTitle(l10n, badge.id),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  theme.colorScheme.surface.withValues(alpha: .10),
                  theme.colorScheme.surface.withValues(alpha: .78),
                ],
                stops: const [0, .48, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(
                color: badge.unlocked
                    ? AppColors.primary.withValues(alpha: .55)
                    : theme.colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(badge.unlocked ? Icons.check_circle : Icons.lock_outline, size: 16, color: labelColor.withValues(alpha: .9)),
                  ),
                  const Spacer(),
                  Text(
                    _badgeTitle(l10n, badge.id),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(color: labelColor, fontWeight: FontWeight.w800, height: 1.1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      )),
    );
  }

  Future<void> _showBadgeDetails(BuildContext context) => showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    builder: (sheetContext) {
      final theme = Theme.of(sheetContext);
      final title = _badgeTitle(l10n, badge.id);
      final description = _badgeDescription(l10n, badge.id);
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Expanded(child: Text(title, style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900))),
              IconButton(onPressed: () => Navigator.pop(sheetContext), icon: const Icon(Icons.close_rounded)),
            ]),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(22)),
              child: FastingArtSlot(
                assetPath: _badgeArtwork(badge.id),
                height: 210,
                borderRadius: 22,
                variant: FastingArtVariant.bare,
                fit: BoxFit.contain,
                child: const SizedBox.shrink(),
              ),
            ),
            const SizedBox(height: 18),
            Text(description, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            LinearProgressIndicator(value: badge.ratio, minHeight: 9, borderRadius: BorderRadius.circular(99)),
            const SizedBox(height: 8),
            Text(badge.unlocked ? l10n.timer_completed : _progressLabel(badge), style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pop(sheetContext), child: Text(l10n.common_ok))),
          ]),
        ),
      );
    },
  );

  String _progressLabel(GameBadge badge) {
    if (badge.id.startsWith('hours')) {
      final currentHours = badge.progress / 60;
      final targetHours = badge.target / 60;
      final current = currentHours == currentHours.roundToDouble()
          ? currentHours.round().toString()
          : currentHours.toStringAsFixed(1);
      final unit = l10n.localeName == 'tr' ? 'saat' : 'hours';
      return '$current / ${targetHours.round()} $unit';
    }
    return '${badge.progress} / ${badge.target}';
  }

  String _badgeArtwork(String id) {
    return switch (id) {
      'first' => 'assets/images/editorial/v3/badge-first.webp',
      'rhythm3' => 'assets/images/editorial/v3/badge-rhythm3.webp',
      'rhythm7' => 'assets/images/editorial/v3/badge-rhythm7.webp',
      'target1' => 'assets/images/editorial/v3/badge-target1.webp',
      'target3' => 'assets/images/editorial/v3/badge-target3.webp',
      'water' => 'assets/images/editorial/v3/badge-water.webp',
      'support' => 'assets/images/editorial/v3/badge-support.webp',
      'hours10' => 'assets/images/editorial/v3/badge-hours10.webp',
      'target10' => 'assets/images/editorial/v3/badge-target10.webp',
      'target20' => 'assets/images/editorial/v3/badge-target20.webp',
      'fast16' => 'assets/images/editorial/v3/badge-fast16.webp',
      'hours50' => 'assets/images/editorial/v3/badge-hours50.webp',
      'hours100' => 'assets/images/editorial/v3/badge-hours100.webp',
      'target30' => 'assets/images/editorial/v3/badge-target30.webp',
      _ => 'assets/images/editorial/v3/badge-rhythm30.webp',
    };
  }

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
