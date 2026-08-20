import 'package:fasting_app/shared/widgets/fasting_art_slot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const darkPath = 'assets/images/editorial/v4/meal-window.webp';
  const lightPath = 'assets/images/editorial/v4/meal-window-light.webp';

  test('theme resolver selects physical dawn and vigil files', () {
    expect(themedEditorialAssetPath(darkPath, Brightness.dark), darkPath);
    expect(themedEditorialAssetPath(darkPath, Brightness.light), lightPath);
  });

  Widget subject(Brightness brightness) => MaterialApp(
    theme: ThemeData(brightness: brightness),
    home: const Scaffold(
      body: FastingArtSlot(
        assetPath: darkPath,
        height: 180,
        variant: FastingArtVariant.row,
        child: SizedBox.shrink(),
      ),
    ),
  );

  testWidgets('theme loads the matching physical artwork pair', (tester) async {
    for (final (brightness, expectedPath) in [
      (Brightness.dark, darkPath),
      (Brightness.light, lightPath),
    ]) {
      await tester.pumpWidget(subject(brightness));
      final image = tester.widget<Image>(
        find.descendant(
          of: find.byType(FastingArtSlot),
          matching: find.byType(Image),
        ),
      );
      expect((image.image as AssetImage).assetName, expectedPath);
    }
  });

  testWidgets('paired artwork stays full-bleed in both themes', (tester) async {
    for (final brightness in Brightness.values) {
      await tester.pumpWidget(subject(brightness));
      expect(
        find.descendant(
          of: find.byType(FastingArtSlot),
          matching: find.byType(FractionallySizedBox),
        ),
        findsNothing,
      );
    }
  });

  testWidgets('light mode renders artwork without a scrim layer', (
    tester,
  ) async {
    await tester.pumpWidget(subject(Brightness.light));
    final stack = tester.widget<Stack>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Stack),
      ),
    );
    expect(stack.children, hasLength(2));
  });
}
