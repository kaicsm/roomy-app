import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _darkBrown = Color(0xFF231F20);
  static const _terracotta = Color(0xFFBB4430);
  static const _turquoise = Color(0xFF7EBDC2);
  static const _lightYellow = Color(0xFFF3DFA2);
  static const _lightCream = Color(0xFFEFE6DD);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: GoogleFonts.outfit().fontFamily,

    colorScheme: ColorScheme.dark(
      primary: _terracotta,
      onPrimary: _lightCream,
      primaryContainer: Color(0xFF8B3324),
      onPrimaryContainer: _lightCream,

      secondary: _turquoise,
      onSecondary: _darkBrown,
      secondaryContainer: Color(0xFF5A8F94),
      onSecondaryContainer: _lightCream,

      tertiary: _lightYellow,
      onTertiary: _darkBrown,
      tertiaryContainer: Color(0xFFD4BC7A),
      onTertiaryContainer: _darkBrown,

      surface: _darkBrown,
      onSurface: _lightCream,
      surfaceDim: Color(0xFF1A1718),
      surfaceBright: Color(0xFF3A3637),
      surfaceContainerLowest: Color(0xFF0F0D0E),
      surfaceContainerLow: _darkBrown,
      surfaceContainer: Color(0xFF2D2929),
      surfaceContainerHigh: Color(0xFF3A3637),
      surfaceContainerHighest: Color(0xFF454142),
      onSurfaceVariant: Color(0xFFD0C8C4),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      outline: Color(0xFF5A5556),
      outlineVariant: Color(0xFF3A3637),
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: _lightCream,
      onInverseSurface: _darkBrown,
      inversePrimary: _terracotta,
    ),

    scaffoldBackgroundColor: _darkBrown,

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: _lightCream,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
    ),

    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios_new),
    ),

    cardTheme: CardThemeData(
      color: Color(0xFF2D2929),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _terracotta,
        foregroundColor: _lightCream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _terracotta,
        side: BorderSide(color: _terracotta),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _terracotta,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2D2929),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFF5A5556)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFF5A5556)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _terracotta, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFFFB4AB)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFFFB4AB), width: 2),
      ),
      labelStyle: TextStyle(color: _lightCream),
      hintStyle: TextStyle(color: _lightCream.withValues(alpha: 0.6)),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _terracotta,
      foregroundColor: _lightCream,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Color(0xFF2D2929),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dividerTheme: DividerThemeData(color: Color(0xFF5A5556), thickness: 1),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: Color(0xFF3A3637),
      contentTextStyle: TextStyle(color: _lightCream),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Color(0xFF2D2929),
      selectedColor: _terracotta,
      labelStyle: TextStyle(color: _lightCream),
      side: BorderSide(color: Color(0xFF5A5556)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Color(0xFF5A5556);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _terracotta.withValues(alpha: 0.5);
        }
        return Color(0xFF3A3637);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(_lightCream),
      side: BorderSide(color: Color(0xFF5A5556), width: 2),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Color(0xFF5A5556);
      }),
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorScheme: ColorScheme.light(
      primary: _terracotta,
      onPrimary: _lightCream,
      primaryContainer: Color(0xFFFFDAD4),
      onPrimaryContainer: Color(0xFF5A1F14),

      secondary: _turquoise,
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFD4F0F3),
      onSecondaryContainer: Color(0xFF2A4D50),

      tertiary: Color(0xFFD4BC7A),
      onTertiary: _darkBrown,
      tertiaryContainer: _lightYellow,
      onTertiaryContainer: Color(0xFF3D3520),

      surface: _lightCream,
      onSurface: _darkBrown,
      surfaceDim: Color(0xFFE0D7D1),
      surfaceBright: Colors.white,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: Color(0xFFF9F2ED),
      surfaceContainer: _lightCream,
      surfaceContainerHigh: Color(0xFFE5DDD7),
      surfaceContainerHighest: Color(0xFFD9D0CA),
      onSurfaceVariant: Color(0xFF4A4544),

      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),

      outline: Color(0xFF7C7574),
      outlineVariant: Color(0xFFD0C8C4),
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: _darkBrown,
      onInverseSurface: _lightCream,
      inversePrimary: Color(0xFFFFB4A8),
    ),

    scaffoldBackgroundColor: _lightCream,

    appBarTheme: AppBarTheme(
      backgroundColor: _terracotta,
      foregroundColor: _lightCream,
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
      shadowColor: _darkBrown.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _terracotta,
        foregroundColor: _lightCream,
        elevation: 2,
        shadowColor: _terracotta.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _terracotta,
        side: BorderSide(color: _terracotta, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _terracotta,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFD0C8C4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFD0C8C4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: _terracotta, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFBA1A1A)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Color(0xFFBA1A1A), width: 2),
      ),
      labelStyle: TextStyle(color: Color(0xFF4A4544)),
      hintStyle: TextStyle(color: Color(0xFF4A4544).withValues(alpha: 0.6)),
      prefixIconColor: Color(0xFF7C7574),
      suffixIconColor: Color(0xFF7C7574),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _terracotta,
      foregroundColor: _lightCream,
      elevation: 4,
      highlightElevation: 8,
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      surfaceTintColor: _lightCream,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

    dividerTheme: DividerThemeData(
      color: Color(0xFFD0C8C4),
      thickness: 1,
      space: 1,
    ),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: _darkBrown,
      contentTextStyle: TextStyle(color: _lightCream),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      behavior: SnackBarBehavior.floating,
      elevation: 4,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: Colors.white,
      selectedColor: _terracotta.withValues(alpha: 0.2),
      labelStyle: TextStyle(color: _darkBrown),
      side: BorderSide(color: Color(0xFFD0C8C4)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Color(0xFF7C7574);
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _terracotta.withValues(alpha: 0.5);
        }
        return Color(0xFFD0C8C4);
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(_lightCream),
      side: BorderSide(color: Color(0xFF7C7574), width: 2),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _terracotta;
        return Color(0xFF7C7574);
      }),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: _terracotta,
      unselectedItemColor: Color(0xFF7C7574),
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: _terracotta.withValues(alpha: 0.2),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return TextStyle(
            color: _terracotta,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return TextStyle(color: Color(0xFF7C7574), fontSize: 12);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: _terracotta);
        }
        return IconThemeData(color: Color(0xFF7C7574));
      }),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: _terracotta,
      unselectedLabelColor: Color(0xFF7C7574),
      indicatorColor: _terracotta,
      dividerColor: Color(0xFFD0C8C4),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _terracotta,
      circularTrackColor: Color(0xFFD0C8C4),
      linearTrackColor: Color(0xFFD0C8C4),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: _terracotta,
      inactiveTrackColor: Color(0xFFD0C8C4),
      thumbColor: _terracotta,
      overlayColor: _terracotta.withValues(alpha: 0.2),
    ),
  );
}
