import 'package:flutter/foundation.dart';
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
  final locale = prefs.getString('locale') ?? 'tr';

  if (!isActive || startTimeMs == null || targetMinutes == null) return;

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
  final isTr = locale == 'tr';
  final remainingStr = isTr ? '${h}s ${m}dk' : '${h}h ${m}m';

  final elapsedHours = elapsed.inMinutes / 60;
  String phase;
  if (elapsedHours < 4) {
    phase = isTr ? 'Anabolik' : 'Anabolic';
  } else if (elapsedHours < 8) {
    phase = isTr ? 'Katabolik' : 'Catabolic';
  } else if (elapsedHours < 12) {
    phase = isTr ? 'Yağ Yakımı' : 'Fat Burning';
  } else if (elapsedHours < 18) {
    phase = isTr ? 'Ketozis' : 'Ketosis';
  } else {
    phase = isTr ? 'Otofaji' : 'Autophagy';
  }

  final notifService = NotificationService();
  await notifService.initialize();
  notifService.setLocale(locale);
  await notifService.updateOngoingNotification(
    remaining: remainingStr,
    phase: phase,
  );
}

class BackgroundService {
  static final BackgroundService _instance = BackgroundService._();
  factory BackgroundService() => _instance;
  BackgroundService._();

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );

    _initialized = true;
  }

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
      constraints: Constraints(
        networkType: NetworkType.not_required,
      ),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );

    // Bildirimleri zamanla
    final locale = prefs.getString('locale') ?? 'tr';
    final notifService = NotificationService();
    notifService.setLocale(locale);
    await notifService.scheduleFastingNotifications(
      startTime: startTime,
      targetMinutes: targetMinutes,
      planName: planName,
    );

    // Ongoing bildirim göster
    final isTr = locale == 'tr';
    await notifService.showOngoingNotification(
      title: isTr ? 'Oruç Başladı - $planName' : 'Fasting Started - $planName',
      body: isTr ? 'Hedef: ${targetMinutes ~/ 60} saat' : 'Target: ${targetMinutes ~/ 60} hours',
    );
  }

  Future<void> stopFastingTimer() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('fasting_active', false);

    await Workmanager().cancelByUniqueName(_uniqueName);

    final notifService = NotificationService();
    await notifService.cancelOngoing();
    await notifService.cancelAll();
  }

  Future<Map<String, dynamic>?> getActiveFasting() async {
    final prefs = await SharedPreferences.getInstance();
    final isActive = prefs.getBool('fasting_active') ?? false;

    if (!isActive) return null;

    final startTimeMs = prefs.getInt('fasting_start_time');
    final targetMinutes = prefs.getInt('fasting_target_minutes');
    final planName = prefs.getString('fasting_plan_name');

    if (startTimeMs == null || targetMinutes == null) return null;

    return {
      'startTime': DateTime.fromMillisecondsSinceEpoch(startTimeMs),
      'targetMinutes': targetMinutes,
      'planName': planName,
    };
  }
}
