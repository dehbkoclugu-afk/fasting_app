import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  Future<void>? _initializing;
  VoidCallback? _notificationTapHandler;
  bool _pendingNotificationTap = false;
  String _locale = 'tr';

  static const _channelId = 'fasting_channel';
  String get _channelName => _l10n.profile_notifications;
  String get _channelDesc => _l10n.profile_phaseNotifications;

  void setLocale(String locale) => _locale = locale;
  set notificationTapHandler(VoidCallback? handler) {
    _notificationTapHandler = handler;
    if (handler != null && _pendingNotificationTap) {
      _pendingNotificationTap = false;
      WidgetsBinding.instance.addPostFrameCallback((_) => handler());
    }
  }

  AppLocalizations get _l10n => lookupAppLocalizations(_localeFromTag(_locale));

  // Notification IDs
  static const fastingStartId = 1;
  static const fastingEndId = 2;
  static const phaseChangeId = 10; // 10-13 reserved for metabolic phases
  static const halfwayId = 4;
  static const windowClosingId = 5;
  static const waterReminderId = 100; // 100-199 for water
  static const streakId = 200;

  Future<void> initialize() async {
    if (_initialized) return;
    final pending = _initializing;
    if (pending != null) {
      await pending;
      return;
    }

    final future = _initialize();
    _initializing = future;
    try {
      await future;
    } finally {
      _initializing = null;
    }
  }

  Future<void> _initialize() async {
    try {
      tz_data.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings(
        '@drawable/notification_icon',
      );
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );
      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _plugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      final launchDetails = await _plugin.getNotificationAppLaunchDetails();
      _pendingNotificationTap =
          launchDetails?.didNotificationLaunchApp ?? false;
      _initialized = true;
    } catch (error) {
      debugPrint('Notification initialization failed: $error');
    }
  }

  Future<bool> requestPermission() async {
    await initialize();
    if (!_initialized) return false;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();
      return result ?? false;
    }

    return false;
  }

  // Oruç başladığında zamanlanan bildirimler
  Future<void> scheduleFastingNotifications({
    required DateTime startTime,
    required int targetMinutes,
    required String planName,
    bool phaseNotifications = true,
    bool waterReminders = true,
  }) async {
    await initialize();
    if (!_initialized) return;

    // Keep the persistent timer notification alive while preferences are
    // refreshed; replace only the scheduled fasting reminders.
    await _cancelScheduledFastingNotifications();

    final targetDuration = Duration(minutes: targetMinutes);
    final endTime = startTime.add(targetDuration);
    final halfTime = startTime.add(targetDuration ~/ 2);
    final now = DateTime.now();

    // Yarı yol bildirimi
    if (halfTime.isAfter(now)) {
      await _scheduleNotification(
        id: halfwayId,
        title: _l10n.notification_halfwayTitle,
        body: _l10n.notification_halfwayBody(planName),
        scheduledTime: halfTime,
      );
    }

    // Faz geçiş bildirimleri
    final phaseHours = [4, 8, 12, 18];
    if (phaseNotifications) {
      for (int i = 0; i < phaseHours.length; i++) {
        final phaseTime = startTime.add(Duration(hours: phaseHours[i]));
        if (phaseTime.isAfter(now) && phaseTime.isBefore(endTime)) {
          final phaseNames = [
            _l10n.notification_phaseCatabolic,
            _l10n.notification_phaseFatBurning,
            _l10n.notification_phaseKetosis,
            _l10n.notification_phaseAutophagy,
          ];
          await _scheduleNotification(
            id: phaseChangeId + i,
            title: phaseNames[i],
            body: _getPhaseDescription(i),
            scheduledTime: phaseTime,
          );
        }
      }
    }

    // Oruç bitiş bildirimi
    if (endTime.isAfter(now)) {
      await _scheduleNotification(
        id: fastingEndId,
        title: _l10n.timer_completed,
        body: _l10n.notification_completedBody(planName),
        scheduledTime: endTime,
      );
    }

    // Su hatırlatmaları (her 2 saatte)
    if (waterReminders) {
      for (int i = 1; i <= 12; i++) {
        final waterTime = startTime.add(Duration(hours: i * 2));
        if (waterTime.isAfter(now) && waterTime.isBefore(endTime)) {
          await _scheduleNotification(
            id: waterReminderId + i,
            title: _l10n.notification_waterTitle,
            body: _l10n.notification_waterBody,
            scheduledTime: waterTime,
          );
        }
      }
    }
  }

  // Yemek penceresi kapanma bildirimi
  Future<void> scheduleWindowClosing({required DateTime closingTime}) async {
    await initialize();
    if (!_initialized) return;
    final warningTime = closingTime.subtract(const Duration(minutes: 30));
    if (warningTime.isAfter(DateTime.now())) {
      await _scheduleNotification(
        id: windowClosingId,
        title: _l10n.notification_windowTitle,
        body: _l10n.notification_windowBody,
        scheduledTime: warningTime,
      );
    }
  }

  // Streak bildirimi (sabah)
  Future<void> scheduleStreakNotification({
    required int streakDays,
    required DateTime morningTime,
  }) async {
    await initialize();
    if (!_initialized) return;
    if (morningTime.isAfter(DateTime.now())) {
      await _scheduleNotification(
        id: streakId,
        title: _l10n.notification_streakTitle(streakDays),
        body: _l10n.notification_streakBody,
        scheduledTime: morningTime,
      );
    }
  }

  // Aktif oruç sırasında gösterilen persistent bildirim
  Future<void> showOngoingNotification({
    required String title,
    required String body,
  }) async {
    await initialize();
    if (!_initialized) return;
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.low,
      priority: Priority.low,
      ongoing: true,
      autoCancel: false,
      showWhen: false,
      category: AndroidNotificationCategory.progress,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
      ),
    );

    await _plugin.show(fastingStartId, title, body, details);
  }

  Future<void> updateOngoingNotification({
    required String remaining,
    required String phase,
  }) async {
    await showOngoingNotification(
      title: _l10n.notification_ongoingTitle(phase),
      body: _l10n.notification_remaining(remaining),
    );
  }

  Future<void> showActiveFastingNotification({
    required String planName,
    required int targetMinutes,
  }) async {
    await showOngoingNotification(
      title: _l10n.notification_started(planName),
      body: _l10n.notification_target(targetMinutes ~/ 60),
    );
  }

  Future<void> cancelOngoing() async {
    await initialize();
    if (!_initialized) return;
    await _plugin.cancel(fastingStartId);
  }

  Future<void> cancelFastingNotifications() async {
    await initialize();
    if (!_initialized) return;
    await _plugin.cancel(fastingStartId);
    await _cancelScheduledFastingNotifications();
  }

  Future<void> cancelAll() async {
    await initialize();
    if (!_initialized) return;
    await _plugin.cancelAll();
  }

  Future<void> _cancelScheduledFastingNotifications() async {
    await _plugin.cancel(fastingEndId);
    await _plugin.cancel(halfwayId);
    await _plugin.cancel(windowClosingId);
    // Also clear the legacy 3-6 range used before phase IDs were separated
    // from the eating-window notification.
    for (var id = 3; id <= 6; id++) {
      await _plugin.cancel(id);
    }
    for (var id = phaseChangeId; id < phaseChangeId + 4; id++) {
      await _plugin.cancel(id);
    }
    for (var id = waterReminderId + 1; id <= waterReminderId + 12; id++) {
      await _plugin.cancel(id);
    }
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.high,
      priority: Priority.high,
      category: AndroidNotificationCategory.reminder,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void _onNotificationTapped(NotificationResponse response) {
    final handler = _notificationTapHandler;
    if (handler != null) {
      handler();
    } else {
      _pendingNotificationTap = true;
    }
  }

  String _getPhaseDescription(int index) {
    final descriptions = [
      _l10n.phase_catabolicDesc,
      _l10n.phase_fatBurningDesc,
      _l10n.phase_ketosisDesc,
      _l10n.phase_autophagyDesc,
    ];
    return descriptions[index];
  }
}

Locale _localeFromTag(String tag) {
  final parts = tag.replaceAll('-', '_').split('_');
  final language = parts.first.toLowerCase();
  final country = parts.length > 1 ? parts[1].toUpperCase() : null;
  for (final locale in AppLocalizations.supportedLocales) {
    if (locale.languageCode == language && locale.countryCode == country) {
      return locale;
    }
  }
  for (final locale in AppLocalizations.supportedLocales) {
    if (locale.languageCode == language && locale.countryCode == null) {
      return locale;
    }
  }
  return const Locale('en');
}
