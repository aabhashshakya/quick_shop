//
//  FlutterDependencies.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

import Foundation
import Flutter
import FlutterPluginRegistrant
// 1. Keep it as a singleton

@Observable
class FlutterDependencies {
    static let shared = FlutterDependencies()
    let flutterEngine: FlutterEngine

    private init() {
        self.flutterEngine = FlutterEngine()
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: flutterEngine)
    }
}
