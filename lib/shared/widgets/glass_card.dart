import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double blur;
  final Color? color;
  final VoidCallback? onTap;
  final List<BoxShadow>? boxShadow;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 22,
    this.blur = 10,
    this.color,
    this.onTap,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = color ?? theme.colorScheme.surfaceContainerLow;
    final shadow = boxShadow ?? const <BoxShadow>[];

    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      side: BorderSide(
        color: theme.colorScheme.onSurface.withValues(alpha: .065),
      ),
    );
    return DecoratedBox(
      decoration: BoxDecoration(boxShadow: shadow),
      child: Material(
        color: cardColor,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}
