import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'notification_service.dart';

const _taskName = 'fastingTimerUpdate';
const _uniqueName = 'com.dehbkoclugu.fasting.timer';

// Top-level function required by workmanager
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      if (task == _taskName) {
        await _updateTimerNotification();
      }
      return true;
    } catch (e) {
      debugPrint('Background task error: $e');
      return false;
    }
  });
}

Future<void> _updateTimerNotification() async {
  final prefs = await SharedPreferences.getInstance();
  final startTimeMs = prefs.getInt('fasting_start_time');
  final targetMinutes = prefs.getInt('fasting_target_minutes');
  final isActive = prefs.getBool('fasting_active') ?? false;
  final notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
  final locale = _resolveLocale(prefs);
  final l10n = lookupAppLocalizations(_localeFromTag(locale));

  if (!isActive || !notificationsEnabled || startTimeMs == null || targetMinutes == null) return;

  final startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMs);
  final elapsed = DateTime.now().difference(startTime);
  final remaining = Duration(minutes: targetMinutes) - elapsed;

  if (remaining.isNegative) {
    await prefs.setBool('fasting_active', false);
    final notifService = NotificationService();
    await notifService.initialize();
    await notifService.cancelOngoing();
    return;
  }

  final h = remaining.inHours;
  final m = remaining.inMinutes % 60;
  final remainingStr = l10n.notification_time(h, m);

  final elapsedHours = elapsed.inMinutes / 60;
  String phase;
  if (elapsedHours < 4) {
    phase = l10n.phase_anabolic;
  } else if (elapsedHours < 8) {
    phase = l10n.phase_catabolic;
  } else if (elapsedHours < 12) {
    phase = l10n.phase_fatBurning;
  } else if (elapsedHours < 18) {
    phase = l10n.phase_ketosis;
  } else {
    phase = l10n.phase_autophagy;
  }

  final notifService = NotificationService();
  await notifService.initialize();
  notifService.setLocale(locale);
  await notifService.updateOngoingNotification(
    remaining: remainingStr,
    phase: phase,
  );
}

abstract interface class FastingTimerService {
  Future<void> startFastingTimer({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
  });

  Future<void> stopFastingTimer();
}

class BackgroundService implements FastingTimerService {
  static final BackgroundService _instance = BackgroundService._();
  factory BackgroundService() => _instance;
  BackgroundService._();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

    _initialized = true;
  }

  @override
  Future<void> startFastingTimer({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
  }) async {
    // SharedPreferences'a kaydet (background task erişimi için)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fasting_start_time', startTime.millisecondsSinceEpoch);
    await prefs.setInt('fasting_target_minutes', targetMinutes);
    await prefs.setBool('fasting_active', true);
    await prefs.setString('fasting_plan_name', planName);

    // Periyodik background task başlat (15 dk minimum interval)
    await Workmanager().registerPeriodicTask(
      _uniqueName,
      _taskName,
      frequency: const Duration(minutes: 15),
      constraints: Constraints(networkType: NetworkType.not_required),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );

    // Bildirimleri zamanla
    final notificationsEnabled = prefs.getBool('notificationsEnabled') ?? true;
    if (!notificationsEnabled) {
      await NotificationService().cancelAll();
      return;
    }
    final locale = _resolveLocale(prefs);
    final l10n = lookupAppLocalizations(_localeFromTag(locale));
    final notifService = NotificationService();
    notifService.setLocale(locale);
    await notifService.scheduleFastingNotifications(
      startTime: startTime,
      targetMinutes: targetMinutes,
      planName: planName,
      phaseNotifications: prefs.getBool('phaseNotifications') ?? true,
      waterReminders: prefs.getBool('waterReminders') ?? true,
    );

    // Ongoing bildirim göster
    await notifService.showOngoingNotification(
      title: l10n.notification_started(planName),
      body: l10n.notification_target(targetMinutes ~/ 60),
    );
  }

  @override
  Future<void> stopFastingTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fasting_active', false);

    await Workmanager().cancelByUniqueName(_uniqueName);

    final notifService = NotificationService();
    await notifService.cancelOngoing();
    await notifService.cancelAll();
  }
}

String _resolveLocale(SharedPreferences prefs) {
  return
      prefs.getString('locale') ??
      PlatformDispatcher.instance.locale.languageCode;
}

Locale _localeFromTag(String tag) {
  final parts = tag.replaceAll('-', '_').split('_');
  return Locale.fromSubtags(languageCode: parts.first, countryCode: parts.length > 1 ? parts[1] : null);
}
