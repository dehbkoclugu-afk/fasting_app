import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';

enum PlanDifficulty {
  beginner,
  popular,
  intermediate,
  advanced,
  expert,
  alternative,
}

class FastingPlan {
  final String id;
  final String name;
  final String shortName;
  final int fastingHours;
  final int eatingHours;
  final PlanDifficulty difficulty;
  final IconData icon;
  final bool isPremium;

  const FastingPlan({
    required this.id,
    required this.name,
    required this.shortName,
    required this.fastingHours,
    required this.eatingHours,
    required this.difficulty,
    required this.icon,
    this.isPremium = false,
  });

  String description(AppLocalizations l10n) => switch (id) {
    '12_12' => l10n.plan_12_desc,
    '16_8' => l10n.plan_16_desc,
    '18_6' => l10n.plan_18_desc,
    '20_4' => l10n.plan_20_desc,
    'omad' => l10n.plan_omad_desc,
    '5_2' => l10n.plan_52_desc,
    'eat_stop_eat' => l10n.plan_ese_desc,
    _ => l10n.plan_warrior_desc,
  };

  String detailedDescription(AppLocalizations l10n) => switch (id) {
    '12_12' => l10n.plan_12_detail,
    '16_8' => l10n.plan_16_detail,
    '18_6' => l10n.plan_18_detail,
    '20_4' => l10n.plan_20_detail,
    'omad' => l10n.plan_omad_detail,
    '5_2' => l10n.plan_52_detail,
    'eat_stop_eat' => l10n.plan_ese_detail,
    _ => l10n.plan_warrior_detail,
  };

  int get fastingMinutes => fastingHours * 60;
  int get eatingMinutes => eatingHours * 60;
}

class FastingPlans {
  FastingPlans._();

  static const List<FastingPlan> all = [
    FastingPlan(
      id: '12_12',
      name: '12:12',
      shortName: '12:12',
      fastingHours: 12,
      eatingHours: 12,
      difficulty: PlanDifficulty.beginner,
      icon: Icons.spa_outlined,
    ),
    FastingPlan(
      id: '16_8',
      name: '16:8',
      shortName: '16:8',
      fastingHours: 16,
      eatingHours: 8,
      difficulty: PlanDifficulty.popular,
      icon: Icons.local_fire_department_outlined,
    ),
    FastingPlan(
      id: '18_6',
      name: '18:6',
      shortName: '18:6',
      fastingHours: 18,
      eatingHours: 6,
      difficulty: PlanDifficulty.intermediate,
      icon: Icons.bolt_outlined,
      isPremium: true,
    ),
    FastingPlan(
      id: '20_4',
      name: '20:4',
      shortName: '20:4',
      fastingHours: 20,
      eatingHours: 4,
      difficulty: PlanDifficulty.advanced,
      icon: Icons.flash_on_outlined,
      isPremium: true,
    ),
    FastingPlan(
      id: 'omad',
      name: 'OMAD',
      shortName: 'OMAD',
      fastingHours: 23,
      eatingHours: 1,
      difficulty: PlanDifficulty.expert,
      icon: Icons.restaurant_outlined,
      isPremium: true,
    ),
    FastingPlan(
      id: '5_2',
      name: '5:2',
      shortName: '5:2',
      fastingHours: 24,
      eatingHours: 0,
      difficulty: PlanDifficulty.alternative,
      icon: Icons.calendar_today_outlined,
      isPremium: true,
    ),
    FastingPlan(
      id: 'eat_stop_eat',
      name: 'Eat-Stop-Eat',
      shortName: 'ESE',
      fastingHours: 24,
      eatingHours: 0,
      difficulty: PlanDifficulty.advanced,
      icon: Icons.timer_outlined,
      isPremium: true,
    ),
    FastingPlan(
      id: 'warrior',
      name: 'Warrior Diet',
      shortName: 'Warrior',
      fastingHours: 20,
      eatingHours: 4,
      difficulty: PlanDifficulty.advanced,
      icon: Icons.shield_outlined,
      isPremium: true,
    ),
  ];

  static FastingPlan getById(String id) {
    return all.firstWhere((p) => p.id == id, orElse: () => all[1]);
  }

  static List<FastingPlan> get freePlans =>
      all.where((p) => !p.isPremium).toList();
  static List<FastingPlan> get premiumPlans =>
      all.where((p) => p.isPremium).toList();
}
