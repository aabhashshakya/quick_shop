// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_theme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppColorsPair _$AppColorsPairFromJson(Map<String, dynamic> json) =>
    AppColorsPair(
      light: AppColors.fromJson(json['light'] as Map<String, dynamic>),
      dark: AppColors.fromJson(json['dark'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppColorsPairToJson(AppColorsPair instance) =>
    <String, dynamic>{'light': instance.light, 'dark': instance.dark};

AppTheme _$AppThemeFromJson(Map<String, dynamic> json) => AppTheme(
  themeMode: json['themeMode'] as String,
  colors: AppColorsPair.fromJson(json['colors'] as Map<String, dynamic>),
  spacing: AppSpacing.fromJson(json['spacing'] as Map<String, dynamic>),
  typography: AppTypography.fromJson(
    json['typography'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$AppThemeToJson(AppTheme instance) => <String, dynamic>{
  'themeMode': instance.themeMode,
  'colors': instance.colors,
  'spacing': instance.spacing,
  'typography': instance.typography,
};

AppColors _$AppColorsFromJson(Map<String, dynamic> json) => AppColors(
  onSurface: const ColorHexConverter().fromJson(json['onSurface'] as String),
  onPrimary: const ColorHexConverter().fromJson(json['onPrimary'] as String),
  onSecondary: const ColorHexConverter().fromJson(
    json['onSecondary'] as String,
  ),
  primaryContainer: const ColorHexConverter().fromJson(
    json['primaryContainer'] as String,
  ),
  onPrimaryContainer: const ColorHexConverter().fromJson(
    json['onPrimaryContainer'] as String,
  ),
  primary: const ColorHexConverter().fromJson(json['primary'] as String),
  secondary: const ColorHexConverter().fromJson(json['secondary'] as String),
  surface: const ColorHexConverter().fromJson(json['surface'] as String),
);

Map<String, dynamic> _$AppColorsToJson(AppColors instance) => <String, dynamic>{
  'primary': const ColorHexConverter().toJson(instance.primary),
  'secondary': const ColorHexConverter().toJson(instance.secondary),
  'surface': const ColorHexConverter().toJson(instance.surface),
  'onSurface': const ColorHexConverter().toJson(instance.onSurface),
  'onPrimary': const ColorHexConverter().toJson(instance.onPrimary),
  'onSecondary': const ColorHexConverter().toJson(instance.onSecondary),
  'primaryContainer': const ColorHexConverter().toJson(
    instance.primaryContainer,
  ),
  'onPrimaryContainer': const ColorHexConverter().toJson(
    instance.onPrimaryContainer,
  ),
};

AppSpacing _$AppSpacingFromJson(Map<String, dynamic> json) => AppSpacing(
  small: (json['small'] as num).toInt(),
  medium: (json['medium'] as num).toInt(),
  large: (json['large'] as num).toInt(),
);

Map<String, dynamic> _$AppSpacingToJson(AppSpacing instance) =>
    <String, dynamic>{
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
    };

AppTypography _$AppTypographyFromJson(Map<String, dynamic> json) =>
    AppTypography(
      titleLargeSize: (json['titleLargeSize'] as num).toInt(),
      bodyLargeSize: (json['bodyLargeSize'] as num).toInt(),
      labelSmallSize: (json['labelSmallSize'] as num).toInt(),
      titleFont: json['titleFont'] as String,
      bodyFont: json['bodyFont'] as String,
      labelFont: json['labelFont'] as String,
    );

Map<String, dynamic> _$AppTypographyToJson(AppTypography instance) =>
    <String, dynamic>{
      'titleLargeSize': instance.titleLargeSize,
      'bodyLargeSize': instance.bodyLargeSize,
      'labelSmallSize': instance.labelSmallSize,
      'titleFont': instance.titleFont,
      'bodyFont': instance.bodyFont,
      'labelFont': instance.labelFont,
    };
