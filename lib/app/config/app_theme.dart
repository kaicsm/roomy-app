import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const _deepNavy = Color.fromARGB(255, 12, 12, 20);
  static const _darkerNavy = Color(0xFF13141F);
  static const _vibrantPurple = Color(0xFF6C5CE7);
  static const _lightPurple = Color(0xFF8B7FF4);
  static const _accentPink = Color(0xFFFF6B9D);
  static const _white = Color(0xFFFFFFFF);
  static const _lightGray = Color(0xFFA8A8B3);
  static const _mediumGray = Color(0xFF6B6B7B);
  static const _darkGray = Color(0xFF2E2F3E);
  static const _cardBg = Color(0xFF252637);

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,

    colorScheme: ColorScheme.dark(
      primary: _vibrantPurple,
      onPrimary: _white,
      primaryContainer: _lightPurple,
      onPrimaryContainer: _white,

      secondary: _accentPink,
      onSecondary: _white,
      secondaryContainer: Color(0xFFFF8BB3),
      onSecondaryContainer: _white,

      tertiary: _lightGray,
      onTertiary: _deepNavy,
      tertiaryContainer: _mediumGray,
      onTertiaryContainer: _white,

      surface: _deepNavy,
      onSurface: _white,
      surfaceDim: _darkerNavy,
      surfaceBright: _cardBg,
      surfaceContainerLowest: _darkerNavy,
      surfaceContainerLow: _deepNavy,
      surfaceContainer: _cardBg,
      surfaceContainerHigh: Color(0xFF2E2F42),
      surfaceContainerHighest: Color(0xFF3A3B52),
      onSurfaceVariant: _lightGray,

      error: Color(0xFFFF6B9D),
      onError: _white,
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),

      outline: _mediumGray,
      outlineVariant: _darkGray,
      shadow: Colors.black,
      scrim: Colors.black87,
      inverseSurface: _white,
      onInverseSurface: _deepNavy,
      inversePrimary: _vibrantPurple,
    ),

    scaffoldBackgroundColor: _deepNavy,

    appBarTheme: AppBarTheme(
      backgroundColor: _deepNavy,
      foregroundColor: _white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
    ),

    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const Icon(Icons.arrow_back),
    ),

    cardTheme: CardThemeData(
      color: _cardBg,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _vibrantPurple,
        foregroundColor: _white,
        elevation: 5,
        shadowColor: _vibrantPurple.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: _white,
        backgroundColor: _cardBg,
        side: BorderSide(color: _darkGray, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _vibrantPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _cardBg,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkGray),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _darkGray),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _vibrantPurple),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _accentPink),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _accentPink, width: 2),
      ),
      labelStyle: GoogleFonts.plusJakartaSans(color: _lightGray, fontSize: 14),
      hintStyle: GoogleFonts.plusJakartaSans(color: _mediumGray, fontSize: 15),
      prefixIconColor: _mediumGray,
      suffixIconColor: _mediumGray,
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: _vibrantPurple,
      foregroundColor: _white,
      elevation: 8,
      highlightElevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),

    dialogTheme: DialogThemeData(
      backgroundColor: _cardBg,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 8,
    ),

    dividerTheme: DividerThemeData(color: _darkGray, thickness: 1),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: _cardBg,
      contentTextStyle: GoogleFonts.plusJakartaSans(color: _white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      behavior: SnackBarBehavior.floating,
    ),

    chipTheme: ChipThemeData(
      backgroundColor: _cardBg,
      selectedColor: _vibrantPurple,
      labelStyle: GoogleFonts.plusJakartaSans(color: _white),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),

    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _vibrantPurple;
        return _mediumGray;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return _vibrantPurple.withValues(alpha: 0.5);
        }
        return _darkGray;
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _vibrantPurple;
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(_white),
      side: BorderSide(color: _mediumGray, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    ),

    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return _vibrantPurple;
        return _mediumGray;
      }),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkerNavy,
      selectedItemColor: _vibrantPurple,
      unselectedItemColor: _mediumGray,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: _darkerNavy,
      indicatorColor: _vibrantPurple.withValues(alpha: 0.2),
      height: 70,
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return GoogleFonts.plusJakartaSans(
            color: _vibrantPurple,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          );
        }
        return GoogleFonts.plusJakartaSans(
          color: _mediumGray,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return IconThemeData(color: _vibrantPurple, size: 26);
        }
        return IconThemeData(color: _mediumGray, size: 24);
      }),
    ),

    tabBarTheme: TabBarThemeData(
      labelColor: _vibrantPurple,
      unselectedLabelColor: _mediumGray,
      indicatorColor: _vibrantPurple,
      dividerColor: Colors.transparent,
      labelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: _vibrantPurple,
      strokeWidth: 2,
      circularTrackColor: _darkGray,
      linearTrackColor: _darkGray,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: _vibrantPurple,
      inactiveTrackColor: _darkGray,
      thumbColor: _vibrantPurple,
      overlayColor: _vibrantPurple.withValues(alpha: 0.2),
      trackHeight: 4,
    ),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      displayMedium: GoogleFonts.plusJakartaSans(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      displaySmall: GoogleFonts.plusJakartaSans(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      headlineLarge: GoogleFonts.plusJakartaSans(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: _white,
      ),
      headlineSmall: GoogleFonts.plusJakartaSans(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      titleLarge: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      titleMedium: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      titleSmall: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      bodyLarge: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _white,
      ),
      bodyMedium: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _lightGray,
      ),
      bodySmall: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _lightGray,
      ),
      labelLarge: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      labelMedium: GoogleFonts.plusJakartaSans(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: _white,
      ),
      labelSmall: GoogleFonts.plusJakartaSans(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: _mediumGray,
      ),
    ),
  );

  static const liveIndicatorColor = Color(0xFFFF4757);
  static const onlineStatusColor = Color(0xFF2ECC71);
  static const gradientStart = Color.fromARGB(255, 144, 132, 240);
  static const gradientEnd = Color.fromARGB(255, 195, 110, 245);

  static const primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const buttonGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFF8B7FF4)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
    colorScheme: ColorScheme.light(
      primary: _vibrantPurple,
      onPrimary: _white,
      surface: Colors.white,
      onSurface: _deepNavy,
    ),
  );
}
