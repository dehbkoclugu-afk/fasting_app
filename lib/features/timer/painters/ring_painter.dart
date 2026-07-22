import 'dart:math';

import 'package:flutter/material.dart';

class RingPainter extends CustomPainter {
  const RingPainter({
    required this.progress,
    required this.gradientColors,
    required this.trackColor,
    required this.tickColor,
    this.strokeWidth = 13,
  });

  final double progress;
  final List<Color> gradientColors;
  final Color trackColor;
  final Color tickColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final safeProgress = progress.clamp(0.0, 1.0);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth;
    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = -pi / 2;

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    for (var index = 0; index < 24; index++) {
      final angle = startAngle + (2 * pi * index / 24);
      final outer = Offset(
        center.dx + (radius + strokeWidth) * cos(angle),
        center.dy + (radius + strokeWidth) * sin(angle),
      );
      final inner = Offset(
        center.dx +
            (radius + strokeWidth - (index % 6 == 0 ? 6 : 3)) * cos(angle),
        center.dy +
            (radius + strokeWidth - (index % 6 == 0 ? 6 : 3)) * sin(angle),
      );
      canvas.drawLine(
        inner,
        outer,
        Paint()
          ..color = tickColor
          ..strokeWidth = index % 6 == 0 ? 1.8 : 1
          ..strokeCap = StrokeCap.round,
      );
    }

    if (safeProgress == 0) return;

    final colors =
        gradientColors.isEmpty
            ? const [Color(0xFFE84C5E), Color(0xFFFF8A96)]
            : gradientColors;
    final sweep = 2 * pi * safeProgress;
    final progressPaint =
        Paint()
          ..shader = SweepGradient(
            startAngle: startAngle,
            endAngle: startAngle + 2 * pi,
            colors: colors,
            transform: const GradientRotation(startAngle),
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweep, false, progressPaint);

    final endAngle = startAngle + sweep;
    final endpoint = Offset(
      center.dx + radius * cos(endAngle),
      center.dy + radius * sin(endAngle),
    );
    canvas.drawCircle(
      endpoint,
      strokeWidth * .72,
      Paint()
        ..color = colors.last.withValues(alpha: .22)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
    );
    canvas.drawCircle(
      endpoint,
      strokeWidth * .28,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant RingPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.gradientColors != gradientColors ||
      oldDelegate.trackColor != trackColor ||
      oldDelegate.tickColor != tickColor;
}
