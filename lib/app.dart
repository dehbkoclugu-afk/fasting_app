import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/profile/providers/settings_provider.dart';
import 'services/notification_service.dart';

class FastingApp extends ConsumerStatefulWidget {
  final bool showOnboarding;

  const FastingApp({super.key, required this.showOnboarding});

  @override
  ConsumerState<FastingApp> createState() => _FastingAppState();
}

class _FastingAppState extends ConsumerState<FastingApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Router'ı bir kez oluştur, settings değişikliklerinde yeniden oluşturma
    _router = AppRouter.router(showOnboarding: widget.showOnboarding);
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
      locale: settings.locale == null ? null : Locale(settings.locale!),
      localeListResolutionCallback: (deviceLocales, supportedLocales) {
        if (settings.locale != null) return Locale(settings.locale!);

        for (final deviceLocale in deviceLocales ?? const <Locale>[]) {
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
