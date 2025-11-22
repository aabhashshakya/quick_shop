//
//  MainViewModel.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 20/11/2025.
//

import Foundation
import Combine

class MainViewModel: ObservableObject {
    @Published var uuid: String? = SessionManager.shared.uuid
    @Published var flutterEvent: FlutterEvent?
    
    func setEvent(_ event: FlutterEvent) {
        flutterEvent = event
    }
    
    private var cancellable: AnyCancellable?

        init() {
            // subscribe to repository
            cancellable = FlutterEventsRepository.shared.$latestEvent
                .receive(on: DispatchQueue.main)
                .sink { [weak self] event in
                    if let event = event {
                              self?.handleFlutterEvent(event)
                          }                }
        }
    
    func handleFlutterEvent(_ event: FlutterEvent) {
        switch event {
        case .productSelected(_):
            self.flutterEvent = event
        case .cacheUUID(let uuid):
            cacheUUID(uuid)
        case .userLoggedOut:
            print("User logged out")
            logout()
        }
    }
    
    func cacheUUID(_ newUUID: String) {
         SessionManager.shared.uuid = newUUID
         uuid = newUUID
     }

        func clearFlutterEvent() {
            flutterEvent = nil
        }
    
    func logout(){
        SessionManager.shared.uuid = nil
        uuid = nil
        
    }

}
