import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
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

    return FastingSplitArtCard(
      assetPath: 'assets/images/editorial/v4/report-streak.webp',
      minHeight: 184,
      artWidth: 164,
      borderRadius: 24,
      alignment: Alignment.centerRight,
      semanticLabel: l10n.stats_streak,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(
                  '$currentStreak',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(width: 6),
                Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(
                  '${l10n.common_days} ${l10n.stats_streak.toLowerCase()}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: fastingArtMutedForeground(context),
                  ),
                )),
              ]),
              const SizedBox(height: 8),
              Text(_getStreakMessage(context, currentStreak), style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.onSurface, fontWeight: FontWeight.w700)),
              const SizedBox(height: 10),
              Text(
                '${l10n.streakCard_longestStreak}: $longestStreak ${l10n.common_days} · '
                '${l10n.streakCard_totalSessions}: $totalSessions',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
        ),
      ),
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
