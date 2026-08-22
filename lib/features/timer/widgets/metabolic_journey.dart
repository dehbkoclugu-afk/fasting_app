import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/constants/metabolic_phases.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/utils/metabolic_phase_l10n.dart';
import '../../../shared/widgets/fasting_art_slot.dart';

class MetabolicJourney extends StatelessWidget {
  const MetabolicJourney({
    super.key,
    required this.elapsedHours,
    required this.targetHours,
    required this.startTime,
  });

  final double elapsedHours;
  final double targetHours;
  final DateTime startTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final current = MetabolicPhases.getPhaseForHours(elapsedHours);
    MetabolicPhase? next;
    for (final phase in MetabolicPhases.all) {
      if (phase.startHour > elapsedHours && phase.startHour < targetHours) {
        next = phase;
        break;
      }
    }
    final progress = targetHours <= 0
        ? 0.0
        : (elapsedHours / targetHours).clamp(0.0, 1.0);
    final endTime = startTime.add(
      Duration(minutes: (targetHours * 60).round()),
    );

    return Semantics(
      label: l10n.journey_label,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: .45),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: FastingArtSlot(
                    assetPath: _phaseArtwork(current),
                    height: 68,
                    borderRadius: 16,
                    variant: FastingArtVariant.bare,
                    fit: BoxFit.cover,
                    semanticLabel: metabolicPhaseName(l10n, current),
                    child: const SizedBox.shrink(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metabolicPhaseName(l10n, current),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        metabolicPhaseDescription(l10n, current),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.journey_now,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: current.gradientColors.first,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Text(
                  Formatters.formatPercentage(progress, locale: locale),
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 9,
                backgroundColor: theme.colorScheme.outlineVariant.withValues(
                  alpha: .55,
                ),
                valueColor: AlwaysStoppedAnimation(
                  current.gradientColors.first,
                ),
              ),
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_clock(startTime), style: theme.textTheme.labelSmall),
                Text(_clock(endTime), style: theme.textTheme.labelSmall),
              ],
            ),
            if (next != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: current.gradientColors.first.withValues(alpha: .08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  l10n.journey_next(
                    _remaining(l10n, locale, next.startHour),
                    metabolicPhaseName(l10n, next),
                  ),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text(
              l10n.phase_estimateShort,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _remaining(
    AppLocalizations l10n,
    String locale,
    int startHour,
  ) {
    final minutes = math
        .max(0, ((startHour - elapsedHours) * 60).round())
        .toInt();
    return Formatters.formatShortDuration(
      minutes,
      locale: locale,
      hoursLabel: l10n.common_hours,
      minutesLabel: l10n.common_minutes,
    );
  }

  String _phaseArtwork(MetabolicPhase phase) =>
      'assets/images/editorial/v5/phase-${switch (phase.id) { 'fatBurning' => 'fat-burning', _ => phase.id }}.webp';

  String _clock(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
