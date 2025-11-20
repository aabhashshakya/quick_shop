import 'app_theme.dart';
import 'package:json_annotation/json_annotation.dart';

/// Created by Aabhash Shakya on 19/11/2025

part 'app_config.g.dart';

@JsonSerializable()
class AppConfig {
  final String uuid;
  final bool shouldCacheUUID;
  final AppTheme theme;

  AppConfig({
    required this.uuid,
    required this.shouldCacheUUID,
    required this.theme,
  });

  factory AppConfig.fromJson(Map<String, dynamic> json) =>
      _$AppConfigFromJson(json);

  Map<String, dynamic> toJson() => _$AppConfigToJson(this);
}
