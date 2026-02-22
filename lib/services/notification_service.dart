import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._();
  factory NotificationService() => _instance;
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;
  String _locale = 'tr';

  static const _channelId = 'fasting_channel';
  static const _channelName = 'Fasting Notifications';
  static const _channelDesc = 'Fasting timer notifications';

  void setLocale(String locale) => _locale = locale;
  bool get _isTr => _locale == 'tr';

  // Notification IDs
  static const fastingStartId = 1;
  static const fastingEndId = 2;
  static const phaseChangeId = 3;
  static const halfwayId = 4;
  static const windowClosingId = 5;
  static const waterReminderId = 100; // 100-199 for water
  static const streakId = 200;

  Future<void> initialize() async {
    if (_initialized) return;

    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
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

    _initialized = true;
  }

  Future<bool> requestPermission() async {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return result ?? false;
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      final result = await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
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
  }) async {
    // Tüm mevcut bildirimleri iptal et
    await cancelAll();

    final targetDuration = Duration(minutes: targetMinutes);
    final endTime = startTime.add(targetDuration);
    final halfTime = startTime.add(targetDuration ~/ 2);
    final now = DateTime.now();

    // Yarı yol bildirimi
    if (halfTime.isAfter(now)) {
      await _scheduleNotification(
        id: halfwayId,
        title: _isTr ? 'Yarı Yoldasın! 💪' : 'Halfway There! 💪',
        body: _isTr
            ? '$planName orucunun yarısını tamamladın. Devam et!'
            : 'You completed half of your $planName fast. Keep going!',
        scheduledTime: halfTime,
      );
    }

    // Faz geçiş bildirimleri
    final phaseHours = [4, 8, 12, 18];
    for (int i = 0; i < phaseHours.length; i++) {
      final phaseTime = startTime.add(Duration(hours: phaseHours[i]));
      if (phaseTime.isAfter(now) && phaseTime.isBefore(endTime)) {
        final phaseNames = _isTr
            ? ['Katabolik faza geçtin 📉', 'Yağ Yakımı başladı! 🔥', 'Ketozis fazındasın ⚡', 'Otofaji aktif! 🔄']
            : ['Entered Catabolic phase 📉', 'Fat Burning started! 🔥', 'You\'re in Ketosis ⚡', 'Autophagy active! 🔄'];
        await _scheduleNotification(
          id: phaseChangeId + i,
          title: phaseNames[i],
          body: _getPhaseDescription(i),
          scheduledTime: phaseTime,
        );
      }
    }

    // Oruç bitiş bildirimi
    if (endTime.isAfter(now)) {
      await _scheduleNotification(
        id: fastingEndId,
        title: _isTr ? 'Tebrikler! 🎉' : 'Congratulations! 🎉',
        body: _isTr
            ? '$planName orucunu tamamladın! Yemek penceren açıldı.'
            : 'You completed your $planName fast! Your eating window is open.',
        scheduledTime: endTime,
      );
    }

    // Su hatırlatmaları (her 2 saatte)
    for (int i = 1; i <= 12; i++) {
      final waterTime = startTime.add(Duration(hours: i * 2));
      if (waterTime.isAfter(now) && waterTime.isBefore(endTime)) {
        await _scheduleNotification(
          id: waterReminderId + i,
          title: _isTr ? 'Su İç 💧' : 'Drink Water 💧',
          body: _isTr
              ? 'Oruç süresince bol su içmeyi unutma!'
              : 'Don\'t forget to drink plenty of water while fasting!',
          scheduledTime: waterTime,
        );
      }
    }
  }

  // Yemek penceresi kapanma bildirimi
  Future<void> scheduleWindowClosing({
    required DateTime closingTime,
  }) async {
    final warningTime = closingTime.subtract(const Duration(minutes: 30));
    if (warningTime.isAfter(DateTime.now())) {
      await _scheduleNotification(
        id: windowClosingId,
        title: _isTr ? 'Yemek Penceresi Kapanıyor ⏰' : 'Eating Window Closing ⏰',
        body: _isTr
            ? '30 dakika içinde yemek penceren kapanacak.'
            : 'Your eating window will close in 30 minutes.',
        scheduledTime: warningTime,
      );
    }
  }

  // Streak bildirimi (sabah)
  Future<void> scheduleStreakNotification({
    required int streakDays,
    required DateTime morningTime,
  }) async {
    if (morningTime.isAfter(DateTime.now())) {
      await _scheduleNotification(
        id: streakId,
        title: _isTr ? '$streakDays Günlük Seri! 🔥' : '$streakDays Day Streak! 🔥',
        body: _isTr
            ? 'Harika gidiyorsun! Bugün de devam et.'
            : 'You\'re doing great! Keep it up today.',
        scheduledTime: morningTime,
      );
    }
  }

  // Aktif oruç sırasında gösterilen persistent bildirim
  Future<void> showOngoingNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
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

    const details = NotificationDetails(
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
      title: _isTr ? 'Oruç Devam Ediyor - $phase' : 'Fasting In Progress - $phase',
      body: _isTr ? 'Kalan: $remaining' : 'Remaining: $remaining',
    );
  }

  Future<void> cancelOngoing() async {
    await _plugin.cancel(fastingStartId);
  }

  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidDetails = AndroidNotificationDetails(
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

    const details = NotificationDetails(
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
    // TODO: Navigate to timer screen
    debugPrint('Notification tapped: ${response.id}');
  }

  String _getPhaseDescription(int index) {
    final descriptions = _isTr
        ? [
            'Kan şekerin düşüyor, vücudun yağ yakmaya hazırlanıyor.',
            'Vücudun yağ depolarından enerji üretmeye başladı!',
            'Keton üretimi başladı, mental netlik artıyor.',
            'Hücre yenilenmesi aktif, hasarlı hücreler temizleniyor!',
          ]
        : [
            'Blood sugar is dropping, your body is preparing to burn fat.',
            'Your body started producing energy from fat stores!',
            'Ketone production started, mental clarity is improving.',
            'Cell renewal active, damaged cells are being cleaned!',
          ];
    return descriptions[index];
  }
}
