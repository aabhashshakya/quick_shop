//
//  AppConfig.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 21/11/2025.
//

import Foundation

// MARK: - AppConfig (Root)
struct AppConfig: Codable {
    let uuid: String
    let shouldCacheUUID: Bool
    let theme: AppTheme
}

// MARK: - Theme
struct AppTheme: Codable {
    let themeMode: String
    let colors: AppColorsPair
    let spacing: AppSpacingConfig
    let typography: AppTypographyConfig
}

// MARK: - Colors + Pair
struct AppColorsPair: Codable {
    let light: AppColors
    let dark: AppColors
}

struct AppColors: Codable {
    let primary: String
    let secondary: String
    let surface: String
    let onSurface: String
    let onPrimary: String
    let onSecondary: String
    let primaryContainer: String
    let onPrimaryContainer: String
}

// MARK: - Spacing
struct AppSpacingConfig: Codable {
    let small: Int
    let medium: Int
    let large: Int
}

// MARK: - Typography
struct AppTypographyConfig: Codable {
    let titleLargeSize: Int
    let bodyLargeSize: Int
    let labelSmallSize: Int
    let titleFont: String
    let bodyFont: String
    let labelFont: String
}
