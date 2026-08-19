import 'package:fasting_app/shared/widgets/fasting_art_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget subject(Brightness brightness) => MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: Scaffold(
      body: FastingArtSlot(
        assetPath: 'assets/images/editorial/missing-test-art.webp',
        height: 180,
        child: const SizedBox.shrink(),
      ),
    ),
  );

  testWidgets('dark mode keeps the original vigil artwork', (tester) async {
    await tester.pumpWidget(subject(Brightness.dark));

    final slot = find.byType(FastingArtSlot);
    expect(
      find.descendant(of: slot, matching: find.byType(ColorFiltered)),
      findsNothing,
    );
    expect(
      find.descendant(of: slot, matching: find.byType(Opacity)),
      findsNothing,
    );
  });

  testWidgets('light mode renders the warm dawn artwork treatment', (
    tester,
  ) async {
    await tester.pumpWidget(subject(Brightness.light));

    final slot = find.byType(FastingArtSlot);
    final filteredArt = find.descendant(
      of: slot,
      matching: find.byType(ColorFiltered),
    );
    final filter = tester.widget<ColorFiltered>(filteredArt);
    expect(filter.colorFilter, isNotNull);
    expect(
      find.descendant(of: slot, matching: find.byType(Opacity)),
      findsOneWidget,
    );
  });
}
