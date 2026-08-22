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

/// Full-card editorial artwork with a reserved copy column.
/// Copy wraps inside the safe column before reaching the artwork subject.
class FastingSplitArtCard extends StatelessWidget {
  const FastingSplitArtCard({
    super.key,
    required this.assetPath,
    required this.child,
    this.minHeight = 144,
    this.artWidth = 132,
    this.borderRadius = 24,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticLabel,
    this.useThemedAsset = true,
  });

  final String assetPath;
  final Widget child;
  final double minHeight;
  final double artWidth;
  final double borderRadius;
  final BoxFit fit;
  final Alignment alignment;
  final String? semanticLabel;
  final bool useThemedAsset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final resolvedAsset = useThemedAsset
        ? themedEditorialAssetPath(assetPath, theme.brightness)
        : assetPath;

    return Semantics(
      container: true,
      image: true,
      label: semanticLabel,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: .42),
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: ColoredBox(
                color: theme.colorScheme.surfaceContainerLow,
                child: Image.asset(
                  resolvedAsset,
                  fit: fit,
                  alignment: alignment,
                  filterQuality: FilterQuality.high,
                  excludeFromSemantics: true,
                  errorBuilder: (_, __, ___) => Icon(Icons.image_outlined, color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      theme.colorScheme.surface.withValues(alpha: .98),
                      theme.colorScheme.surface.withValues(alpha: .90),
                      theme.colorScheme.surface.withValues(alpha: .18),
                      Colors.transparent,
                    ],
                    stops: const [0, .48, .72, 1],
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Padding(
                padding: EdgeInsets.only(right: artWidth),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A single, reusable connection point between paired editorial artwork and UI.
///
/// Each card renders one physical artwork edge-to-edge. Text and progress stay
/// in the widget tree; the bitmap only supplies the theme-aware atmosphere and
/// subject. This prevents duplicated subjects, stretched backgrounds and
/// visible seams between an illustration and its surface.
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
    this.artScale = 1,
    this.artOffset = Offset.zero,
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
  final double artScale;
  final Offset artOffset;

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

    // Scaling a full-bleed bitmap below 1 exposes the fallback color around
    // its edges. On real devices that presented as a dark/light strip above
    // otherwise seamless artwork. Editorial art may zoom, but never shrink
    // inside its clipping viewport.
    final safeScale = artScale < 1 ? 1.0 : artScale;
    return Transform.translate(
      offset: artOffset,
      child: Transform.scale(
        scale: safeScale,
        alignment: alignment,
        child: Image.asset(
          resolvedAssetPath,
          width: double.infinity,
          height: double.infinity,
          fit: fit,
          alignment: alignment,
          filterQuality: FilterQuality.high,
          excludeFromSemantics: true,
          errorBuilder: (context, error, stackTrace) => DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? const [Color(0xFF11172A), Color(0xFF30203A)]
                    : const [Color(0xFFFFF8EE), Color(0xFFF5ECE1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
      ),
    );
  }

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
