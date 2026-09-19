import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.surface),
        ),
      ),
    );
  }
}
class AppFontSizes {
  AppFontSizes._();

  static const double xs = 12.0;
  static const double sm = 14.0;
  static const double base = 16.0;
  static const double lg = 18.0;
  static const double xl = 22.0;
  static const double xxl = 28.0;
  static const double heading = 32.0;
}