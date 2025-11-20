/// Created by Aabhash Shakya on 19/11/2025

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../app_config/app_config.dart';
import '../provider/app_config_provider.dart';

class FlutterBridge {
  static const _channel = MethodChannel('method-channel');

  static void setup(AppConfigProvider configProvider) {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'setAppConfig':
          final jsonString = call.arguments as String;
          final config = AppConfig.fromJson(jsonDecode(jsonString));
          configProvider.updateConfig(config);
          return null;
        default:
          throw MissingPluginException(
            'Method ${call.method} not implemented.',
          );
      }
    });
  }

  ///send selected product back to native Android
  static Future<bool> pay(String product) async {
    try {
      final result = await _channel.invokeMethod<bool>('pay', product);
      return result ?? true;
    } catch (e) {
      debugPrint("Failed to send product to native: $e");
      return false;
    }
  }

  ///when user logs out
  static Future<bool> logout() async {
    try {
      final result = await _channel.invokeMethod<bool>('logout');
      return result ?? true;
    } catch (e) {
      debugPrint("Failed to logout");
      return false;
    }
  }

  ///ask native to store the UUID on disk
  static Future<bool> cacheUUID(String uuid) async {
    try {
      final result = await _channel.invokeMethod<bool>('cacheUUID', uuid);
      return result ?? true;
    } catch (e) {
      debugPrint("Failed to cache UUID");
      return false;
    }
  }
}
