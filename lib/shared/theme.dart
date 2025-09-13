import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = Colors.blue;
  static Color secondaryColor = Colors.lightBlue;
}

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontSize: 14,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: TextStyle(
      fontSize: 16,
    )
    
  ),
  
);