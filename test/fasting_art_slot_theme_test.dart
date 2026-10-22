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

  testWidgets('dark theme loads the vigil artwork', (tester) async {
    await tester.pumpWidget(subject(Brightness.dark));
    final images = tester.widgetList<Image>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Image),
      ),
    );
    expect(images, isNotEmpty);
    expect(
      images.map((image) => (image.image as AssetImage).assetName).toSet(),
      {darkPath},
    );
  });

  testWidgets('light theme loads the dawn artwork', (tester) async {
    await tester.pumpWidget(subject(Brightness.light));
    final images = tester.widgetList<Image>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Image),
      ),
    );
    expect(images, isNotEmpty);
    expect(
      images.map((image) => (image.image as AssetImage).assetName).toSet(),
      {lightPath},
    );
  });

  testWidgets('paired artwork renders a single full-bleed asset', (
    tester,
  ) async {
    await tester.pumpWidget(subject(Brightness.light));

    final images = tester.widgetList<Image>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Image),
      ),
    );
    expect(images, hasLength(1));
    expect(images.single.fit, BoxFit.cover);
    expect(find.byType(ShaderMask), findsNothing);
  });

  testWidgets('bare artwork keeps its original full-bleed rendering', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        home: const Scaffold(
          body: FastingArtSlot(
            assetPath: darkPath,
            height: 180,
            variant: FastingArtVariant.bare,
            useThemedAsset: false,
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );

    expect(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(FractionallySizedBox),
      ),
      findsNothing,
    );
  });

  testWidgets('light mode renders artwork without a scrim layer', (
    tester,
  ) async {
    await tester.pumpWidget(subject(Brightness.light));
    final stack = tester.widget<Stack>(
      find
          .descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(Stack),
          )
          .first,
    );
    expect(stack.children, hasLength(2));
  });
}
