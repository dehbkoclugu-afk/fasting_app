import 'dart:math';
import 'package:flutter/material.dart';

class RingPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final double strokeWidth;
  final Color trackColor;

  RingPainter({
    required this.progress,
    required this.gradientColors,
    this.strokeWidth = 14,
    this.trackColor = Colors.white10,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) / 2) - strokeWidth / 2;
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    // Track (background ring)
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Gradient arc (progress ring)
    final rect = Rect.fromCircle(center: center, radius: radius);
    final gradient = SweepGradient(
      startAngle: startAngle,
      endAngle: startAngle + sweepAngle,
      colors: [
        gradientColors.first,
        gradientColors.last,
      ],
      stops: const [0.0, 1.0],
      transform: GradientRotation(startAngle),
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);

    // Glow effect at the end of the arc
    if (progress > 0.01) {
      final endAngle = startAngle + sweepAngle;
      final glowX = center.dx + radius * cos(endAngle);
      final glowY = center.dy + radius * sin(endAngle);
      final glowCenter = Offset(glowX, glowY);

      final glowPaint = Paint()
        ..color = gradientColors.last.withValues(alpha:0.4)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

      canvas.drawCircle(glowCenter, strokeWidth / 2 + 4, glowPaint);

      // Solid dot at the end
      final dotPaint = Paint()
        ..color = gradientColors.last
        ..style = PaintingStyle.fill;

      canvas.drawCircle(glowCenter, strokeWidth / 2 - 1, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.gradientColors != gradientColors;
  }
}
