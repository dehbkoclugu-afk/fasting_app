import 'dart:math';
import 'package:flutter/material.dart';

class WaterDropPainter extends CustomPainter {
  final double fillPercent;
  final Color waterColor;
  final Color dropColor;

  WaterDropPainter({
    required this.fillPercent,
    this.waterColor = const Color(0xFF4A9DFF),
    this.dropColor = const Color(0xFFE8F4FF),
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Damla şekli (drop path)
    final dropPath = Path();
    dropPath.moveTo(w * 0.5, 0);
    dropPath.cubicTo(w * 0.5, 0, w * 0.15, h * 0.45, w * 0.15, h * 0.6);
    dropPath.cubicTo(w * 0.15, h * 0.85, w * 0.3, h, w * 0.5, h);
    dropPath.cubicTo(w * 0.7, h, w * 0.85, h * 0.85, w * 0.85, h * 0.6);
    dropPath.cubicTo(w * 0.85, h * 0.45, w * 0.5, 0, w * 0.5, 0);
    dropPath.close();

    // Arka plan (açık mavi)
    final bgPaint = Paint()..color = dropColor;
    canvas.drawPath(dropPath, bgPaint);

    // Su doldurma (clip ile)
    canvas.save();
    canvas.clipPath(dropPath);

    final fillHeight = h * (1 - fillPercent.clamp(0.0, 1.0));
    final waterRect = Rect.fromLTWH(0, fillHeight, w, h - fillHeight);
    final waterPaint =
        Paint()
          ..color = waterColor.withValues(alpha: 0.7)
          ..style = PaintingStyle.fill;
    canvas.drawRect(waterRect, waterPaint);

    // Hafif dalga efekti
    final wavePath = Path();
    wavePath.moveTo(0, fillHeight);
    for (double x = 0; x <= w; x += 1) {
      final y = fillHeight + sin(x * 0.05) * 3;
      wavePath.lineTo(x, y);
    }
    wavePath.lineTo(w, h);
    wavePath.lineTo(0, h);
    wavePath.close();

    final wavePaint = Paint()..color = waterColor.withValues(alpha: 0.5);
    canvas.drawPath(wavePath, wavePaint);

    canvas.restore();

    // Damla kenarlık
    final borderPaint =
        Paint()
          ..color = waterColor.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
    canvas.drawPath(dropPath, borderPaint);
  }

  @override
  bool shouldRepaint(covariant WaterDropPainter oldDelegate) {
    return oldDelegate.fillPercent != fillPercent;
  }
}
