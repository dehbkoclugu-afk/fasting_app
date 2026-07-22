import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app.dart';
import 'services/notification_service.dart';
import 'services/background_service.dart';
import 'services/revenue_cat_service.dart';
import 'services/admob_service.dart';
import 'services/widget_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  await AdmobService().initialize();
  await WidgetService().initialize();

  // Onboarding durumunu başlangıçta oku (router oluşmadan önce)
  final prefs = await SharedPreferences.getInstance();
  final onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;

  runApp(
    ProviderScope(child: FastingApp(showOnboarding: !onboardingCompleted)),
  );
}
