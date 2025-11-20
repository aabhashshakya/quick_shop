// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => AppConfig(
  uuid: json['uuid'] as String,
  shouldCacheUUID: json['shouldCacheUUID'] as bool,
  theme: AppTheme.fromJson(json['theme'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AppConfigToJson(AppConfig instance) => <String, dynamic>{
  'uuid': instance.uuid,
  'shouldCacheUUID': instance.shouldCacheUUID,
  'theme': instance.theme,
};
