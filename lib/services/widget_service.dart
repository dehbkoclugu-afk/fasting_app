import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'notification_service.dart';

abstract interface class FastingWidgetService {
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  });

  Future<void> updateIdleWidget();
}

/// Service to update the home screen widget with current fasting status
class WidgetService implements FastingWidgetService {
  static final WidgetService _instance = WidgetService._();
  WidgetService._();
  factory WidgetService() => _instance;

  // iOS widget group identifier (must match App Group in Xcode)
  static const _appGroupId = 'group.com.fasttrack.widget';
  // Android widget class name
  static const _androidWidgetName = 'FastingWidgetProvider';

  Future<void> initialize() async {
    try {
      await HomeWidget.setAppGroupId(_appGroupId);
    } catch (e) {
      debugPrint('WidgetService init error: $e');
    }
  }

  /// Update the widget with current fasting state. It only refreshes when the
  /// app or the background worker runs, so it shows no ticking seconds.
  @override
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final l10n = lookupAppLocalizations(
        resolveNotificationLocale(
          prefs.getString('locale') ??
              PlatformDispatcher.instance.locale.languageCode,
        ),
      );
      await Future.wait([
        HomeWidget.saveWidgetData<String>(
          'status_fasting',
          l10n.meals_windowFasting,
        ),
        HomeWidget.saveWidgetData<String>(
          'status_idle',
          l10n.widget_notFasting,
        ),
        HomeWidget.saveWidgetData<String>('idle_hint', l10n.widget_tapToStart),
        HomeWidget.saveWidgetData<bool>('is_fasting', isFasting),
        HomeWidget.saveWidgetData<String>('plan_name', planName),
        HomeWidget.saveWidgetData<String>('remaining_time', remainingTime),
        HomeWidget.saveWidgetData<double>('progress', progress),
        HomeWidget.saveWidgetData<String>('phase_name', phaseName),
      ]);
      await HomeWidget.updateWidget(
        androidName: _androidWidgetName,
        iOSName: 'FastingWidget',
      );
    } catch (e) {
      debugPrint('WidgetService update error: $e');
    }
  }

  /// Update widget to show idle state
  @override
  Future<void> updateIdleWidget() async {
    await updateWidget(
      isFasting: false,
      planName: '',
      remainingTime: '--:--:--',
      progress: 0,
      phaseName: '',
    );
  }
}

/// Hours and minutes left, as the home widget shows them.
String widgetTime(Duration remaining) {
  final minutes = (remaining.inMinutes % 60).toString().padLeft(2, '0');
  return '${remaining.inHours}:$minutes';
}
