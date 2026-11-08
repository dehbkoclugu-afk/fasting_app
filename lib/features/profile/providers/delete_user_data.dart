import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/analytics_service.dart';
import '../../../services/notification_service.dart';
import '../../../services/widget_service.dart';
import '../../gamification/providers/gamification_provider.dart';
import '../../meals/providers/meal_provider.dart';
import '../../meals/providers/food_scan_provider.dart';
import '../../stats/providers/stats_provider.dart';
import '../../timer/providers/fasting_session_provider.dart';
import '../../timer/providers/timer_provider.dart';
import '../../timer/providers/water_provider.dart';
import 'settings_provider.dart';

/// Erases everything this app holds on the device. Subscriptions live in the
/// store account and come back through RevenueCat.
Future<void> deleteAllUserData(WidgetRef ref) async {
  // Dispose in-flight analysis before clearing its quota and consent data.
  ref.invalidate(foodScanProvider);
  await ref.read(timerProvider.notifier).endFastQuietly();
  await ref.read(databaseProvider).deleteAllUserData();
  await AnalyticsService().setEnabled(false);
  await (await SharedPreferences.getInstance()).clear();

  // The erasure already succeeded; a stale notification or widget is cosmetic.
  try {
    await NotificationService().cancelAll();
  } catch (error) {
    debugPrint('Post-erasure notification cleanup failed: $error');
  }
  try {
    await WidgetService().updateIdleWidget();
  } catch (error) {
    debugPrint('Post-erasure widget cleanup failed: $error');
  }

  invalidateGamification(ref);
  ref
    ..invalidate(settingsProvider)
    ..invalidate(timerProvider)
    ..invalidate(waterProvider)
    ..invalidate(mealProvider)
    ..invalidate(fastingSessionProvider)
    ..invalidate(statsProvider)
    ..invalidate(latestWeightProvider)
    ..invalidate(weightHistoryProvider)
    ..invalidate(heatmapProvider);
}
