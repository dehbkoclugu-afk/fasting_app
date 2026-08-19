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
        child: SizedBox.shrink(),
      ),
    ),
  );

  testWidgets('dark mode loads the vigil asset', (tester) async {
    await tester.pumpWidget(subject(Brightness.dark));

    final image = tester.widget<Image>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Image),
      ),
    );
    expect((image.image as AssetImage).assetName, darkPath);
  });

  testWidgets('light mode loads the physical dawn asset', (tester) async {
    await tester.pumpWidget(subject(Brightness.light));

    final image = tester.widget<Image>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Image),
      ),
    );
    expect((image.image as AssetImage).assetName, lightPath);
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
