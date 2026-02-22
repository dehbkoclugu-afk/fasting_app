import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/glass_card.dart';

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

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Current streak (big)
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withAlpha(40),
                        Colors.deepOrange.withAlpha(20),
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '🔥',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 8),
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
                    color: theme.colorScheme.onSurface.withAlpha(130),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 80,
            color: theme.dividerTheme.color,
          ),
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
                color: theme.colorScheme.onSurface.withAlpha(120),
                fontSize: 11,
              ),
            ),
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
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
