import 'package:flutter/material.dart';
import 'package:naruto_app/theme/app_colors.dart';
import 'package:naruto_app/theme/app_styles.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      onPrimary: AppColors.konohaWhite,
      onSecondary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: AppStyles.titleLarge,
      iconTheme: IconThemeData(color: AppColors.konohaWhite),
    ),
    textTheme: const TextTheme(
      titleLarge: AppStyles.titleLarge,
      titleMedium: AppStyles.titleMedium,
      bodyLarge: AppStyles.bodyLarge,
      bodyMedium: AppStyles.bodyMedium,
      labelLarge: AppStyles.labelLarge,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        textStyle: AppStyles.labelLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.secondary,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: AppColors.secondary,
      secondary: AppColors.primary,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.secondary,
      titleTextStyle: AppStyles.titleLarge.copyWith(color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'NombreDeTuFuenteNaruto',
        fontSize: 28.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'NombreDeTuFuenteNaruto',
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'NombreDeTuFuente',
        fontSize: 18.0,
        color: AppColors.textPrimaryDark,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'NombreDeTuFuente',
        fontSize: 16.0,
        color: AppColors.textPrimaryDark,
      ),
      labelLarge: TextStyle(
        fontFamily: 'NombreDeTuFuenteNaruto',
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: AppColors.accent,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        textStyle: AppStyles.labelLarge.copyWith(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    ),
  );
}
