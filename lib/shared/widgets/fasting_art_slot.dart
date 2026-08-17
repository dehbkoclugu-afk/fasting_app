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
                child: Image.asset(
                  assetPath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: fit,
                  alignment: alignment,
                  filterQuality: FilterQuality.medium,
                  excludeFromSemantics: true,
                  errorBuilder:
                      (context, error, stackTrace) => const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF11172A), Color(0xFF30203A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                ),
              ),
              if (variant != FastingArtVariant.bare)
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: _scrim),
                  ),
                ),
              Positioned.fill(child: child),
            ],
          ),
        ),
      ),
    );
  }

  LinearGradient get _scrim => switch (variant) {
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
