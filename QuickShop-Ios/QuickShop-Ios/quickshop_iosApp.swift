//
//  quickshop_iosApp.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant



@main
struct QuickShop_iOSApp: App {
    @State var flutterDeps = FlutterDependencies.shared
       @StateObject var mainViewModel = MainViewModel()
       let appDelegate = AppDelegate()
    

       var body: some Scene {
           WindowGroup {
               RootView()
                   .environmentObject(mainViewModel)
                   .environment(flutterDeps) // ✅ Add this line!
                   .onAppear {
                       appDelegate.mainViewModel = mainViewModel
                       appDelegate.makeMethodChannel(flutterEngine: flutterDeps.flutterEngine)
                   }
           }
       }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var mainViewModel = MainViewModel()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        return true
    }

    func makeMethodChannel(flutterEngine: FlutterEngine) {
        let channel = FlutterMethodChannel(
            name: "method-channel",
            binaryMessenger: flutterEngine.binaryMessenger
        )
        
        print("Setting up method channels!")

        channel.setMethodCallHandler { [weak self] call, result in
            guard let self = self else { return }
            switch call.method {
            case "cacheUUID":
                print("User called cached UUID!")
                if let uuid = call.arguments as? String {
                               FlutterEventsRepository.shared.emit(.cacheUUID(uuid))
                               result(true)
                           } else {
                               result(FlutterError(code: "INVALID_ARGS", message: "uuid missing", details: nil))
                           }

            case "pay":
                print("User selected product!")
                if let json = call.arguments as? String, let product = Product.from(jsonString: json) {
                            FlutterEventsRepository.shared.emit(.productSelected(product))
                            result(true)
                        } else {
                            result(FlutterError(code: "INVALID_ARGS", message: "product JSON missing or invalid", details: nil))
                        }
            case "logout":
                print("User logged out!")
                FlutterEventsRepository.shared.emit(.userLoggedOut)
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}

