import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/constants/metabolic_phases.dart';
import '../../../core/utils/metabolic_phase_l10n.dart';

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

    return Semantics(
      label: l10n.journey_label,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: theme.dividerColor.withValues(alpha: .55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(current.icon, color: current.gradientColors.first),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        metabolicPhaseName(l10n, current),
                        style: theme.textTheme.titleMedium,
                      ),
                      Text(
                        metabolicPhaseDescription(l10n, current),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: .64,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 54,
              width: double.infinity,
              child: CustomPaint(
                painter: _DayArcPainter(
                  elapsedHours: elapsedHours,
                  targetHours: targetHours,
                  color: current.gradientColors.first,
                  trackColor: theme.dividerColor.withValues(alpha: .45),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_clock(startTime), style: theme.textTheme.labelSmall),
                Text(
                  l10n.journey_now,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: current.gradientColors.first,
                  ),
                ),
                Text(
                  _clock(
                    startTime.add(
                      Duration(minutes: (targetHours * 60).round()),
                    ),
                  ),
                  style: theme.textTheme.labelSmall,
                ),
              ],
            ),
            if (next != null) ...[
              const SizedBox(height: 8),
              Text(
                l10n.journey_next(
                  _remaining(next.startHour),
                  metabolicPhaseName(l10n, next),
                ),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
            const SizedBox(height: 10),
            Text(
              l10n.phase_estimateShort,
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: .48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _remaining(int startHour) {
    final minutes = math.max(0, ((startHour - elapsedHours) * 60).round());
    final hours = minutes ~/ 60;
    final rest = minutes % 60;
    return hours == 0 ? '${rest}m' : '${hours}h ${rest}m';
  }

  String _clock(DateTime time) =>
      '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
}

class _DayArcPainter extends CustomPainter {
  const _DayArcPainter({
    required this.elapsedHours,
    required this.targetHours,
    required this.color,
    required this.trackColor,
  });

  final double elapsedHours;
  final double targetHours;
  final Color color;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(8, 8, size.width - 16, size.height * 1.45);
    final track =
        Paint()
          ..color = trackColor
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 7;
    final active =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 7;
    canvas.drawArc(rect, math.pi, math.pi, false, track);
    final progress = (elapsedHours / targetHours).clamp(0.0, 1.0);
    canvas.drawArc(rect, math.pi, math.pi * progress, false, active);
    final angle = math.pi + math.pi * progress;
    final center = rect.center;
    final point = Offset(
      center.dx + rect.width / 2 * math.cos(angle),
      center.dy + rect.height / 2 * math.sin(angle),
    );
    canvas.drawCircle(point, 6, Paint()..color = color);
  }

  @override
  bool shouldRepaint(covariant _DayArcPainter oldDelegate) =>
      oldDelegate.elapsedHours != elapsedHours || oldDelegate.color != color;
}
