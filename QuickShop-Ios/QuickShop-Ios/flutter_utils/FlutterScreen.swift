//
//  FlutterScreen.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

import SwiftUI
import Flutter

struct FlutterView: UIViewControllerRepresentable {
    let flutterEngine: FlutterEngine

    func makeUIViewController(context: Context) -> FlutterViewController {
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: FlutterViewController, context: Context) {}
}

