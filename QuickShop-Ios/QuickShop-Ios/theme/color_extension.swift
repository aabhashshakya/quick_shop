//
//  color_extension.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 21/11/2025.
//

import SwiftUI
extension Color {
    
    //override primary and secondary colors to make it read from Asssets instead
    static var primary: Color {
        Color("primary")
    }
    
    static var secondary: Color {
        Color("secondary")
    }
    
}

extension UIColor {
    func toHex() -> String {
        let ciColor = CIColor(color: self)
        let r = Int(ciColor.red * 255)
        let g = Int(ciColor.green * 255)
        let b = Int(ciColor.blue * 255)

        let hex = String(format: "#%02X%02X%02X", r, g, b)
        return hex
    }
}


