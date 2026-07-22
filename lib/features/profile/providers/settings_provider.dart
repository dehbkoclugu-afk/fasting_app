import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  final ThemeMode themeMode;
  final bool notificationsEnabled;
  final bool waterReminders;
  final bool phaseNotifications;
  final bool soundEnabled;
  final bool calmGamification;
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
  SettingsNotifier() : super(const AppSettings()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppSettings(
      themeMode: ThemeMode.values[prefs.getInt('themeMode') ?? 0],
      notificationsEnabled: prefs.getBool('notificationsEnabled') ?? true,
      waterReminders: prefs.getBool('waterReminders') ?? true,
      phaseNotifications: prefs.getBool('phaseNotifications') ?? true,
      soundEnabled: prefs.getBool('sound_enabled') ?? false,
      calmGamification: prefs.getBool('calm_gamification') ?? false,
      onboardingCompleted: prefs.getBool('onboardingCompleted') ?? false,
      selectedPlanId: prefs.getString('selectedPlanId') ?? '16_8',
      userName: prefs.getString('userName') ?? '',
      height: prefs.getDouble('height'),
      weight: prefs.getDouble('weight'),
      targetWeight: prefs.getDouble('targetWeight'),
      age: prefs.getInt('age'),
      isMale: prefs.getBool('isMale') ?? true,
      locale: prefs.getString('locale'),
    );
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
    if (state.height != null) await prefs.setDouble('height', state.height!);
    if (state.weight != null) await prefs.setDouble('weight', state.weight!);
    if (state.targetWeight != null) {
      await prefs.setDouble('targetWeight', state.targetWeight!);
    }
    if (state.age != null) await prefs.setInt('age', state.age!);
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
    _save();
  }

  void setWaterReminders(bool enabled) {
    state = state.copyWith(waterReminders: enabled);
    _save();
  }

  void setPhaseNotifications(bool enabled) {
    state = state.copyWith(phaseNotifications: enabled);
    _save();
  }

  void setSoundEnabled(bool enabled) {
    state = state.copyWith(soundEnabled: enabled);
    _save();
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
  }

  void setLocale(String? locale) {
    state = state.copyWith(locale: locale);
    _save();
  }
}

const _unset = Object();

final settingsProvider = StateNotifierProvider<SettingsNotifier, AppSettings>((
  ref,
) {
  return SettingsNotifier();
});
