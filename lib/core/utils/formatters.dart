class Formatters {
  Formatters._();

  /// Formats duration in seconds to "HH:MM:SS"
  static String formatDuration(int totalSeconds) {
    final hours = totalSeconds ~/ 3600;
    final minutes = (totalSeconds % 3600) ~/ 60;
    final seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Formats duration to "16s 23dk" style
  static String formatDurationTr(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours > 0 && minutes > 0) {
      return '${hours}s ${minutes}dk';
    } else if (hours > 0) {
      return '${hours}s';
    }
    return '${minutes}dk';
  }

  /// Formats hours to readable "12 saat 30 dakika"
  static String formatHoursMinutes(double totalHours) {
    final hours = totalHours.floor();
    final minutes = ((totalHours - hours) * 60).round();
    if (hours > 0 && minutes > 0) {
      return '$hours saat $minutes dakika';
    } else if (hours > 0) {
      return '$hours saat';
    }
    return '$minutes dakika';
  }

  /// Formats water amount: "1.5L" or "750ml"
  static String formatWater(int ml) {
    if (ml >= 1000) {
      final liters = ml / 1000;
      return '${liters.toStringAsFixed(liters.truncateToDouble() == liters ? 0 : 1)}L';
    }
    return '${ml}ml';
  }

  /// Formats calories: "1,234 kcal"
  static String formatCalories(int calories) {
    if (calories >= 1000) {
      final thousands = calories ~/ 1000;
      final remainder = calories % 1000;
      return '$thousands,${remainder.toString().padLeft(3, '0')} kcal';
    }
    return '$calories kcal';
  }

  /// Formats percentage: "85%"
  static String formatPercentage(double value) {
    return '${(value * 100).round()}%';
  }

  /// Formats weight: "72.5 kg"
  static String formatWeight(double kg) {
    return '${kg.toStringAsFixed(1)} kg';
  }
}
