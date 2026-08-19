import 'package:flutter/material.dart';

enum FastingArtVariant { bare, row, card, hero }

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
    Widget image() => Image.asset(
      assetPath,
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

    if (isDark) return image();

    // Dawn treatment: the same composition gets a warm, editorial light-mode
    // grade instead of carrying its near-black vigil background into the UI.
    // A dusty mauve screen lift removes black without becoming clinical white;
    // the subtle original layer restores food/detail contrast.
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: const ColorFilter.mode(
            Color(0xFFA78686),
            BlendMode.screen,
          ),
          child: image(),
        ),
        Opacity(opacity: .28, child: image()),
      ],
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
      colors: [Color(0xC9583C4E), Color(0x805C5264), Color(0x145C6173)],
      stops: [0, .52, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.card => const LinearGradient(
      colors: [Color(0xB8583C4E), Color(0x665C5264), Color(0x125C6173)],
      stops: [0, .58, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.hero => const LinearGradient(
      colors: [Color(0xC9583C4E), Color(0x805C5264), Color(0x1F5C6173)],
      stops: [0, .56, 1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
    FastingArtVariant.bare => const LinearGradient(
      colors: [Colors.transparent, Colors.transparent],
    ),
  };
}
