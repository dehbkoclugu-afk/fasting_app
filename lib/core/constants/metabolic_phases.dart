import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MetabolicPhase {
  final String id;
  final int startHour;
  final int endHour;
  final List<Color> gradientColors;
  final IconData icon;

  const MetabolicPhase({
    required this.id,
    required this.startHour,
    required this.endHour,
    required this.gradientColors,
    required this.icon,
  });
}

class MetabolicPhases {
  MetabolicPhases._();

  static const List<MetabolicPhase> all = [
    MetabolicPhase(
      id: 'anabolic',
      startHour: 0,
      endHour: 4,
      gradientColors: [AppColors.anabolicStart, AppColors.anabolicEnd],
      icon: Icons.restaurant_outlined,
    ),
    MetabolicPhase(
      id: 'catabolic',
      startHour: 4,
      endHour: 8,
      gradientColors: [AppColors.catabolicStart, AppColors.catabolicEnd],
      icon: Icons.trending_down_outlined,
    ),
    MetabolicPhase(
      id: 'fatBurning',
      startHour: 8,
      endHour: 12,
      gradientColors: [AppColors.fatBurningStart, AppColors.fatBurningEnd],
      icon: Icons.local_fire_department_outlined,
    ),
    MetabolicPhase(
      id: 'ketosis',
      startHour: 12,
      endHour: 18,
      gradientColors: [AppColors.ketosisStart, AppColors.ketosisEnd],
      icon: Icons.bolt_outlined,
    ),
    MetabolicPhase(
      id: 'autophagy',
      startHour: 18,
      endHour: 72,
      gradientColors: [AppColors.autophagyStart, AppColors.autophagyEnd],
      icon: Icons.autorenew_outlined,
    ),
  ];

  static MetabolicPhase getPhaseForHours(double hours) {
    for (final phase in all) {
      if (hours >= phase.startHour && hours < phase.endHour) {
        return phase;
      }
    }
    return all.last; // autophagy for 18+ hours
  }

  static double getPhaseProgress(double hours) {
    final phase = getPhaseForHours(hours);
    final phaseRange = (phase.endHour - phase.startHour).toDouble();
    final elapsed = hours - phase.startHour;
    return (elapsed / phaseRange).clamp(0.0, 1.0);
  }
}
