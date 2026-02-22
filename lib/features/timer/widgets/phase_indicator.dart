import 'package:flutter/material.dart';
import '../../../core/constants/metabolic_phases.dart';
import '../../../core/theme/app_spacing.dart';

class PhaseIndicator extends StatelessWidget {
  final double elapsedHours;
  final int targetHours;

  const PhaseIndicator({
    super.key,
    required this.elapsedHours,
    required this.targetHours,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final isTr = locale == 'tr';

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: MetabolicPhases.all.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final phase = MetabolicPhases.all[index];
          final isActive = elapsedHours >= phase.startHour &&
              elapsedHours < phase.endHour;
          final isPassed = elapsedHours >= phase.endHour;
          final isReachable = phase.startHour < targetHours;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: isActive
                  ? LinearGradient(
                      colors: [
                        phase.gradientColors.first.withValues(alpha:0.2),
                        phase.gradientColors.last.withValues(alpha:0.1),
                      ],
                    )
                  : null,
              color: isActive ? null : Colors.transparent,
              borderRadius: AppSpacing.borderRadiusMd,
              border: isActive
                  ? Border.all(
                      color: phase.gradientColors.first.withValues(alpha:0.5),
                      width: 1.5,
                    )
                  : Border.all(color: Colors.transparent),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  phase.icon,
                  size: 20,
                  color: isActive
                      ? phase.gradientColors.first
                      : isPassed
                          ? theme.colorScheme.primary
                          : isReachable
                              ? theme.colorScheme.onSurface.withValues(alpha:0.3)
                              : theme.colorScheme.onSurface.withValues(alpha:0.15),
                ),
                const SizedBox(height: 4),
                Text(
                  isTr ? phase.nameTr : phase.name,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isActive
                        ? phase.gradientColors.first
                        : isPassed
                            ? theme.colorScheme.onSurface
                            : theme.colorScheme.onSurface.withValues(alpha:0.4),
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${phase.startHour}-${phase.endHour > 24 ? '24+' : phase.endHour}${isTr ? 's' : 'h'}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: theme.colorScheme.onSurface.withValues(alpha:0.4),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
