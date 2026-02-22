import 'package:flutter/material.dart';
import '../painters/ring_painter.dart';
import '../../../core/theme/app_colors.dart';

class FastingRing extends StatefulWidget {
  final double progress;
  final List<Color> phaseColors;
  final Widget child;
  final double size;

  const FastingRing({
    super.key,
    required this.progress,
    required this.phaseColors,
    required this.child,
    this.size = 280,
  });

  @override
  State<FastingRing> createState() => _FastingRingState();
}

class _FastingRingState extends State<FastingRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark ? Colors.white.withValues(alpha:0.08) : Colors.black.withValues(alpha:0.06);

    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: widget.progress > 0 ? _pulseAnimation.value : 1.0,
          child: child,
        );
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Outer glow
            if (widget.progress > 0)
              Container(
                width: widget.size + 20,
                height: widget.size + 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.phaseColors.first.withValues(alpha:0.15),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
            // Ring
            RepaintBoundary(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: widget.progress),
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, animatedProgress, _) {
                  return CustomPaint(
                    size: Size(widget.size, widget.size),
                    painter: RingPainter(
                      progress: animatedProgress,
                      gradientColors: widget.phaseColors.isEmpty
                          ? [AppColors.primary, AppColors.primaryDark]
                          : widget.phaseColors,
                      strokeWidth: 14,
                      trackColor: trackColor,
                    ),
                  );
                },
              ),
            ),
            // Center content
            widget.child,
          ],
        ),
      ),
    );
  }
}
