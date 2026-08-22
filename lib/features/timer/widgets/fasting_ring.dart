import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

import '../../../core/constants/metabolic_phases.dart';
import '../../../core/utils/metabolic_phase_l10n.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/fasting_art_slot.dart';
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
          clipBehavior: Clip.none,
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
                      // Leave enough room for the phase markers and their
                      // labels without making their tap targets overflow the
                      // ring widget's bounds.
                      size: Size.square(size - 70),
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
    // Keep phase controls on the outer edge of the clock instead of letting
    // them drift into the timer copy and hands.
    const markerSize = 44.0;
    final orbit = (ringSize - markerSize) / 2;
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
        useRootNavigator: true,
        isScrollControlled: true,
        showDragHandle: false,
        backgroundColor: Colors.transparent,
        builder: (sheetContext) {
          final context = sheetContext;
          final theme = Theme.of(context);
          final color = phase.gradientColors.first;
          final name = metabolicPhaseName(l10n, phase);
          final description = metabolicPhaseDescription(l10n, phase);
          final phases = MetabolicPhases.all;
          final phaseIndex = phases.indexWhere((item) => item.id == phase.id);
          final nextPhase = phaseIndex >= 0 && phaseIndex < phases.length - 1
              ? metabolicPhaseName(l10n, phases[phaseIndex + 1])
              : null;
          return SafeArea(
            top: false,
            child: FractionallySizedBox(
              heightFactor: .78,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 12, 8),
                      child: Row(children: [
                        Container(width: 36, height: 4, decoration: BoxDecoration(color: theme.colorScheme.outlineVariant, borderRadius: BorderRadius.circular(9))),
                        const Spacer(),
                        IconButton(onPressed: () => Navigator.pop(sheetContext), icon: const Icon(Icons.close_rounded)),
                      ]),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FastingSplitArtCard(
                              assetPath: _phaseArtwork(phase),
                              minHeight: 174,
                              artWidth: 150,
                              borderRadius: 24,
                              alignment: Alignment.centerRight,
                              semanticLabel: name,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(name, style: theme.textTheme.headlineSmall?.copyWith(color: fastingArtForeground(context), fontWeight: FontWeight.w900)),
                                    const SizedBox(height: 5),
                                    Text(l10n.phase_hours(phase.startHour, phase.endHour), style: theme.textTheme.labelLarge?.copyWith(color: color, fontWeight: FontWeight.w800)),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            _PhaseInfoRow(icon: Icons.auto_awesome_rounded, color: color, title: description, body: l10n.phase_estimateLong),
                            const SizedBox(height: 12),
                            _PhaseInfoRow(icon: Icons.self_improvement_rounded, color: color, title: l10n.weather_listen, body: l10n.explore_rule4),
                            const SizedBox(height: 12),
                            _PhaseInfoRow(icon: Icons.water_drop_outlined, color: color, title: l10n.tip_water, body: l10n.tip_waterDesc),
                            if (nextPhase != null) ...[
                              const SizedBox(height: 12),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                decoration: BoxDecoration(color: color.withValues(alpha: .09), borderRadius: BorderRadius.circular(18)),
                                child: Row(children: [
                                  Icon(Icons.arrow_forward_rounded, color: color),
                                  const SizedBox(width: 12),
                                  Expanded(child: Text(nextPhase, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800))),
                                ]),
                              ),
                            ],
                            const SizedBox(height: 14),
                            Text(l10n.phase_estimateShort, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );

  String _phaseArtwork(MetabolicPhase phase) => 'assets/images/editorial/v5/phase-${switch (phase.id) { 'fatBurning' => 'fat-burning', _ => phase.id }}.webp';
}

class _PhaseInfoRow extends StatelessWidget {
  const _PhaseInfoRow({required this.icon, required this.color, required this.title, required this.body});
  final IconData icon;
  final Color color;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: BorderRadius.circular(20)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 38, height: 38, decoration: BoxDecoration(color: color.withValues(alpha: .11), borderRadius: BorderRadius.circular(12)), child: Icon(icon, size: 20, color: color)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(body, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4)),
        ])),
      ]),
    );
  }
}
