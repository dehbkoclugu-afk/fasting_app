import 'package:fasting_app/features/stats/providers/stats_provider.dart';
import 'package:fasting_app/features/stats/screens/stats_screen.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  testWidgets('narrow Arabic stats use localized values at large text size', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          statsProvider.overrideWith(
            (ref, period) => const StatsData(
              totalSessions: 42,
              completionRate: .75,
              averageDurationHours: 1.5,
            ),
          ),
          heatmapProvider.overrideWith((ref, month) => const {}),
          weightHistoryProvider.overrideWith((ref) => const []),
        ],
        child: MaterialApp(
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(
              context,
            ).copyWith(textScaler: const TextScaler.linear(2)),
            child: child!,
          ),
          home: const StatsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text(NumberFormat.percentPattern('ar').format(.75)),
      findsOneWidget,
    );
    expect(
      find.text(NumberFormat.decimalPattern('ar').format(42)),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
