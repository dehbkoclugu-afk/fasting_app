import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/constants/metabolic_phases.dart';
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
      child: FastingArtSlot(
        assetPath: _phaseArtwork(current),
        height: 250,
        borderRadius: 22,
        variant: FastingArtVariant.card,
        alignment: Alignment.bottomRight,
        artScale: .82,
        semanticLabel: metabolicPhaseName(l10n, current),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Align(
            alignment: Alignment.topLeft,
            child: FractionallySizedBox(
              widthFactor: .64,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    metabolicPhaseName(l10n, current),
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    metabolicPhaseDescription(l10n, current),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: fastingArtMutedForeground(context),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          l10n.journey_now,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: current.gradientColors.first,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        '%${(progress * 100).round()}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 9,
                      backgroundColor: theme.colorScheme.outlineVariant
                          .withValues(alpha: .55),
                      valueColor: AlwaysStoppedAnimation(
                        current.gradientColors.first,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_clock(startTime), style: theme.textTheme.labelSmall),
                      Text(_clock(endTime), style: theme.textTheme.labelSmall),
                    ],
                  ),
                  if (next != null) ...[
                    const SizedBox(height: 9),
                    Text(
                      l10n.journey_next(
                        _remaining(next.startHour),
                        metabolicPhaseName(l10n, next),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                  const SizedBox(height: 9),
                  Text(
                    l10n.phase_estimateShort,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: .5),
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _phaseArtwork(MetabolicPhase phase) => 'assets/images/editorial/v5/phase-${switch (phase.id) { 'fatBurning' => 'fat-burning', _ => phase.id }}.webp';

  String _remaining(int startHour) {
    final minutes = math.max(0, ((startHour - elapsedHours) * 60).round());
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return hours == 0 ? '${rest}m' : '${hours}h ${rest}m';
  }

  String _clock(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}
