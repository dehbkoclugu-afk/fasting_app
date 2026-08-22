import 'package:flutter/material.dart';

import 'fasting_art_slot.dart';

/// Consistent secondary-screen header with separate copy and artwork zones.
class EditorialScreenHero extends StatelessWidget {
  const EditorialScreenHero({
    super.key,
    required this.assetPath,
    required this.title,
    required this.subtitle,
    this.icon,
    this.height = 172,
    this.semanticLabel,
    this.alignment = Alignment.center,
    this.fit = BoxFit.contain,
    this.textWidth = 210,
    this.artScale = 1,
    this.contentAlignment = Alignment.centerLeft,
  });

  final String assetPath;
  final String title;
  final String subtitle;
  final IconData? icon;
  final double height;
  final String? semanticLabel;
  final Alignment alignment;
  final BoxFit fit;
  final double textWidth;
  final double artScale;
  final Alignment contentAlignment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final artWidth = (constraints.maxWidth * .40)
            .clamp(122.0, 184.0)
            .toDouble();
        return FastingSplitArtCard(
          assetPath: assetPath,
          minHeight: height,
          artWidth: artWidth,
          alignment: alignment,
          fit: fit,
          semanticLabel: semanticLabel ?? title,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Align(
              alignment: contentAlignment,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: theme.colorScheme.primary, size: 25),
                    const SizedBox(height: 9),
                  ],
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      height: 1.08,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
