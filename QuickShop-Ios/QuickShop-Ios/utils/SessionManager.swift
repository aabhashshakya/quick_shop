//
//  SessionManager.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 22/11/2025.
//


import Foundation
import Combine

@MainActor
class SessionManager: ObservableObject {
    static let shared = SessionManager()

    @Published var uuid: String? {
        didSet {
            if let uuid = uuid {
                UserDefaults.standard.set(uuid, forKey: "uuid")
            } else {
                UserDefaults.standard.removeObject(forKey: "uuid")
            }
        }
    }

    var isLoggedIn: Bool {
        uuid != nil
    }

    private init() {
        self.uuid = UserDefaults.standard.string(forKey: "uuid")
    }

    func login(uuid: String) {
        self.uuid = uuid
    }

    func logout() {
        self.uuid = nil
    }
}
