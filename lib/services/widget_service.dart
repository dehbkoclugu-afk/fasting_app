import 'package:flutter/foundation.dart';
import 'package:home_widget/home_widget.dart';

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

  /// Update the widget with current fasting state
  @override
  Future<void> updateWidget({
    required bool isFasting,
    required String planName,
    required String remainingTime,
    required double progress,
    required String phaseName,
  }) async {
    try {
      await Future.wait([
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
