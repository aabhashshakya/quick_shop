/// Created by Aabhash Shakya on 19/11/2025

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_module/core/cache/db/product_db.dart';

import '../app_config/app_config.dart';
import '../app_config/session_notifier.dart';
import '../provider/app_config_provider.dart';

class FlutterBridge {
  static const _channel = MethodChannel('method-channel');

  static void setup(AppConfigProvider configProvider) {
    _channel.setMethodCallHandler((call) async {
      try {
        debugPrint("Flutter received method: ${call.method}");
        debugPrint("Arguments: ${call.arguments}");

        switch (call.method) {
          case 'setAppConfig':
            final jsonString = call.arguments as String;
            final config = AppConfig.fromJson(jsonDecode(jsonString));
            configProvider.updateConfig(config);
            debugPrint("AppConfig updated in Flutter: ${config.toJson()}");
            return null;
          default:
            debugPrint("Method ${call.method} not implemented in Flutter.");
            throw MissingPluginException(
              'Method ${call.method} not implemented.',
            );
        }
      } catch (e, stack) {
        debugPrint("Error handling method call ${call.method}: ${e.toString()}");
        rethrow; // optional: rethrow if you want Flutter to see the exception
      }
    });
  }


  ///send selected product back to native Android
  static Future<bool> pay(String product) async {
    try {
      final result = await _channel.invokeMethod<bool>('pay', product);
      return result ?? true;
    } catch (e) {
      debugPrint("Failed to send product to native: ${e.toString()}");
      return false;
    }
  }

  ///when user logs out
  static Future<void> logout() async {
    try {
      final result = await _channel.invokeMethod<bool>('logout');
      if (result == true) {
        //clear cache when user logs out
        await ProductDatabase().clearCache();
        FlutterSessionNotifier().notifyLogout();
      }
    } catch (e) {
      debugPrint("Failed to logout: ${e.toString()}");
    }
  }

  ///ask native to store the UUID on disk
  static Future<bool> cacheUUID(String uuid) async {
    try {
      final result = await _channel.invokeMethod<bool>('cacheUUID', uuid);
      return result ?? true;
    } catch (e) {
      debugPrint("Failed to cache UUID: ${e.toString()}");
      return false;
    }
  }
}
