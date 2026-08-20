import 'package:flutter/material.dart';

enum FastingArtVariant { bare, row, card, hero }

/// Resolves the physical dawn/vigil artwork pair for the active theme.
String themedEditorialAssetPath(String assetPath, Brightness brightness) {
  if (brightness == Brightness.dark) return assetPath;

  final extensionIndex = assetPath.lastIndexOf('.');
  assert(extensionIndex > 0, 'Editorial artwork must have a file extension.');
  return '${assetPath.substring(0, extensionIndex)}-light'
      '${assetPath.substring(extensionIndex)}';
}

Color fastingArtForeground(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : const Color(0xFF17131F);

Color fastingArtMutedForeground(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: .78)
        : const Color(0xFF3F3745);

Color fastingArtDivider(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: .14)
        : const Color(0xFF514756).withValues(alpha: .20);

/// A single, reusable connection point between paired editorial artwork and UI.
///
/// Paired artwork is separated into two views of the same physical asset. Its
/// clean left half is stretched into the card surface, while its illustrated
/// right half is scaled into a feathered lane. Because both layers come from
/// the same file, there is no flat-color rectangle or visible pasted edge.
class FastingArtSlot extends StatelessWidget {
  const FastingArtSlot({
    super.key,
    required this.assetPath,
    required this.height,
    required this.child,
    this.variant = FastingArtVariant.card,
    this.borderRadius = 24,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.semanticLabel,
    this.useThemedAsset = true,
    this.splitLightArtwork,
  });

  final String assetPath;
  final double height;
  final Widget child;
  final FastingArtVariant variant;
  final double borderRadius;
  final BoxFit fit;
  final Alignment alignment;
  final String? semanticLabel;
  final bool useThemedAsset;

  /// Kept for source compatibility; paired artwork is now always full-bleed.
  final bool? splitLightArtwork;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Semantics(
      container: true,
      image: true,
      label: semanticLabel,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(child: _artwork(isDark)),
              if (isDark && variant != FastingArtVariant.bare)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: _darkScrim),
                  ),
                ),
              Positioned.fill(child: child),
            ],
          ),
        ),
      ),
    );
  }

  Widget _artwork(bool isDark) {
    final resolvedAssetPath = useThemedAsset
        ? themedEditorialAssetPath(
            assetPath,
            isDark ? Brightness.dark : Brightness.light,
          )
        : assetPath;

    Widget image({
      required double width,
      required double height,
      required BoxFit imageFit,
      required Alignment imageAlignment,
    }) =>
        Image.asset(
          resolvedAssetPath,
          width: width,
          height: height,
          fit: imageFit,
          alignment: imageAlignment,
          filterQuality: FilterQuality.medium,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [Color(0xFF11172A), Color(0xFF30203A)]
                    : const [Color(0xFFE4D4CC), Color(0xFFC9C3D1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );

    if (variant == FastingArtVariant.bare || !useThemedAsset) {
      return image(
        width: double.infinity,
        height: double.infinity,
        imageFit: fit,
        imageAlignment: alignment,
      );
    }

    final background = image(
      width: 1672,
      height: 941,
      imageFit: BoxFit.cover,
      imageAlignment: Alignment.centerLeft,
    );

    final subject = image(
      width: 1672,
      height: 941,
      imageFit: BoxFit.cover,
      imageAlignment: Alignment.centerRight,
    );

    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.fill,
          child: _cropArtwork(
            background,
            fraction: .5,
            alignment: Alignment.centerLeft,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: FractionallySizedBox(
            widthFactor: .30,
            heightFactor: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.centerRight,
              child: _featherArtwork(
                _cropArtwork(
                  subject,
                  fraction: .5,
                  alignment: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cropArtwork(
    Widget artwork, {
    required double fraction,
    required Alignment alignment,
  }) =>
      ClipRect(
        child: Align(
          widthFactor: fraction,
          heightFactor: 1,
          alignment: alignment,
          child: artwork,
        ),
      );

  Widget _featherArtwork(Widget artwork) => ShaderMask(
    blendMode: BlendMode.dstIn,
    shaderCallback: (bounds) => const LinearGradient(
      colors: [Colors.transparent, Colors.black, Colors.black],
      stops: [0, .14, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).createShader(bounds),
    child: ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (bounds) => const LinearGradient(
        colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
        stops: [0, .06, .94, 1],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      child: artwork,
    ),
  );

  LinearGradient get _darkScrim => switch (variant) {
    FastingArtVariant.row => const LinearGradient(
      colors: [Color(0xF20F1424), Color(0xB30F1424), Color(0x190F1424)],
      stops: [0, .52, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.card => const LinearGradient(
      colors: [Color(0xD90F1424), Color(0x730F1424), Color(0x260F1424)],
      stops: [0, .58, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.hero => const LinearGradient(
      colors: [Color(0xF20F1424), Color(0xAD0F1424), Color(0x330F1424)],
      stops: [0, .56, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.bare => const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
    ),
  };
}
