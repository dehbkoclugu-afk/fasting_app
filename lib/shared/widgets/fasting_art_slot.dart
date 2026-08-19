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

/// A single, reusable connection point between editorial artwork and UI.
///
/// Artwork always fills the frame. Variants only tune the protective scrim so
/// copy remains readable without flattening the image into a generic gradient.
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
  });

  final String assetPath;
  final double height;
  final Widget child;
  final FastingArtVariant variant;
  final double borderRadius;
  final BoxFit fit;
  final Alignment alignment;
  final String? semanticLabel;

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
              Positioned.fill(
                child: _artwork(isDark),
              ),
              if (variant != FastingArtVariant.bare)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: _scrim(isDark)),
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
    final resolvedAssetPath = themedEditorialAssetPath(
      assetPath,
      isDark ? Brightness.dark : Brightness.light,
    );

    return Image.asset(
      resolvedAssetPath,
      width: double.infinity,
      height: double.infinity,
      fit: fit,
      alignment: alignment,
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
  }

  LinearGradient _scrim(bool isDark) => isDark
      ? _darkScrim
      : _lightScrim;

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

  // Copy remains legible in light mode without putting a black wall back over
  // the newly lifted art. Coral-plum keeps this treatment inside FastTrack's
  // palette and away from a sterile white-card look.
  LinearGradient get _lightScrim => switch (variant) {
    FastingArtVariant.row => const LinearGradient(
      colors: [Color(0xE64A3342), Color(0xCC4A3342), Color(0xB34A3342)],
      stops: [0, .52, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.card => const LinearGradient(
      colors: [Color(0xE04A3342), Color(0xC74A3342), Color(0xB34A3342)],
      stops: [0, .58, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.hero => const LinearGradient(
      colors: [Color(0xED4A3342), Color(0xD64A3342), Color(0xB34A3342)],
      stops: [0, .56, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.bare => const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
    ),
  };
}
