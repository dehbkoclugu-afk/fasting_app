import 'package:fasting_app/features/timer/widgets/fasting_ring.dart';
import 'package:flutter/material.dart';
import 'package:fasting_app/l10n/generated/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows only metabolic phases inside the selected plan', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        locale: Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: Scaffold(
          body: Center(
            child: FastingRing(
              progress: .56,
              elapsedHours: 9,
              targetHours: 16,
              phaseColors: [Colors.red, Colors.pink],
              child: SizedBox.shrink(),
            ),
          ),
        ),
      ),
    );

    expect(find.text('0h'), findsOneWidget);
    expect(find.text('4h'), findsOneWidget);
    expect(find.text('8h'), findsOneWidget);
    expect(find.text('12h'), findsOneWidget);
    expect(find.text('18h'), findsNothing);

    await tester.tap(find.text('8h'));
    await tester.pumpAndSettle();

    expect(find.text('Fat Burning'), findsOneWidget);
    expect(find.text('Hours 8–12'), findsOneWidget);
  });
}
