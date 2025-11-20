/// Created by Aabhash Shakya on 19/11/2025
import 'package:flutter/material.dart';
import 'package:flutter_module/core/bridge/flutter_bridge.dart';

import '../app_config/app_config.dart';
import '../app_config/app_theme.dart';

class AppConfigProvider extends ChangeNotifier {
  AppConfig? _config;

  AppConfig? get config => _config;

  bool get isDark => _config?.theme.themeMode.toLowerCase() == 'dark';

  // Called when Android/iOS sends the config
  Future<void> updateConfig(AppConfig newConfig) async {
    // //call native to cache the UUID that we just got
    if (newConfig.shouldCacheUUID) {
      var success = await FlutterBridge.cacheUUID(newConfig.uuid);
      if (success) {
        _config = newConfig;
        notifyListeners();
      }
    } else {
      _config = newConfig;
      notifyListeners();
    }
  }

  AppColors? getColors() {
    if (config?.theme.themeMode == 'dark') {
      return config?.theme.colors.dark;
    } else {
      return config?.theme.colors.light;
    }
  }
}
