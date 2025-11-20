/// Created by Aabhash Shakya on 20/11/2025

import 'package:flutter/foundation.dart';

enum SessionEventType { login, logout }

class FlutterSessionNotifier extends ChangeNotifier {
  static final FlutterSessionNotifier _instance = FlutterSessionNotifier._internal();
  factory FlutterSessionNotifier() => _instance;
  FlutterSessionNotifier._internal();

  SessionEventType? _lastEvent;

  /// Call this on login
  void notifyLogin() {
    _lastEvent = SessionEventType.login;
    notifyListeners();
  }

  /// Call this on logout
  void notifyLogout() {
    _lastEvent = SessionEventType.logout;
    notifyListeners();
  }

  /// ViewModels can check the last event type
  SessionEventType? get lastEvent => _lastEvent;
}
