/// Created by Aabhash Shakya on 19/11/2025

import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

part 'app_theme.g.dart';

@JsonSerializable()
class AppColorsPair {
  final AppColors light;
  final AppColors dark;

  AppColorsPair({required this.light, required this.dark});

  factory AppColorsPair.fromJson(Map<String, dynamic> json) =>
      _$AppColorsPairFromJson(json);

  Map<String, dynamic> toJson() => _$AppColorsPairToJson(this);
}

@JsonSerializable()
class AppTheme {
  final String themeMode; // "light" or "dark"
  final AppColorsPair colors;
  final AppSpacing spacing;
  final AppTypography typography;

  AppTheme({
    required this.themeMode,
    required this.colors,
    required this.spacing,
    required this.typography,
  });

  factory AppTheme.fromJson(Map<String, dynamic> json) =>
      _$AppThemeFromJson(json);

  Map<String, dynamic> toJson() => _$AppThemeToJson(this);
}

class ColorHexConverter implements JsonConverter<Color, String> {
  const ColorHexConverter();

  @override
  Color fromJson(String json) {
    // Convert hex string to Color
    return Color(int.parse(json.replaceFirst('#', '0xff')));
  }

  @override
  String toJson(Color object) {
    // Convert Color back to hex string
    return '#${object.value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
  }
}

@JsonSerializable()
class AppColors {
  @ColorHexConverter()
  final Color primary;
  @ColorHexConverter()
  final Color secondary;
  @ColorHexConverter()
  final Color surface;
  @ColorHexConverter()
  final Color onSurface;
  @ColorHexConverter()
  final Color onPrimary;
  @ColorHexConverter()
  final Color onSecondary;
  @ColorHexConverter()
  final Color primaryContainer;
  @ColorHexConverter()
  final Color onPrimaryContainer;

  AppColors({
    required this.onSurface,
    required this.onPrimary,
    required this.onSecondary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.primary,
    required this.secondary,
    required this.surface,
  });

  factory AppColors.fromJson(Map<String, dynamic> json) =>
      _$AppColorsFromJson(json);

  Map<String, dynamic> toJson() => _$AppColorsToJson(this);
}

@JsonSerializable()
class AppSpacing {
  final int small;
  final int medium;
  final int large;

  AppSpacing({required this.small, required this.medium, required this.large});

  factory AppSpacing.fromJson(Map<String, dynamic> json) =>
      _$AppSpacingFromJson(json);

  Map<String, dynamic> toJson() => _$AppSpacingToJson(this);
}

@JsonSerializable()
class AppTypography {
  final int titleLargeSize;
  final int bodyLargeSize;
  final int labelSmallSize;
  final String titleFont;
  final String bodyFont;
  final String labelFont;

  AppTypography({
    required this.titleLargeSize,
    required this.bodyLargeSize,
    required this.labelSmallSize,
    required this.titleFont,
    required this.bodyFont,
    required this.labelFont,
  });

  factory AppTypography.fromJson(Map<String, dynamic> json) =>
      _$AppTypographyFromJson(json);

  Map<String, dynamic> toJson() => _$AppTypographyToJson(this);
}
