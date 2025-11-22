//
//  RootView.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

import SwiftUI
import Flutter

import SwiftUI
import Flutter

struct RootView: View {
    @StateObject var mainViewModel = MainViewModel()
    @Environment(FlutterDependencies.self) var flutterDeps
    @Environment(\.colorScheme) var colorScheme
    

    var body: some View {
        Group {
            if let productEvent = mainViewModel.flutterEvent,
               case let .productSelected(product) = productEvent {
                // Show payment success page
                PaymentSuccessScreen(
                    product: product,
                    onContinueShopping: {
                        mainViewModel.clearFlutterEvent()
                    }
                )
            } else if let uuid = mainViewModel.uuid {
                // Show Flutter module
                FlutterView(flutterEngine: flutterDeps.flutterEngine)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        sendConfigToFlutter(uuid: uuid)
                    }
                    .onChange(of: colorScheme) { _,__ in
                        sendConfigToFlutter(uuid: uuid)
                    }
            } else {
                // Show login
                LoginScreen { newUUID in
                    sendConfigToFlutter(uuid:newUUID,shouldCacheUUID: true)
                }
            }
        }
    }

    private func sendConfigToFlutter(uuid:String, shouldCacheUUID: Bool = false) {
        let appTheme = getAppTheme()
        let appConfig = AppConfig(uuid: uuid, shouldCacheUUID: shouldCacheUUID, theme: appTheme)

        guard let jsonData = try? JSONEncoder().encode(appConfig),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            print("Failed to serialize AppConfig")
            return
        }

        let channel = FlutterMethodChannel(
            name: "method-channel",
            binaryMessenger: flutterDeps.flutterEngine.binaryMessenger
        )
        channel.invokeMethod("setAppConfig", arguments: jsonString)
    }
}


