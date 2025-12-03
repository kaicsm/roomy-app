import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _black = Color(0xFF000000);
  static const _coral = Color(0xFFCF5C36);
  static const _lightGray = Color(0xFFEEE5E9);
  static const _mediumGray = Color(0xFF7C7C7C);
  static const _peach = Color(0xFFEFC88B);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: GoogleFonts.outfit().fontFamily,

    colorScheme: ColorScheme.dark(
      primary: _coral,
      onPrimary: _lightGray,
      primaryContainer: Color(0xFFA04A2B),
      onPrimaryContainer: _lightGray,

      secondary: _peach,
      onSecondary: _black,
      secondaryContainer: Color(0xFFD4A967),
      onSecondaryContainer: _lightGray,

      tertiary: _mediumGray,
      onTertiary: _lightGray,
      tertiaryContainer: Color(0xFF5A5A5A),
      onTertiaryContainer: _lightGray,

      surface: Color(0xFF121212),
      onSurface: _lightGray,
      surfaceDim: _black,
      surfaceBright: Color(0xFF2A2A2A),
      surfaceContainerLowest: _black,
      surfaceContainerLow: Color(0xFF121212),
      surfaceContainer: Color(0xFF1E1E1E),
      surfaceContainerHigh: Color(0xFF2A2A2A),
      surfaceContainerHighest: Color(0xFF363636),
      onSurfaceVariant: Color(0xFFD0D0D0),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      outline: _mediumGray,
      outlineVariant: Color(0xFF4A4A4A),
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: _lightGray,
      onInverseSurface: _black,
      inversePrimary: _coral,
    ),

    scaffoldBackgroundColor: Color(0xFF121212),

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _lightGray,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios_new),
    ),

    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _coral,
        foregroundColor: _lightGray,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _coral,
        side: BorderSide(color: _coral),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _coral,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _mediumGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _mediumGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _coral, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFFFB4AB)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFFFB4AB), width: 2),
      ),
      labelStyle: TextStyle(color: _lightGray),
      hintStyle: TextStyle(color: _lightGray.withValues(alpha: 0.6)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _coral,
      foregroundColor: _lightGray,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dividerTheme: DividerThemeData(color: _mediumGray, thickness: 1),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(color: _lightGray),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFF1E1E1E),
      selectedColor: _coral,
      labelStyle: TextStyle(color: _lightGray),
      side: BorderSide(color: _mediumGray),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return _mediumGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _coral.withValues(alpha: 0.5);
        }
        return Color(0xFF2A2A2A);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(_lightGray),
      side: BorderSide(color: _mediumGray, width: 2),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return _mediumGray;
      }),
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    fontFamily: GoogleFonts.outfit().fontFamily,

    colorScheme: ColorScheme.light(
      primary: _coral,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFFFDDD4),
      onPrimaryContainer: Color(0xFF4A1F14),

      secondary: _peach,
      onSecondary: _black,
      secondaryContainer: Color(0xFFFFF4E0),
      onSecondaryContainer: Color(0xFF3D2F14),

      tertiary: _mediumGray,
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFE0E0E0),
      onTertiaryContainer: Color(0xFF2A2A2A),

      surface: _lightGray,
      onSurface: _black,
      surfaceDim: Color(0xFFE0D7DB),
      surfaceBright: Colors.white,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xFFF9F5F7),
      surfaceContainer: _lightGray,
      surfaceContainerHigh: Color(0xFFE5DDE1),
      surfaceContainerHighest: Color(0xFFDBD3D7),
      onSurfaceVariant: Color(0xFF3A3A3A),

      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      outline: _mediumGray,
      outlineVariant: Color(0xFFC0C0C0),
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: Color(0xFF2A2A2A),
      onInverseSurface: _lightGray,
      inversePrimary: Color(0xFFFF9E7F),
    ),

    scaffoldBackgroundColor: _lightGray,

    appBarTheme: AppBarTheme(
      backgroundColor: _coral,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: true,
    ),

    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios_new),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      shadowColor: _black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _coral,
        foregroundColor: Colors.white,
        elevation: 2,
        shadowColor: _coral.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _coral,
        side: BorderSide(color: _coral, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _coral,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFC0C0C0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFC0C0C0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _coral, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFBA1A1A)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFBA1A1A), width: 2),
      ),
      labelStyle: TextStyle(color: Color(0xFF3A3A3A)),
      hintStyle: TextStyle(color: Color(0xFF3A3A3A).withValues(alpha: 0.6)),
      prefixIconColor: _mediumGray,
      suffixIconColor: _mediumGray,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _coral,
      foregroundColor: Colors.white,
      elevation: 4,
      highlightElevation: 8,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: _lightGray,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dividerTheme: DividerThemeData(
      color: Color(0xFFC0C0C0),
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(color: _lightGray),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: _coral.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: _black),
      side: BorderSide(color: Color(0xFFC0C0C0)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return _mediumGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _coral.withValues(alpha: 0.5);
        }
        return Color(0xFFC0C0C0);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      side: BorderSide(color: _mediumGray, width: 2),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _coral;
        return _mediumGray;
      }),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _coral,
      unselectedItemColor: _mediumGray,
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: _coral.withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: _coral,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(color: _mediumGray, fontSize: 12);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: _coral);
        }
        return IconThemeData(color: _mediumGray);
      }),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: _coral,
      unselectedLabelColor: _mediumGray,
      indicatorColor: _coral,
      dividerColor: Color(0xFFC0C0C0),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _coral,
      circularTrackColor: Color(0xFFC0C0C0),
      linearTrackColor: Color(0xFFC0C0C0),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: _coral,
      inactiveTrackColor: Color(0xFFC0C0C0),
      thumbColor: _coral,
      overlayColor: _coral.withValues(alpha: 0.2),
    ),
  );
}
