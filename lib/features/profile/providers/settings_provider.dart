import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/database/app_database.dart';
import '../../../services/analytics_service.dart';
import '../../../services/notification_service.dart';
import '../../timer/providers/water_provider.dart';

class AppSettings {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool waterReminders;
  final bool phaseNotifications;
  final bool soundEnabled;
  final bool calmGamification;
  final bool analyticsEnabled;
  final bool onboardingCompleted;
  final String selectedPlanId;
  final String userName;
  final double? height;
  final double? weight;
  final double? targetWeight;
  final int? age;
  final bool isMale;

  /// Null means follow the device language.
  final String? locale;

  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.notificationsEnabled = true,
    this.waterReminders = true,
    this.phaseNotifications = true,
    this.soundEnabled = false,
    this.calmGamification = false,
    this.analyticsEnabled = false,
    this.onboardingCompleted = false,
    this.selectedPlanId = '16_8',
    this.userName = '',
    this.height,
    this.weight,
    this.targetWeight,
    this.age,
    this.isMale = true,
    this.locale,
  });

  AppSettings copyWith({
    ThemeMode? themeMode,
    bool? notificationsEnabled,
    bool? waterReminders,
    bool? phaseNotifications,
    bool? soundEnabled,
    bool? calmGamification,
    bool? analyticsEnabled,
    bool? onboardingCompleted,
    String? selectedPlanId,
    String? userName,
    double? height,
    double? weight,
    double? targetWeight,
    int? age,
    bool? isMale,
    Object? locale = _unset,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      waterReminders: waterReminders ?? this.waterReminders,
      phaseNotifications: phaseNotifications ?? this.phaseNotifications,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      calmGamification: calmGamification ?? this.calmGamification,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      selectedPlanId: selectedPlanId ?? this.selectedPlanId,
      userName: userName ?? this.userName,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      targetWeight: targetWeight ?? this.targetWeight,
      age: age ?? this.age,
      isMale: isMale ?? this.isMale,
      locale: identical(locale, _unset) ? this.locale : locale as String?,
    );
  }
}

class SettingsNotifier extends StateNotifier<AppSettings> {
  SettingsNotifier(this._database) : super(const AppSettings()) {
    _bodyInfoWork = _load().then((_) => _loadBodyInfo());
  }

  final AppDatabase Function() _database;
  late Future<void> _bodyInfoWork;

