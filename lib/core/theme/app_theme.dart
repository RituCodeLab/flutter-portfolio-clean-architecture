import 'package:flutter/material.dart';

class AppColors {
  static const navy = Color(0xFF0D2857);
  static const blue = Color(0xFF147BFF);
  static const cyan = Color(0xFF14CFE8);
  static const sky = Color(0xFFEAF8FF);
  static const background = Color(0xFFFBFDFF);
  static const text = Color(0xFF17315D);
  static const muted = Color(0xFF6F829F);
  static const border = Color(0xFFDCEAF7);
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.blue,
        brightness: Brightness.light,
      ),
      fontFamily: 'Arial',
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.navy,
          fontSize: 56,
          fontWeight: FontWeight.w800,
          height: 1.02,
        ),
        headlineMedium: TextStyle(
          color: AppColors.navy,
          fontSize: 36,
          fontWeight: FontWeight.w800,
        ),
        bodyLarge: TextStyle(
          color: AppColors.muted,
          fontSize: 17,
          height: 1.65,
        ),
      ),
    );
  }
}
