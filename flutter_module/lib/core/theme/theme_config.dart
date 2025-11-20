/// Created by Aabhash Shakya on 19/11/2025

import 'package:flutter/material.dart';
import '../app_config/app_theme.dart';

ThemeData themeFromConfig(AppTheme config) {
  final usedColors = config.themeMode == 'dark'
      ? config.colors.dark
      : config.colors.light;

  final brightness = config.themeMode == 'dark'
      ? Brightness.dark
      : Brightness.light;

  return ThemeData(
    brightness: brightness,
    primaryColor: usedColors.primary,
    scaffoldBackgroundColor: usedColors.surface,
    colorScheme: ColorScheme(
      primary: usedColors.primary,
      secondary: usedColors.secondary,
      surface: usedColors.surface,
      onPrimary: usedColors.onPrimary,
      onSecondary: usedColors.onSecondary,
      onSurface: usedColors.onSurface,
      primaryContainer: usedColors.primaryContainer,
      onPrimaryContainer: usedColors.onPrimaryContainer,
      error: Colors.red,
      onError: Colors.white,
      brightness: brightness,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: config.typography.titleLargeSize.toDouble(),
        fontFamily: config.typography.titleFont,
        color: usedColors.onPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: config.typography.bodyLargeSize.toDouble(),
        fontFamily: config.typography.bodyFont,
        color: usedColors.onPrimary,
      ),
      labelSmall: TextStyle(
        fontSize: config.typography.labelSmallSize.toDouble(),
        fontFamily: config.typography.labelFont,
        color: usedColors.onSecondary,
      ),
    ),
  );
}