  /// Completes once body info loading and queued saves have finished.
  @visibleForTesting
  Future<void> get bodyInfoSettled => _bodyInfoWork;

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    state = AppSettings(
      themeMode: ThemeMode.values[prefs.getInt('themeMode') ?? 0],
      notificationsEnabled: prefs.getBool('notificationsEnabled') ?? true,
      waterReminders: prefs.getBool('waterReminders') ?? true,
      phaseNotifications: prefs.getBool('phaseNotifications') ?? true,
      soundEnabled: prefs.getBool('sound_enabled') ?? false,
      calmGamification: prefs.getBool('calm_gamification') ?? false,
      analyticsEnabled: prefs.getBool(AnalyticsService.optInKey) ?? false,
      onboardingCompleted: prefs.getBool('onboardingCompleted') ?? false,
      selectedPlanId: prefs.getString('selectedPlanId') ?? '16_8',
      userName: prefs.getString('userName') ?? '',
      height: state.height,
      weight: state.weight,
      targetWeight: state.targetWeight,
      age: state.age,
      isMale: prefs.getBool('isMale') ?? true,
      locale: prefs.getString('locale'),
    );
  }

  /// Body info lives in the encrypted database. A value still in preferences is
  /// either from an older version or from a failed save, so it is the newest
  /// one, and it is only removed once the database holds it.
  Future<void> _loadBodyInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final pending = <String, num>{
        for (final key in _bodyInfoKeys)
          if (prefs.get(key) case final num value) key: value,
      };

      var values = pending;
      try {
        final db = _database();
        await _writeBodyInfoToDatabase(db, pending);
        values = {
          for (final key in _bodyInfoKeys)
            if (num.tryParse(await db.getSetting(_databaseKey(key)) ?? '')
                case final value?)
              key: value,
        };
        for (final key in pending.keys) {
          await prefs.remove(key);
        }
      } catch (error) {
        debugPrint('Body info database unavailable: $error');
      }

      if (!mounted) return;
      // A value set while this was loading is newer than anything stored.
      state = state.copyWith(
        height: state.height ?? values['height']?.toDouble(),
        weight: state.weight ?? values['weight']?.toDouble(),
        targetWeight: state.targetWeight ?? values['targetWeight']?.toDouble(),
        age: state.age ?? values['age']?.toInt(),
      );
    } catch (error) {
      debugPrint('Body info load failed: $error');
    }
  }

  Future<void> _saveBodyInfo() async {
    final values = <String, num>{
      if (state.height != null) 'height': state.height!,
      if (state.weight != null) 'weight': state.weight!,
      if (state.targetWeight != null) 'targetWeight': state.targetWeight!,
      if (state.age != null) 'age': state.age!,
    };
    try {
      await _writeBodyInfoToDatabase(_database(), values);
    } catch (error) {
      // Plaintext until the next launch moves it; losing the value is worse.
      debugPrint('Body info save failed, keeping it in preferences: $error');
      final prefs = await SharedPreferences.getInstance();
      for (final MapEntry(:key, :value) in values.entries) {
        if (key == 'age') {
          await prefs.setInt(key, value.toInt());
        } else {
          await prefs.setDouble(key, value.toDouble());
        }
      }
    }
  }

  Future<void> _writeBodyInfoToDatabase(
    AppDatabase db,
    Map<String, num> values,
  ) {
    return db.transaction(() async {
      for (final MapEntry(:key, :value) in values.entries) {
        await db.setSetting(_databaseKey(key), value.toString());
      }
    });
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', state.themeMode.index);
    await prefs.setBool('notificationsEnabled', state.notificationsEnabled);
    await prefs.setBool('waterReminders', state.waterReminders);
    await prefs.setBool('phaseNotifications', state.phaseNotifications);
    await prefs.setBool('sound_enabled', state.soundEnabled);
    await prefs.setBool('calm_gamification', state.calmGamification);
    await prefs.setBool('onboardingCompleted', state.onboardingCompleted);
    await prefs.setString('selectedPlanId', state.selectedPlanId);
    await prefs.setString('userName', state.userName);
    await prefs.setBool('isMale', state.isMale);
    if (state.locale == null) {
      await prefs.remove('locale');
    } else {
      await prefs.setString('locale', state.locale!);
    }
  }

  void setThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    _save();
  }

  void setNotifications(bool enabled) {
    state = state.copyWith(notificationsEnabled: enabled);
    unawaited(_saveAndRefreshNotifications());
  }

  void setWaterReminders(bool enabled) {
    state = state.copyWith(waterReminders: enabled);
    unawaited(_saveAndRefreshNotifications());
  }

  void setPhaseNotifications(bool enabled) {
    state = state.copyWith(phaseNotifications: enabled);
    unawaited(_saveAndRefreshNotifications());
  }

  void setSoundEnabled(bool enabled) {
    state = state.copyWith(soundEnabled: enabled);
    _save();
  }

  void setAnalyticsEnabled(bool enabled) {
    state = state.copyWith(analyticsEnabled: enabled);
    unawaited(AnalyticsService().setEnabled(enabled));
  }

  void setCalmGamification(bool enabled) {
    state = state.copyWith(calmGamification: enabled);
    _save();
  }

  void completeOnboarding() {
    state = state.copyWith(onboardingCompleted: true);
    _save();
  }

  void setSelectedPlan(String planId) {
    state = state.copyWith(selectedPlanId: planId);
    _save();
  }

  void setUserName(String name) {
    state = state.copyWith(userName: name);
    _save();
  }

  void setBodyInfo({
    double? height,
    double? weight,
    double? targetWeight,
    int? age,
    bool? isMale,
  }) {
    state = state.copyWith(
      height: height,
      weight: weight,
      targetWeight: targetWeight,
      age: age,
      isMale: isMale,
    );
    _save();
    // Queued after loading so older stored values cannot overwrite these.
    _bodyInfoWork = _bodyInfoWork.then((_) => _saveBodyInfo()).catchError((
      Object error,
    ) {
      debugPrint('Body info save failed: $error');
    });
  }

  void setLocale(String? locale) {
    state = state.copyWith(locale: locale);
    unawaited(_saveAndRefreshNotifications());
  }

  Future<void> _saveAndRefreshNotifications() async {
    await _save();
    final prefs = await SharedPreferences.getInstance();
    final notifications = NotificationService();
    final locale = state.locale ?? WidgetsBinding.instance.platformDispatcher.locale.toLanguageTag();
    notifications.setLocale(locale);
    if (!state.notificationsEnabled) {
      await notifications.cancelAll();
      return;
    }
    final active = prefs.getBool('fasting_active') ?? false;
    final startMs = prefs.getInt('fasting_start_time');
    final targetMinutes = prefs.getInt('fasting_target_minutes');
    final planName = prefs.getString('fasting_plan_name');
    if (!active || startMs == null || targetMinutes == null || planName == null) return;
    await notifications.scheduleFastingNotifications(
      startTime: DateTime.fromMillisecondsSinceEpoch(startMs),
      targetMinutes: targetMinutes,
      planName: planName,
      phaseNotifications: state.phaseNotifications,
      waterReminders: state.waterReminders,
    );
    await notifications.showActiveFastingNotification(
      planName: planName,
      targetMinutes: targetMinutes,
    );
  }
}

const _unset = Object();
const _bodyInfoKeys = ['height', 'weight', 'targetWeight', 'age'];

String _databaseKey(String key) => 'body_$key';

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  return SettingsNotifier(() => ref.read(databaseProvider));
});
