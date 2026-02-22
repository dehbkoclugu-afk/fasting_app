import 'package:flutter/material.dart';

enum PlanDifficulty { beginner, popular, intermediate, advanced, expert, alternative }

class FastingPlan {
  final String id;
  final String name;
  final String shortName;
  final int fastingHours;
  final int eatingHours;
  final String descriptionTr;
  final String descriptionEn;
  final String detailedDescriptionTr;
  final String detailedDescriptionEn;
  final PlanDifficulty difficulty;
  final IconData icon;
  final bool isPremium;

  const FastingPlan({
    required this.id,
    required this.name,
    required this.shortName,
    required this.fastingHours,
    required this.eatingHours,
    required this.descriptionTr,
    required this.descriptionEn,
    required this.detailedDescriptionTr,
    required this.detailedDescriptionEn,
    required this.difficulty,
    required this.icon,
    this.isPremium = false,
  });

  String description(String locale) => locale == 'tr' ? descriptionTr : descriptionEn;
  String detailedDescription(String locale) => locale == 'tr' ? detailedDescriptionTr : detailedDescriptionEn;

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
      descriptionTr: 'Başlangıç seviyesi',
      descriptionEn: 'Beginner level',
      detailedDescriptionTr: 'Oruç tutmaya yeni başlayanlar için ideal. Gece uykusu ile birlikte 12 saat oruç tutarsın.',
      detailedDescriptionEn: 'Ideal for beginners. Fast 12 hours including your sleep time.',
      difficulty: PlanDifficulty.beginner,
      icon: Icons.spa_outlined,
    ),
    FastingPlan(
      id: '16_8',
      name: '16:8',
      shortName: '16:8',
      fastingHours: 16,
      eatingHours: 8,
      descriptionTr: 'En popüler plan',
      descriptionEn: 'Most popular plan',
      detailedDescriptionTr: 'En yaygın IF planı. 16 saat oruç, 8 saat yemek penceresi. Genelde öğle-akşam yemeği arası.',
      detailedDescriptionEn: 'The most common IF plan. 16 hours fasting, 8 hours eating window. Usually lunch to dinner.',
      difficulty: PlanDifficulty.popular,
      icon: Icons.local_fire_department_outlined,
    ),
    FastingPlan(
      id: '18_6',
      name: '18:6',
      shortName: '18:6',
      fastingHours: 18,
      eatingHours: 6,
      descriptionTr: 'Orta seviye',
      descriptionEn: 'Intermediate level',
      detailedDescriptionTr: '18 saat oruç, 6 saat yemek penceresi. Daha uzun yağ yakım süresi sağlar.',
      detailedDescriptionEn: '18 hours fasting, 6 hours eating window. Longer fat burning duration.',
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
      descriptionTr: 'İleri seviye',
      descriptionEn: 'Advanced level',
      detailedDescriptionTr: '20 saat oruç, 4 saat yemek penceresi. Ketozis ve otofaji fazlarına ulaşmak için ideal.',
      detailedDescriptionEn: '20 hours fasting, 4 hours eating window. Ideal for reaching ketosis and autophagy.',
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
      descriptionTr: 'Günde tek öğün',
      descriptionEn: 'One meal a day',
      detailedDescriptionTr: 'One Meal A Day - Günde tek öğün. 23 saat oruç, 1 saat yemek penceresi. Uzman seviyesi.',
      detailedDescriptionEn: 'One Meal A Day. 23 hours fasting, 1 hour eating window. Expert level.',
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
      descriptionTr: 'Haftada 2 gün',
      descriptionEn: '2 days per week',
      detailedDescriptionTr: 'Haftada 5 gün normal ye, 2 gün sadece ~500 kalori al. Alternatif bir yaklaşım.',
      detailedDescriptionEn: 'Eat normally 5 days, only ~500 calories on 2 days. An alternative approach.',
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
      descriptionTr: '24 saat oruç',
      descriptionEn: '24 hour fast',
      detailedDescriptionTr: 'Haftada 1-2 kez tam 24 saat oruç tut. İleri seviye kullanıcılar için.',
      detailedDescriptionEn: 'Fast for 24 hours 1-2 times per week. For advanced users.',
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
      descriptionTr: 'Savaşçı diyeti',
      descriptionEn: 'Warrior diet',
      detailedDescriptionTr: 'Gün boyunca az ye (meyve, sebze), akşam 4 saatlik pencerede ana öğününü ye.',
      detailedDescriptionEn: 'Eat light during the day (fruits, veggies), have your main meal in a 4-hour evening window.',
      difficulty: PlanDifficulty.advanced,
      icon: Icons.shield_outlined,
      isPremium: true,
    ),
  ];

  static FastingPlan getById(String id) {
    return all.firstWhere((p) => p.id == id, orElse: () => all[1]);
  }

  static List<FastingPlan> get freePlans => all.where((p) => !p.isPremium).toList();
  static List<FastingPlan> get premiumPlans => all.where((p) => p.isPremium).toList();
}
