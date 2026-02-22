class Calculations {
  Calculations._();

  /// BMI hesaplama: kg / (m * m)
  static double calculateBMI(double weightKg, double heightCm) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// BMI kategorisi
  static String getBMICategory(double bmi, [String locale = 'tr']) {
    if (locale == 'en') {
      if (bmi < 18.5) return 'Underweight';
      if (bmi < 25) return 'Normal';
      if (bmi < 30) return 'Overweight';
      return 'Obese';
    }
    if (bmi < 18.5) return 'Zayıf';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Fazla Kilolu';
    return 'Obez';
  }

  /// TDEE (Total Daily Energy Expenditure) - Mifflin-St Jeor
  /// activityLevel: 1.2 (sedanter), 1.375 (hafif), 1.55 (orta), 1.725 (yoğun), 1.9 (çok yoğun)
  static double calculateTDEE({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
    double activityLevel = 1.55,
  }) {
    double bmr;
    if (isMale) {
      bmr = 10 * weightKg + 6.25 * heightCm - 5 * age + 5;
    } else {
      bmr = 10 * weightKg + 6.25 * heightCm - 5 * age - 161;
    }
    return bmr * activityLevel;
  }

  /// Oruç tamamlama yüzdesi
  static double fastingProgress(int elapsedMinutes, int targetMinutes) {
    if (targetMinutes <= 0) return 0;
    return (elapsedMinutes / targetMinutes).clamp(0.0, 1.0);
  }

  /// Geçen saat hesaplama (DateTime farkı)
  static double elapsedHours(DateTime startTime) {
    final diff = DateTime.now().difference(startTime);
    return diff.inMinutes / 60.0;
  }

  /// Streak hesaplama - ardışık gün sayısı
  static int calculateStreak(List<DateTime> completedDates) {
    if (completedDates.isEmpty) return 0;

    final sorted = completedDates.map((d) => DateTime(d.year, d.month, d.day)).toList()
      ..sort((a, b) => b.compareTo(a));

    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);

    int streak = 0;
    var checkDate = todayDate;

    for (final date in sorted) {
      if (date == checkDate) {
        streak++;
        checkDate = checkDate.subtract(const Duration(days: 1));
      } else if (date.isBefore(checkDate)) {
        break;
      }
    }

    return streak;
  }

  /// Günlük su hedefi (ml) - vücut ağırlığına göre
  static int dailyWaterGoal(double weightKg) {
    return (weightKg * 35).round(); // 35ml per kg
  }
}
