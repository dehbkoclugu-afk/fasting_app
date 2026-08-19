import 'dart:io';
import 'dart:typed_data';

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
      final file = lostData.file ??
          (files != null && files.isNotEmpty ? files.first : null);
      if (file != null) {
        final bytes = await file.readAsBytes();
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

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  // Servisleri başlat
  await NotificationService().initialize();
  await BackgroundService().initialize();
  await RevenueCatService().initialize();
  // iOS App Tracking Transparency: must prompt before using tracking data for ads.
  // ponytail: 200ms delay lets the app become active so the system prompt shows.
  if (Platform.isIOS) {
    await Future.delayed(const Duration(milliseconds: 200));
    await AppTrackingTransparency.requestTrackingAuthorization();
  }
  await AdmobService().initialize();
  await WidgetService().initialize();

  // Onboarding durumunu başlangıçta oku (router oluşmadan önce)
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  runApp(
    ProviderScope(
      child: FastingApp(
        showOnboarding: !onboardingCompleted,
        recoveredFoodImage: recoveredFoodImage,
        recoveredFoodImageMimeType: recoveredFoodImageMimeType,
      ),
    ),
  );
}
