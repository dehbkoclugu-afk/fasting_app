import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';

class StreakCard extends StatelessWidget {
  final int currentStreak;
  final int longestStreak;
  final int totalSessions;

  const StreakCard({
    super.key,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalSessions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return FastingArtSlot(
      assetPath: 'assets/images/editorial/v4/report-streak.webp',
      height: 184,
      borderRadius: 24,
      variant: FastingArtVariant.card,
      alignment: Alignment.centerLeft,
      semanticLabel: l10n.stats_streak,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
        children: [
          // Current streak (big)
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$currentStreak',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  '${l10n.common_days} ${l10n.stats_streak.toLowerCase()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: fastingArtMutedForeground(context),
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 94, color: fastingArtDivider(context)),
          // Stats
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatRow(
                    context,
                    icon: Icons.emoji_events_outlined,
                    label: l10n.streakCard_longestStreak,
                    value: '$longestStreak ${l10n.common_days}',
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 14),
                  _buildStatRow(
                    context,
                    icon: Icons.check_circle_outline,
                    label: l10n.streakCard_totalSessions,
                    value: '$totalSessions',
                    color: AppColors.success,
                  ),
                  const SizedBox(height: 14),
                  _buildStatRow(
                    context,
                    icon: Icons.trending_up,
                    label: l10n.streak_status,
                    value: _getStreakMessage(context, currentStreak),
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: fastingArtMutedForeground(context),
                fontSize: 11,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: fastingArtForeground(context),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getStreakMessage(BuildContext context, int streak) {
    final l10n = AppLocalizations.of(context)!;
    if (streak == 0) return l10n.streak_startToday;
    if (streak < 3) return l10n.streak_goodStart;
    if (streak < 7) return l10n.streak_goingGreat;
    if (streak < 14) return l10n.streak_superb;
    if (streak < 30) return l10n.streak_legendary;
    return l10n.streak_incredible;
  }
}
