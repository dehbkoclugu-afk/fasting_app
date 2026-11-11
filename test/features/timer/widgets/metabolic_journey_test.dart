import 'package:fasting_app/features/timer/widgets/metabolic_journey.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pumpJourney(
  WidgetTester tester, {
  required double elapsedHours,
  required double targetHours,
}) => tester.pumpWidget(
  MaterialApp(
    locale: const Locale('en'),
    supportedLocales: AppLocalizations.supportedLocales,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: Scaffold(
      body: SingleChildScrollView(
        child: MetabolicJourney(
          elapsedHours: elapsedHours,
          targetHours: targetHours,
          startTime: DateTime(2026, 11, 11, 8),
        ),
      ),
    ),
  ),
);

void main() {
  testWidgets('counts down to the next phase inside the plan', (tester) async {
    await pumpJourney(tester, elapsedHours: 10.5, targetHours: 16);
    expect(find.text('1 hours 30 minutes until Ketosis'), findsOneWidget);

    await pumpJourney(tester, elapsedHours: 11.99, targetHours: 16);
    expect(find.text('1 minutes until Ketosis'), findsOneWidget);
  });

  testWidgets('names no next phase beyond the plan target', (tester) async {
    await pumpJourney(tester, elapsedHours: 13, targetHours: 16);
    expect(find.textContaining('until'), findsNothing);
  });
}
