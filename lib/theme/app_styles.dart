import 'package:flutter/material.dart';
import 'package:naruto_app/theme/app_colors.dart'; 

class AppStyles {
  static const TextStyle titleLarge = TextStyle(
    fontFamily: 'Roboto', 
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 22.0,
    fontWeight: FontWeight.w600,
    color: AppColors.secondary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Roboto', 
    fontSize: 18.0,
    color: AppColors.textPrimaryLight,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    color: AppColors.textPrimaryLight,
  );

  static const TextStyle labelLarge = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: AppColors.accent,
  );

  
}