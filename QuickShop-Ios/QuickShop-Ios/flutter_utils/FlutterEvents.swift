//
//  FlutterEvents.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 22/11/2025.
//

import Foundation
import Combine

@MainActor
final class FlutterEventsRepository: ObservableObject {
    static let shared = FlutterEventsRepository()

    @Published var latestEvent: FlutterEvent? = nil

    func emit(_ event: FlutterEvent) {
        self.latestEvent = event
    }
}

enum FlutterEvent {
    case productSelected(Product)
    case cacheUUID(String)
    case userLoggedOut
}


//product model
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating?

    static func from(jsonString: String) -> Product? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return try? JSONDecoder().decode(Product.self, from: data)
    }
}
