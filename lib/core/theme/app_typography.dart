import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  static TextTheme get textTheme {
    return const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 36,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 28,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }

  // Timer-specific large numbers
  static TextStyle timerLarge(Color color) => TextStyle(
    fontFamily: 'Inter',
    fontSize: 64,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: -2,
    height: 1.1,
  );

  static TextStyle timerMedium(Color color) => TextStyle(
    fontFamily: 'Inter',
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: color,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static TextStyle timerSmall(Color color) => TextStyle(
    fontFamily: 'Inter',
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: color,
    letterSpacing: 2,
  );
}
