import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_typography.dart';

class TimerDisplay extends StatelessWidget {
  final String elapsed;
  final String remaining;
  final String phaseLabel;
  final bool isRunning;

  const TimerDisplay({
    super.key,
    required this.elapsed,
    required this.remaining,
    required this.phaseLabel,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final textColor = theme.colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          isRunning ? l10n.timer_remainingTime : l10n.timer_ready,
          style: theme.textTheme.bodySmall?.copyWith(
            color: textColor.withValues(alpha:0.5),
            letterSpacing: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            isRunning ? remaining : elapsed,
            key: ValueKey(isRunning ? remaining : elapsed),
            style: AppTypography.timerLarge(textColor),
          ),
        ),
        const SizedBox(height: 8),
        if (isRunning)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              phaseLabel,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
