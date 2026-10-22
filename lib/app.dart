import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/providers/settings_provider.dart';
import 'services/notification_service.dart';

Locale? _localeFromTag(String? tag) {
  if (tag == null) return null;
  final parts = tag.replaceAll('-', '_').split('_');
  return Locale.fromSubtags(
    languageCode: parts.first,
    countryCode: parts.length > 1 ? parts[1] : null,
  );
}

class FastingApp extends ConsumerStatefulWidget {
  final bool showOnboarding;
  final Uint8List? recoveredFoodImage;
  final String? recoveredFoodImageMimeType;

  const FastingApp({
    super.key,
    required this.showOnboarding,
    this.recoveredFoodImage,
    this.recoveredFoodImageMimeType,
  });

  @override
  ConsumerState<FastingApp> createState() => _FastingAppState();
}

class _FastingAppState extends ConsumerState<FastingApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Router'ı bir kez oluştur, settings değişikliklerinde yeniden oluşturma
    _router = AppRouter.router(
      showOnboarding: widget.showOnboarding,
      recoveredFoodImage: widget.recoveredFoodImage,
      recoveredFoodImageMimeType: widget.recoveredFoodImageMimeType,
    );
    NotificationService().notificationTapHandler = () => _router.go('/timer');
  }

  @override
  void dispose() {
    NotificationService().notificationTapHandler = null;
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      locale: _localeFromTag(settings.locale),
      localeListResolutionCallback: (deviceLocales, supportedLocales) {
        if (settings.locale != null) return _localeFromTag(settings.locale);

        final devices = deviceLocales ?? const <Locale>[];
        for (final deviceLocale in devices) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale == deviceLocale) return supportedLocale;
          }
        }
        for (final deviceLocale in devices) {
          for (final supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == deviceLocale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return const Locale('en');
      },
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: _router,
    );
  }
}
