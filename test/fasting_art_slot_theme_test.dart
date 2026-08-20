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

  testWidgets('paired artwork uses a feathered copy-safe right lane', (
    tester,
  ) async {
    await tester.pumpWidget(subject(Brightness.light));

    final lane = tester.widget<FractionallySizedBox>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(FractionallySizedBox),
      ),
    );
    expect(lane.widthFactor, .30);
    expect(lane.heightFactor, 1);

    final fittedArtwork = tester.widgetList<FittedBox>(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(FittedBox),
      ),
    );
    expect(fittedArtwork.map((box) => box.fit), containsAll([BoxFit.fill, BoxFit.contain]));
    expect(
      fittedArtwork.any(
        (box) =>
            box.fit == BoxFit.contain &&
            box.alignment == Alignment.centerRight,
      ),
      isTrue,
    );
    expect(
      find.descendant(
        of: find.byType(FastingArtSlot),
        matching: find.byType(ShaderMask),
      ),
      findsNWidgets(2),
    );
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
