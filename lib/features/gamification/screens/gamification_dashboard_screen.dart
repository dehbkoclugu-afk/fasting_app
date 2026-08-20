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
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          _LevelHero(game: game, l10n: l10n, calm: calm),
          const SizedBox(height: 38),
          _SectionTitle(
            title: l10n.game_quests,
            subtitle: l10n.game_questsDesc,
          ),
          const SizedBox(height: 12),
          for (final quest in game.quests)
            _QuestRow(quest: quest, l10n: l10n, calm: calm),
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
          if (!calm) ...[
            _NextSealCard(game: game, l10n: l10n),
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
          FastingArtSlot(
            assetPath: 'assets/images/editorial/v4/rhythm-shield.webp',
            height: 132,
            borderRadius: 22,
            variant: FastingArtVariant.row,
            alignment: Alignment.centerRight,
            semanticLabel: l10n.game_shields(game.shields),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 18, 190, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.game_shields(game.shields),
                    style: theme.textTheme.titleMedium?.copyWith(color: fastingArtForeground(context), fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n.game_shieldsDesc,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: fastingArtMutedForeground(context)),
                  ),
                ],
                ),
              ),
          ),
          const SizedBox(height: 14),
          if (!calm)
            FastingArtSlot(
              assetPath: 'assets/images/editorial/v4/weekly-league.webp',
              height: 148,
              borderRadius: 22,
              variant: FastingArtVariant.row,
              alignment: Alignment.centerRight,
              semanticLabel: l10n.game_league,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 128, 18),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.game_league, style: theme.textTheme.titleMedium?.copyWith(color: fastingArtForeground(context), fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text(
                    l10n.game_leagueDesc(game.leaguePercentile),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(color: fastingArtMutedForeground(context)),
                  ),
                ],
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
    return Semantics(
      label: l10n.game_levelSemantics(game.level, game.xp),
      child: FastingArtSlot(
        assetPath: 'assets/images/editorial/v4/weekly-league.webp',
        height: 174,
        borderRadius: 26,
        variant: FastingArtVariant.hero,
        child: Padding(
          padding: const EdgeInsets.all(22),
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
                        l10n.game_explorer,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: fastingArtForeground(context),
                        ),
                      ),
                      Text(
                        calm ? l10n.game_questsDesc : '${game.level}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: fastingArtMutedForeground(context),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!calm)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${game.levelXp} / ${GamificationState.levelSize} XP', style: TextStyle(color: fastingArtForeground(context), fontWeight: FontWeight.w800)),
                      Text('${GamificationState.levelSize - game.levelXp} XP', style: theme.textTheme.labelSmall?.copyWith(color: fastingArtMutedForeground(context))),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 18),
            if (!calm)
              LinearProgressIndicator(
                value: game.levelProgress,
                minHeight: 9,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: fastingArtForeground(context).withValues(alpha: .12),
                valueColor: AlwaysStoppedAnimation(fastingArtForeground(context)),
              ),
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
    return FastingArtSlot(
      assetPath: 'assets/images/editorial/v3/season-path.webp',
      height: 190,
      borderRadius: 24,
      variant: FastingArtVariant.hero,
      alignment: Alignment.center,
      child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text('$current / 30', style: theme.textTheme.titleMedium?.copyWith(color: fastingArtForeground(context), fontWeight: FontWeight.w900)),
          ]),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: current / 30,
              minHeight: 9,
              backgroundColor: fastingArtForeground(context).withValues(alpha: .18),
            ),
          ),
          const SizedBox(height: 7),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [5, 10, 15, 20, 25, 30].map((step) => Text('$step', style: theme.textTheme.labelSmall?.copyWith(color: fastingArtMutedForeground(context), fontWeight: step <= current ? FontWeight.w900 : FontWeight.w500))).toList()),
        ],
      )),
    );
  }
}

class _NextSealCard extends StatelessWidget {
  const _NextSealCard({required this.game, required this.l10n});
  final GamificationState game;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedInBlock = (game.seasonStep - 1) % 5;
    final remaining = 5 - completedInBlock;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: theme.colorScheme.primaryContainer.withValues(alpha: .38), borderRadius: BorderRadius.circular(20)),
      child: Row(children: [
        Icon(Icons.workspace_premium_outlined, color: theme.colorScheme.primary),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(l10n.game_seasonDesc, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('${game.seasonStep - 1} / ${(game.seasonStep - 1) + remaining}', style: theme.textTheme.bodySmall),
          const SizedBox(height: 9),
          LinearProgressIndicator(value: completedInBlock / 5, minHeight: 7, borderRadius: BorderRadius.circular(99)),
        ])),
      ]),
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
        opacity: badge.unlocked ? 1 : .62,
        child: FastingArtSlot(
          assetPath: _badgeArtwork(badge.id),
          height: constraints.maxHeight,
          borderRadius: 18,
          variant: FastingArtVariant.bare,
          semanticLabel: _badgeTitle(l10n, badge.id),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [
                        Colors.transparent,
                        const Color(0xFF0F1424).withValues(alpha: .18),
                        const Color(0xFF0F1424).withValues(alpha: .96),
                      ]
                    : [
                        Colors.transparent,
                        theme.colorScheme.surface.withValues(alpha: .18),
                        theme.colorScheme.surface.withValues(alpha: .96),
                      ],
                stops: const [0, .48, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(
                color: badge.unlocked
                    ? AppColors.primary.withValues(alpha: .55)
                    : theme.dividerColor,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      badge.unlocked ? Icons.check_circle : Icons.lock_outline,
                      size: 16,
                      color: labelColor.withValues(alpha: .9),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _badgeTitle(l10n, badge.id),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: labelColor,
                      fontWeight: FontWeight.w800,
                      height: 1.1,
                    ),
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
            FastingArtSlot(assetPath: _badgeArtwork(badge.id), height: 190, borderRadius: 22, variant: FastingArtVariant.bare, child: const SizedBox.shrink()),
            const SizedBox(height: 18),
            Text(description, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
            const SizedBox(height: 14),
            LinearProgressIndicator(value: badge.ratio, minHeight: 9, borderRadius: BorderRadius.circular(99)),
            const SizedBox(height: 8),
            Text(badge.unlocked ? l10n.timer_completed : '${badge.progress} / ${badge.target}', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pop(sheetContext), child: Text(l10n.common_ok))),
          ]),
        ),
      );
    },
  );

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
