import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

class TimerDisplay extends StatelessWidget {
  const TimerDisplay({
    super.key,
    required this.elapsed,
    required this.remaining,
    required this.phaseLabel,
    required this.isRunning,
    this.progress = 0,
    this.endTime,
  });

  final String elapsed;
  final String remaining;
  final String phaseLabel;
  final bool isRunning;
  final double progress;
  final DateTime? endTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final foreground = theme.colorScheme.onSurface;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: .09),
            borderRadius: BorderRadius.circular(99),
          ),
          child: Text(
            phaseLabel.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),
        ),
        const SizedBox(height: 12),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            isRunning ? elapsed : '00:00:00',
            style: theme.textTheme.displaySmall?.copyWith(
              color: foreground,
              fontSize: 42,
              height: 1,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.8,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          isRunning
              ? '$remaining ${l10n.timer_remaining.toLowerCase()}'
              : l10n.timer_ready,
          maxLines: 1,
          style: theme.textTheme.bodySmall?.copyWith(
            color: foreground.withValues(alpha: .55),
            fontWeight: FontWeight.w600,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
