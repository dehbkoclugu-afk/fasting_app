import 'package:flutter/foundation.dart';
import 'package:health/health.dart';

class HealthService {
  static final HealthService _instance = HealthService._();
  factory HealthService() => _instance;
  HealthService._();

  final _health = Health();
  bool _authorized = false;

  static const _types = [
    HealthDataType.WEIGHT,
    HealthDataType.HEIGHT,
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.BODY_MASS_INDEX,
  ];

  static const _permissions = [
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
    HealthDataAccess.READ,
  ];

  Future<bool> requestAuthorization() async {
    try {
      final hasPermissions = await _health.hasPermissions(_types, permissions: _permissions);
      if (hasPermissions == true) {
        _authorized = true;
        return true;
      }

      _authorized = await _health.requestAuthorization(_types, permissions: _permissions);
      return _authorized;
    } catch (e) {
      debugPrint('Health authorization error: $e');
      return false;
    }
  }

  bool get isAuthorized => _authorized;

  Future<double?> getLatestWeight() async {
    if (!_authorized) return null;
    try {
      final now = DateTime.now();
      final data = await _health.getHealthDataFromTypes(
        startTime: now.subtract(const Duration(days: 30)),
        endTime: now,
        types: [HealthDataType.WEIGHT],
      );
      if (data.isEmpty) return null;
      data.sort((a, b) => b.dateTo.compareTo(a.dateTo));
      return (data.first.value as NumericHealthValue).numericValue.toDouble();
    } catch (e) {
      debugPrint('Error getting weight: $e');
      return null;
    }
  }

  Future<int> getTodaySteps() async {
    if (!_authorized) return 0;
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final steps = await _health.getTotalStepsInInterval(midnight, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('Error getting steps: $e');
      return 0;
    }
  }

  Future<double> getTodayCaloriesBurned() async {
    if (!_authorized) return 0;
    try {
      final now = DateTime.now();
      final midnight = DateTime(now.year, now.month, now.day);
      final data = await _health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );
      double total = 0;
      for (final point in data) {
        total += (point.value as NumericHealthValue).numericValue.toDouble();
      }
      return total;
    } catch (e) {
      debugPrint('Error getting calories: $e');
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> getWeightHistory({int days = 30}) async {
    if (!_authorized) return [];
    try {
      final now = DateTime.now();
      final data = await _health.getHealthDataFromTypes(
        startTime: now.subtract(Duration(days: days)),
        endTime: now,
        types: [HealthDataType.WEIGHT],
      );
      data.sort((a, b) => a.dateTo.compareTo(b.dateTo));
      return data
          .map((d) => {
                'date': d.dateTo,
                'weight': (d.value as NumericHealthValue).numericValue.toDouble(),
              })
          .toList();
    } catch (e) {
      debugPrint('Error getting weight history: $e');
      return [];
    }
  }
}
