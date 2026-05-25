import 'package:flutter/material.dart';

class AppTheme {
  // ---------- المظهر الفاتح ----------
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: LightThemeColors.primary,
      primaryContainer: LightThemeColors.primaryContainer,
      secondary: LightThemeColors.secondary,
      secondaryContainer: LightThemeColors.secondaryContainer,
      tertiary: LightThemeColors.tertiary,
      tertiaryContainer: LightThemeColors.tertiaryContainer,
      surface: LightThemeColors.surface,
      error: LightThemeColors.error,
      errorContainer: LightThemeColors.errorContainer,
      onPrimary: LightThemeColors.onPrimary,
      onSecondary: LightThemeColors.onSecondary,
      onTertiary: LightThemeColors.onTertiary,
      onSurface: LightThemeColors.onSurface,
      onError: LightThemeColors.onError,
      outline: LightThemeColors.outline,
    ),
    scaffoldBackgroundColor: LightThemeColors.background,
    cardColor: LightThemeColors.surface,
    dividerColor: LightThemeColors.divider,
    appBarTheme: const AppBarTheme(
      backgroundColor: LightThemeColors.primary,
      foregroundColor: LightThemeColors.onPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: LightThemeColors.onPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: LightThemeColors.primary,
        foregroundColor: LightThemeColors.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: LightThemeColors.primary,
        side: const BorderSide(color: LightThemeColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: LightThemeColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LightThemeColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: LightThemeColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: LightThemeColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: LightThemeColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: LightThemeColors.error),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: LightThemeColors.onSurface),
      displayMedium: TextStyle(color: LightThemeColors.onSurface),
      headlineLarge: TextStyle(
        color: LightThemeColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: LightThemeColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: LightThemeColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: LightThemeColors.onBackground),
      bodyMedium: TextStyle(color: LightThemeColors.onBackground),
      labelLarge: TextStyle(color: LightThemeColors.onSurface),
    ),
    iconTheme: const IconThemeData(color: LightThemeColors.onSurface),
    primaryIconTheme: const IconThemeData(color: LightThemeColors.onPrimary),
  );

  // ---------- المظهر الداكن ----------
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: DarkThemeColors.primary,
      primaryContainer: DarkThemeColors.primaryContainer,
      secondary: DarkThemeColors.secondary,
      secondaryContainer: DarkThemeColors.secondaryContainer,
      tertiary: DarkThemeColors.tertiary,
      tertiaryContainer: DarkThemeColors.tertiaryContainer,
      surface: DarkThemeColors.surface,
      error: DarkThemeColors.error,
      errorContainer: DarkThemeColors.errorContainer,
      onPrimary: DarkThemeColors.onPrimary,
      onSecondary: DarkThemeColors.onSecondary,
      onTertiary: DarkThemeColors.onTertiary,
      onSurface: DarkThemeColors.onSurface,
      onError: DarkThemeColors.onError,
      outline: DarkThemeColors.outline,
    ),
    scaffoldBackgroundColor: DarkThemeColors.background,
    cardColor: DarkThemeColors.surface,
    dividerColor: DarkThemeColors.divider,
    appBarTheme: const AppBarTheme(
      backgroundColor: DarkThemeColors.surface,
      foregroundColor: DarkThemeColors.primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: DarkThemeColors.primary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkThemeColors.primary,
        foregroundColor: DarkThemeColors.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: DarkThemeColors.primary,
        side: const BorderSide(color: DarkThemeColors.primary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: DarkThemeColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: DarkThemeColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: DarkThemeColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: DarkThemeColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: DarkThemeColors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: DarkThemeColors.error),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: DarkThemeColors.onSurface),
      displayMedium: TextStyle(color: DarkThemeColors.onSurface),
      headlineLarge: TextStyle(
        color: DarkThemeColors.onSurface,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        color: DarkThemeColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: DarkThemeColors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: TextStyle(color: DarkThemeColors.onBackground),
      bodyMedium: TextStyle(color: DarkThemeColors.onBackground),
      labelLarge: TextStyle(color: DarkThemeColors.onSurface),
    ),
    iconTheme: const IconThemeData(color: DarkThemeColors.onSurface),
    primaryIconTheme: const IconThemeData(color: DarkThemeColors.primary),
  );
}

abstract class DarkThemeColors {
  static const Color primary = Color(0xFF80CBC4); // Teal 200
  static const Color primaryContainer = Color(0xFF004D40);
  static const Color secondary = Color.fromARGB(255, 199, 158, 97); // Amber 300
  static const Color secondaryContainer = Color(0xFF3E2723);
  static const Color tertiary = Color(0xFF4FC3F7); // Light Blue 300
  static const Color tertiaryContainer = Color(0xFF01579B);
  static const Color surface = Color(0xFF1E2A2A);
  static const Color background = Color(0xFF121212);
  static const Color error = Color(0xFFEF9A9A);
  static const Color errorContainer = Color(0xFF3E1A1A);
  static const Color onPrimary = Color(0xFF121212);
  static const Color onSecondary = Color(0xFF121212);
  static const Color onTertiary = Color(0xFF121212);
  static const Color onSurface = Color(0xFFE0F2F1);
  static const Color onBackground = Color(0xFFE0F2F1);
  static const Color onError = Color(0xFF121212);
  static const Color outline = Color(0xFF4D5E5E);
  static const Color shadow = Color(0x40000000);
  static const Color divider = Color(0xFF2C3A3A);
}

abstract class LightThemeColors {
  static const Color primary = Color(0xFF00695C); // Teal 800
  static const Color primaryContainer = Color(0xFFB2DFDB);
  static const Color secondary = Color(0xFFFF8F00); // Amber 700
  static const Color secondaryContainer = Color(0xFFFFECB3);
  static const Color tertiary = Color(0xFF0277BD); // Light Blue 800
  static const Color tertiaryContainer = Color(0xFFB3E5FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF4F9F9); // خلفية رمادية فاتحة جداً
  static const Color error = Color(0xFFD32F2F);
  static const Color errorContainer = Color(0xFFFFEBEE);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color onSurface = Color(0xFF1A2C3E);
  static const Color onBackground = Color(0xFF1C2E36);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color outline = Color(0xFF90A4AE);
  static const Color shadow = Color(0x1F000000);
  static const Color divider = Color(0xFFE0E0E0);
}
