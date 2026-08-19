import 'package:flutter/material.dart';

import 'fasting_art_slot.dart';

/// Consistent editorial header used by the app's secondary screens.
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
    this.fit = BoxFit.cover,
  });

  final String assetPath;
  final String title;
  final String subtitle;
  final IconData? icon;
  final double height;
  final String? semanticLabel;
  final Alignment alignment;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FastingArtSlot(
      assetPath: assetPath,
      height: height,
      variant: FastingArtVariant.hero,
      alignment: alignment,
      fit: fit,
      semanticLabel: semanticLabel ?? title,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: 220,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: fastingArtForeground(context), size: 26),
                    const SizedBox(height: 10),
                  ],
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: fastingArtForeground(context),
                      fontWeight: FontWeight.w800,
                      height: 1.05,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    subtitle,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: fastingArtMutedForeground(context),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
