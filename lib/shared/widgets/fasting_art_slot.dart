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

/// Foreground colors for copy placed directly over editorial artwork.
///
/// Light artwork is intentionally warm and airy, so it uses ink-colored copy
/// instead of forcing every card back into a dark surface.
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

/// A single, reusable connection point between editorial artwork and UI.
///
/// Dark mode keeps its full-bleed artwork and protective scrim. Text-oriented
/// light cards use a Lumen-style split layout: a calm ink-safe surface on the
/// left and the physical `-light` artwork cropped into the right side.
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
              Positioned.fill(
                child: _artwork(isDark),
              ),
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

    final artwork = Image.asset(
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

    if (isDark || !_usesSplitLightLayout) return artwork;

    return ColoredBox(
      color: const Color(0xFFF5ECE5),
      child: Align(
        alignment: Alignment.centerRight,
        child: FractionallySizedBox(
          widthFactor: variant == FastingArtVariant.hero ? .54 : .46,
          heightFactor: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(22),
            ),
            child: artwork,
          ),
        ),
      ),
    );
  }

  bool get _usesSplitLightLayout =>
      splitLightArtwork ??
      (variant == FastingArtVariant.row || variant == FastingArtVariant.hero);

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
