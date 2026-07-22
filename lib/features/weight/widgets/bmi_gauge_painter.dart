import 'dart:math';
import 'package:flutter/material.dart';

class BmiGaugePainter extends CustomPainter {
  final double bmi;
  final double minBmi;
  final double maxBmi;

  BmiGaugePainter({required this.bmi, this.minBmi = 15, this.maxBmi = 40});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 16;

    // BMI kategorileri renkleri (yarım daire)
    final segments = [
      _Segment(const Color(0xFF4A9DFF), 15, 18.5), // Underweight
      _Segment(const Color(0xFF4CAF50), 18.5, 25), // Normal
      _Segment(const Color(0xFFFFB74D), 25, 30), // Overweight
      _Segment(const Color(0xFFEF5350), 30, 40), // Obese
    ];

    final totalRange = maxBmi - minBmi;

    for (final seg in segments) {
      final startFraction = (seg.start - minBmi) / totalRange;
      final endFraction = (seg.end - minBmi) / totalRange;
      final startAngle = pi + (pi * startFraction);
      final sweepAngle = pi * (endFraction - startFraction);

      final paint =
          Paint()
            ..color = seg.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 12
            ..strokeCap = StrokeCap.butt;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }

    // İğne (needle)
    final clampedBmi = bmi.clamp(minBmi, maxBmi);
    final needleFraction = (clampedBmi - minBmi) / totalRange;
    final needleAngle = pi + (pi * needleFraction);
    final needleLength = radius - 20;

    final needleEnd = Offset(
      center.dx + needleLength * cos(needleAngle),
      center.dy + needleLength * sin(needleAngle),
    );

    final needlePaint =
        Paint()
          ..color = const Color(0xFF1A1A2E)
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round;

    canvas.drawLine(center, needleEnd, needlePaint);

    // Merkez nokta
    final dotPaint =
        Paint()
          ..color = const Color(0xFF1A1A2E)
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 6, dotPaint);

    final dotInnerPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 3, dotInnerPaint);
  }

  @override
  bool shouldRepaint(covariant BmiGaugePainter oldDelegate) {
    return oldDelegate.bmi != bmi;
  }
}

class _Segment {
  final Color color;
  final double start;
  final double end;
  const _Segment(this.color, this.start, this.end);
}
