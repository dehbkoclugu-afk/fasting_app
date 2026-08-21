import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary (Kırmızı-pembe - Fastify)
  static const primary = Color(0xFFE84C5E);
  static const primaryLight = Color(0xFFFF6B7A);
  static const primaryDark = Color(0xFFC73848);

  // Secondary
  static const secondary = Color(0xFFFF8A96);
  static const secondaryLight = Color(0xFFFFB0B8);
  static const secondaryDark = Color(0xFFD44A66);

  // Tertiary (Mavi - su vurgu)
  static const tertiary = Color(0xFF4A9DFF);

  // Success / Warning / Error
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFB74D);
  static const error = Color(0xFFEF5350);

  // Metabolic Phase Gradients
  static const anabolicStart = Color(0xFFE84C5E);
  static const anabolicEnd = Color(0xFFFF8A96);
  static const catabolicStart = Color(0xFFf093fb);
  static const catabolicEnd = Color(0xFFf5576c);
  static const fatBurningStart = Color(0xFF4facfe);
  static const fatBurningEnd = Color(0xFF00f2fe);
  static const ketosisStart = Color(0xFF43e97b);
  static const ketosisEnd = Color(0xFF38f9d7);
  static const autophagyStart = Color(0xFFfa709a);
  static const autophagyEnd = Color(0xFFfee140);

  static const phaseGradients = <String, List<Color>>{
    'anabolic': [anabolicStart, anabolicEnd],
    'catabolic': [catabolicStart, catabolicEnd],
    'fatBurning': [fatBurningStart, fatBurningEnd],
    'ketosis': [ketosisStart, ketosisEnd],
    'autophagy': [autophagyStart, autophagyEnd],
  };

  // Dark Theme
  static const darkBg = Color(0xFF0F0F1A);
  static const darkSurface = Color(0xFF17171F);
  static const darkCard = Color(0xFF1D1D26);
  static const darkSurfaceVariant = Color(0xFF262631);
  static const darkTextPrimary = Color(0xFFE8E8E8);
  static const darkTextSecondary = Color(0xFFA0A0B0);
  static const darkDivider = Color(0xFF2A2A3E);

  // Light Theme — warm paper surfaces avoid a clinical, overexposed canvas.
  static const lightBg = Color(0xFFF7F1EB);
  static const lightSurface = Color(0xFFFCF8F4);
  static const lightCard = Color(0xFFFFFCF9);
  static const lightSurfaceVariant = Color(0xFFF0E7E1);
  static const lightTextPrimary = Color(0xFF1A1A2E);
  static const lightTextSecondary = Color(0xFF6B6B80);
  static const lightDivider = Color(0xFFE8DDD8);
}
