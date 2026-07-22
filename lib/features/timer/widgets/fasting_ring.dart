import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/constants/metabolic_phases.dart';
import '../../../core/utils/metabolic_phase_l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../painters/ring_painter.dart';

class FastingRing extends StatelessWidget {
  const FastingRing({
    super.key,
    required this.progress,
    required this.elapsedHours,
    required this.targetHours,
    required this.phaseColors,
    required this.child,
    this.size = 276,
  });

  final double progress;
  final double elapsedHours;
  final double targetHours;
  final List<Color> phaseColors;
  final Widget child;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final colors =
        phaseColors.isEmpty
            ? const [AppColors.primary, AppColors.primaryLight]
            : phaseColors;
    final l10n = AppLocalizations.of(context)!;
    final visiblePhases =
        MetabolicPhases.all
            .where((phase) => phase.startHour < targetHours)
            .toList();

    return Semantics(
      label: l10n.fasting_progressSemantics((progress * 100).round()),
      value: '${(progress * 100).round()}%',
      readOnly: true,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: size * .78,
              height: size * .78,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    colors.last.withValues(alpha: isDark ? .12 : .08),
                    colors.first.withValues(alpha: .025),
                    Colors.transparent,
                  ],
                  stops: const [0, .7, 1],
                ),
              ),
            ),
            RepaintBoundary(
              child: TweenAnimationBuilder<double>(
                tween: Tween(end: progress.clamp(0.0, 1.0)),
                duration:
                    reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 650),
                curve: const Cubic(.23, 1, .32, 1),
                builder:
                    (context, value, _) => CustomPaint(
                      size: Size.square(size - 28),
                      painter: RingPainter(
                        progress: value,
                        gradientColors: colors,
                        trackColor: theme.colorScheme.onSurface.withValues(
                          alpha: isDark ? .10 : .07,
                        ),
                        tickColor: theme.colorScheme.onSurface.withValues(
                          alpha: isDark ? .18 : .13,
                        ),
                      ),
                    ),
              ),
            ),
            for (final phase in visiblePhases)
              _PhaseMarker(
                phase: phase,
                l10n: l10n,
                isCurrent:
                    elapsedHours >= phase.startHour &&
                    elapsedHours < phase.endHour,
                isCompleted: elapsedHours >= phase.endHour,
                targetHours: targetHours,
                ringSize: size,
              ),
            SizedBox(width: size * .68, child: child),
          ],
        ),
      ),
    );
  }
}

class _PhaseMarker extends StatelessWidget {
  const _PhaseMarker({
    required this.phase,
    required this.l10n,
    required this.isCurrent,
    required this.isCompleted,
    required this.targetHours,
    required this.ringSize,
  });

  final MetabolicPhase phase;
  final AppLocalizations l10n;
  final bool isCurrent;
  final bool isCompleted;
  final double targetHours;
  final double ringSize;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fraction =
        targetHours <= 0
            ? 0.0
            : (phase.startHour / targetHours).clamp(0.0, 1.0);
    final angle = -math.pi / 2 + 2 * math.pi * fraction;
    final orbit = ringSize * .36;
    const markerSize = 48.0;
    final center = ringSize / 2;
    final color = phase.gradientColors.first;
    final active = isCurrent || isCompleted;

    return Positioned(
      left: center + orbit * math.cos(angle) - markerSize / 2,
      top: center + orbit * math.sin(angle) - markerSize / 2,
      width: markerSize,
      height: markerSize,
      child: Semantics(
        label: metabolicPhaseName(l10n, phase),
        selected: isCurrent,
        button: true,
        child: Material(
          color: Colors.transparent,
          child: InkResponse(
            radius: markerSize / 2,
            onTap: () => _showPhaseInfo(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: isCurrent ? 18 : 13,
                  height: isCurrent ? 18 : 13,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: active ? color : theme.colorScheme.surfaceContainer,
                    border: Border.all(
                      color: active ? color : theme.colorScheme.outline,
                      width: 1.5,
                    ),
                    boxShadow:
                        isCurrent
                            ? [
                              BoxShadow(
                                color: color.withValues(alpha: .35),
                                blurRadius: 10,
                              ),
                            ]
                            : null,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.phase_hourMarker(phase.startHour),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color:
                        active
                            ? color
                            : theme.colorScheme.onSurface.withValues(alpha: .5),
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showPhaseInfo(BuildContext context) =>
      showModalBottomSheet<void>(
        context: context,
        showDragHandle: true,
        builder: (context) {
          final theme = Theme.of(context);
          final color = phase.gradientColors.first;
          final name = metabolicPhaseName(l10n, phase);
          final description = metabolicPhaseDescription(l10n, phase);
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: .12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(phase.icon, color: color),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name, style: theme.textTheme.titleLarge),
                            Text(
                              l10n.phase_hours(phase.startHour, phase.endHour),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: color,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      l10n.phase_estimateLong,
                      style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
