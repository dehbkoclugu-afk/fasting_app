import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'app.dart';
import 'core/config/build_config.dart';
import 'features/meals/providers/food_scan_provider.dart';
import 'services/notification_service.dart';
import 'services/background_service.dart';
import 'services/revenue_cat_service.dart';
import 'services/admob_service.dart';
import 'services/widget_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Android can destroy MainActivity while the system camera is open. Recover
  // the photo before building the router so the user returns to the analysis
  // screen instead of silently landing on the home tab.
  Uint8List? recoveredFoodImage;
  String? recoveredFoodImageMimeType;
  if (Platform.isAndroid && BuildConfig.isFoodScanEnabled) {
    try {
      final lostData = await ImagePicker().retrieveLostData();
      final files = lostData.files;
      final file =
          lostData.file ??
          (files != null && files.isNotEmpty ? files.first : null);
      if (file != null) {
        final bytes = await readFoodPhoto(file);
        recoveredFoodImage = bytes;
        recoveredFoodImageMimeType = detectImageMimeType(
          bytes,
          reportedMimeType: file.mimeType,
          path: file.path,
        );
      } else if (lostData.exception != null) {
        debugPrint('Could not recover camera photo: ${lostData.exception}');
      }
    } catch (e) {
      debugPrint('Lost camera photo recovery failed: $e');
    }
  }

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Read the small amount of state required to choose the first route. Optional
  // SDKs are deliberately started only after the first frame: a broken ads,
  // notifications, billing or widget plugin must never strand the app on its
  // native splash screen.
  SharedPreferences? prefs;
  try {
    prefs = await SharedPreferences.getInstance().timeout(
      const Duration(seconds: 2),
    );
  } catch (error) {
    debugPrint('Startup preferences unavailable: $error');
  }
  NotificationService().setLocale(
    prefs?.getString('locale') ??
        WidgetsBinding.instance.platformDispatcher.locale.toLanguageTag(),
  );
  final onboardingCompleted = prefs?.getBool('onboardingCompleted') ?? false;

  runApp(
    ProviderScope(
      child: FastingApp(
        showOnboarding: !onboardingCompleted,
        recoveredFoodImage: recoveredFoodImage,
        recoveredFoodImageMimeType: recoveredFoodImageMimeType,
      ),
    ),
  );

  unawaited(_initializeOptionalServices());
}

Future<void> _initializeOptionalServices() async {
  await _runOptional(
    'orientation lock',
    () => SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),
  );
  await _runOptional('notifications', NotificationService().initialize);
  await _runOptional('background timer', BackgroundService().initialize);
  await _runOptional('purchases', RevenueCatService().initialize);

  if (Platform.isIOS) {
    await Future.delayed(const Duration(milliseconds: 200));
    await _runOptional(
      'tracking authorization',
      AppTrackingTransparency.requestTrackingAuthorization,
    );
  }

  await _runOptional('ads', AdmobService().initialize);
  await _runOptional('home widget', WidgetService().initialize);
}

Future<void> _runOptional(
  String name,
  Future<dynamic> Function() initialize,
) async {
  try {
    await initialize().timeout(const Duration(seconds: 12));
  } catch (error) {
    debugPrint('Optional $name initialization failed: $error');
  }
}
