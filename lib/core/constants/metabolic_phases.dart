import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MetabolicPhase {
  final String id;
  final String name;
  final String nameTr;
  final int startHour;
  final int endHour;
  final String description;
  final String descriptionTr;
  final List<Color> gradientColors;
  final IconData icon;

  const MetabolicPhase({
    required this.id,
    required this.name,
    required this.nameTr,
    required this.startHour,
    required this.endHour,
    required this.description,
    required this.descriptionTr,
    required this.gradientColors,
    required this.icon,
  });
}

class MetabolicPhases {
  MetabolicPhases._();

  static const List<MetabolicPhase> all = [
    MetabolicPhase(
      id: 'anabolic',
      name: 'Anabolic',
      nameTr: 'Anabolik',
      startHour: 0,
      endHour: 4,
      description: 'Your body is digesting food, insulin levels are high',
      descriptionTr: 'Vücudun besinleri sindiriyor, insülin seviyesi yüksek',
      gradientColors: [AppColors.anabolicStart, AppColors.anabolicEnd],
      icon: Icons.restaurant_outlined,
    ),
    MetabolicPhase(
      id: 'catabolic',
      name: 'Catabolic',
      nameTr: 'Katabolik',
      startHour: 4,
      endHour: 8,
      description: 'Blood sugar dropping, glucagon rising',
      descriptionTr: 'Kan şekeri düşüyor, glukagon yükseliyor',
      gradientColors: [AppColors.catabolicStart, AppColors.catabolicEnd],
      icon: Icons.trending_down_outlined,
    ),
    MetabolicPhase(
      id: 'fatBurning',
      name: 'Fat Burning',
      nameTr: 'Yağ Yakımı',
      startHour: 8,
      endHour: 12,
      description: 'Fat burning begins, insulin is low',
      descriptionTr: 'Yağ yakımı başlıyor, insülin düşük',
      gradientColors: [AppColors.fatBurningStart, AppColors.fatBurningEnd],
      icon: Icons.local_fire_department_outlined,
    ),
    MetabolicPhase(
      id: 'ketosis',
      name: 'Ketosis',
      nameTr: 'Ketozis',
      startHour: 12,
      endHour: 18,
      description: 'Ketone production starts, mental clarity improves',
      descriptionTr: 'Keton üretimi başlıyor, mental netlik artıyor',
      gradientColors: [AppColors.ketosisStart, AppColors.ketosisEnd],
      icon: Icons.bolt_outlined,
    ),
    MetabolicPhase(
      id: 'autophagy',
      name: 'Autophagy',
      nameTr: 'Otofaji',
      startHour: 18,
      endHour: 72,
      description: 'Cell renewal is active, damaged cells are recycled',
      descriptionTr: 'Hücre yenilenmesi aktif, hasarlı hücreler geri dönüştürülüyor',
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
