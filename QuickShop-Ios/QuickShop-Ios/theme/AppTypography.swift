//
//  AppTypography.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 21/11/2025.
//

import SwiftUI


//this is not the font filename but is the Post-Script name
struct AppTypography {
    static let titleLarge = Font.custom("Mulish-Bold", size: 22)
    static let titleLargeSize: Int = 22
    static let titleFont: String = "Mulish"

    static let bodyLarge = Font.custom("Montserrat-Regular", size: 16)
    static let bodyLargeSize: Int = 16
    static let bodyFont: String = "Montserrat"

    static let labelSmall = Font.custom("Mulish-Regular", size: 12)
    static let labelSmallSize: Int = 12
    static let labelFont: String = "Mulish"
}


extension Font {
    // MARK: - Title
    static var titleLarge: Font {
        Font.custom("Mulish-Bold", size: 22)
    }
    
    static var titleLargeSize: CGFloat { 22 }
    
    // MARK: - Body
    static var bodyLarge: Font {
        Font.custom("Montserrat-Regular", size: 16)
    }
    
    static var bodyLargeSize: CGFloat { 16 }
    
    // MARK: - Label
    static var labelSmall: Font {
        Font.custom("Mulish-Regular", size: 12)
    }
    
    static var labelSmallSize: CGFloat { 12 }
}
