import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.tertiary,
        surface: AppColors.lightSurface,
        onSurface: AppColors.lightTextPrimary,
        surfaceContainer: AppColors.lightSurfaceVariant,
        outline: AppColors.lightDivider,
        outlineVariant: AppColors.lightDivider,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.lightBg,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.lightTextPrimary,
        displayColor: AppColors.lightTextPrimary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.lightCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: Color(0x11000000)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightBg,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 68,
        titleSpacing: 20,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      navigationBarTheme: _navigationBarTheme(
        AppColors.lightSurface,
        AppColors.lightTextSecondary,
      ),
      dialogTheme: _dialogTheme(
        AppColors.lightSurface,
        AppColors.lightTextPrimary,
      ),
      bottomSheetTheme: _bottomSheetTheme(AppColors.lightSurface),
      inputDecorationTheme: _inputTheme(
        AppColors.lightTextPrimary,
        AppColors.lightTextSecondary,
        AppColors.lightSurfaceVariant,
        AppColors.lightDivider,
      ),
      snackBarTheme: _snackBarTheme(AppColors.lightTextPrimary, Colors.white),
      listTileTheme: _listTileTheme(AppColors.lightTextPrimary),
      switchTheme: _switchTheme,
      chipTheme: _chipTheme(
        AppColors.lightTextPrimary,
        const Color(0xFFF4F4F6),
      ),
      iconButtonTheme: _iconButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      textButtonTheme: _textButtonTheme,
      segmentedButtonTheme: _segmentedButtonTheme(
        AppColors.lightSurfaceVariant,
        AppColors.lightTextSecondary,
      ),
      datePickerTheme: _datePickerTheme(AppColors.lightSurface),
      timePickerTheme: _timePickerTheme(AppColors.lightSurface),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDivider,
        thickness: 1,
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.secondary,
        onSecondary: Colors.white,
        tertiary: AppColors.tertiary,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkTextPrimary,
        surfaceContainer: AppColors.darkSurfaceVariant,
        outline: AppColors.darkDivider,
        outlineVariant: AppColors.darkDivider,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.darkBg,
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(color: Color(0x14FFFFFF)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: 68,
        titleSpacing: 20,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
      ),
      navigationBarTheme: _navigationBarTheme(
        AppColors.darkSurfaceVariant,
        AppColors.darkTextSecondary,
      ),
      dialogTheme: _dialogTheme(AppColors.darkCard, AppColors.darkTextPrimary),
      bottomSheetTheme: _bottomSheetTheme(AppColors.darkCard),
      inputDecorationTheme: _inputTheme(
        AppColors.darkTextPrimary,
        AppColors.darkTextSecondary,
        AppColors.darkSurface,
        AppColors.darkDivider,
      ),
      snackBarTheme: _snackBarTheme(
        AppColors.darkTextPrimary,
        AppColors.darkBg,
      ),
      listTileTheme: _listTileTheme(AppColors.darkTextPrimary),
      switchTheme: _switchTheme,
      chipTheme: _chipTheme(AppColors.darkTextPrimary, AppColors.darkSurface),
      iconButtonTheme: _iconButtonTheme,
      filledButtonTheme: _filledButtonTheme,
      textButtonTheme: _textButtonTheme,
      segmentedButtonTheme: _segmentedButtonTheme(
        AppColors.darkSurfaceVariant,
        AppColors.darkTextSecondary,
      ),
      datePickerTheme: _datePickerTheme(AppColors.darkCard),
      timePickerTheme: _timePickerTheme(AppColors.darkCard),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkSurface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          side: const BorderSide(color: AppColors.primary),
          minimumSize: const Size(48, 52),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDivider,
        thickness: 1,
      ),
    );
  }

  static NavigationBarThemeData _navigationBarTheme(
    Color background,
    Color muted,
  ) => NavigationBarThemeData(
    height: 72,
    elevation: 0,
    backgroundColor: background,
    indicatorColor: AppColors.primary.withValues(alpha: .11),
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    ),
    labelTextStyle: WidgetStateProperty.resolveWith(
      (states) => TextStyle(
        color:
            states.contains(WidgetState.selected) ? AppColors.primary : muted,
        fontSize: 11,
        fontWeight:
            states.contains(WidgetState.selected)
                ? FontWeight.w800
                : FontWeight.w600,
      ),
    ),
    iconTheme: WidgetStateProperty.resolveWith(
      (states) => IconThemeData(
        color:
            states.contains(WidgetState.selected) ? AppColors.primary : muted,
        size: 23,
      ),
    ),
  );

  static DialogThemeData _dialogTheme(Color background, Color foreground) =>
      DialogThemeData(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        titleTextStyle: TextStyle(
          color: foreground,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: -.35,
        ),
      );

  static BottomSheetThemeData _bottomSheetTheme(Color background) =>
      BottomSheetThemeData(
        backgroundColor: background,
        modalBackgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        showDragHandle: true,
        dragHandleSize: const Size(36, 4),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
      );

  static InputDecorationTheme _inputTheme(
    Color foreground,
    Color muted,
    Color fill,
    Color border,
  ) => InputDecorationTheme(
    filled: true,
    fillColor: fill,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    labelStyle: TextStyle(color: muted, fontWeight: FontWeight.w600),
    hintStyle: TextStyle(color: muted, fontWeight: FontWeight.w500),
    prefixIconColor: muted,
    suffixIconColor: muted,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.error),
    ),
  );

  static SnackBarThemeData _snackBarTheme(Color background, Color foreground) =>
      SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: background,
        contentTextStyle: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w600,
        ),
        insetPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  static ListTileThemeData _listTileTheme(Color foreground) =>
      ListTileThemeData(
        textColor: foreground,
        iconColor: AppColors.primary,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        minTileHeight: 56,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      );

  static final SwitchThemeData _switchTheme = SwitchThemeData(
    thumbColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected) ? Colors.white : null,
    ),
    trackColor: WidgetStateProperty.resolveWith(
      (states) =>
          states.contains(WidgetState.selected) ? AppColors.primary : null,
    ),
  );

  static ChipThemeData _chipTheme(Color foreground, Color background) =>
      ChipThemeData(
        backgroundColor: background,
        selectedColor: AppColors.primary.withValues(alpha: .12),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        labelStyle: TextStyle(color: foreground, fontWeight: FontWeight.w700),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      );

  static final IconButtonThemeData _iconButtonTheme = IconButtonThemeData(
    style: IconButton.styleFrom(minimumSize: const Size(48, 48)),
  );

  static final FilledButtonThemeData _filledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      minimumSize: const Size(48, 52),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: const TextStyle(fontWeight: FontWeight.w800),
    ),
  );

  static final TextButtonThemeData _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size(48, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontWeight: FontWeight.w700),
    ),
  );

  static SegmentedButtonThemeData _segmentedButtonTheme(
    Color background,
    Color muted,
  ) => SegmentedButtonThemeData(
    style: ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size(48, 48)),
      backgroundColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected)
                ? AppColors.primary
                : background,
      ),
      foregroundColor: WidgetStateProperty.resolveWith(
        (states) =>
            states.contains(WidgetState.selected) ? Colors.white : muted,
      ),
      side: const WidgetStatePropertyAll(BorderSide.none),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontWeight: FontWeight.w700),
      ),
    ),
  );

  static DatePickerThemeData _datePickerTheme(Color background) =>
      DatePickerThemeData(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        headerBackgroundColor: AppColors.primary,
        headerForegroundColor: Colors.white,
        dayShape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );

  static TimePickerThemeData _timePickerTheme(Color background) =>
      TimePickerThemeData(
        backgroundColor: background,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        hourMinuteShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        dayPeriodShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      );
}
