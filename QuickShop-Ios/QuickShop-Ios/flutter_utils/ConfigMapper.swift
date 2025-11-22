//
//  ConfigMapper.swift
//  quickshop-ios
//
//  Created by Aabhash Shakya on 21/11/2025.
//

import SwiftUI

// MARK: - Theme Mapper
func getAppTheme() -> AppTheme {
    let lightColors = mapColorsToConfig(isDark: false)
    let darkColors  = mapColorsToConfig(isDark: true)

    return AppTheme(
        themeMode: colorSchemeIsDark() ? "dark" : "light",
        colors: AppColorsPair(
            light: lightColors,
            dark: darkColors
        ),
        spacing: mapSpacingToConfig(),
        typography: mapTypographyToConfig()
    )
}

// MARK: - Colors
private func mapColorsToConfig(isDark: Bool) -> AppColors {
    func resolvedHex(_ name: String) -> String {
        guard let uiColor = UIColor(named: name) else { return "#000000" }
        let resolved = uiColor.resolvedColor(
            with: UITraitCollection(userInterfaceStyle: isDark ? .dark : .light)
        )
        return resolved.toHex()
    }

    return AppColors(
        primary: resolvedHex("primary"),
        secondary: resolvedHex("secondary"),
        surface: resolvedHex("surface"),
        onSurface: resolvedHex("onSurface"),
        onPrimary: resolvedHex("onPrimary"),
        onSecondary: resolvedHex("onSecondary"),
        primaryContainer: resolvedHex("primaryContainer"),
        onPrimaryContainer: resolvedHex("onPrimaryContainer")
    )
}

// MARK: - Spacing
private func mapSpacingToConfig() -> AppSpacingConfig {
    return AppSpacingConfig(
        small: Int(AppSpacing.small),
        medium: Int(AppSpacing.medium),
        large: Int(AppSpacing.large)
    )
}

// MARK: - Typography
private func mapTypographyToConfig() -> AppTypographyConfig {
    return AppTypographyConfig(
        titleLargeSize: AppTypography.titleLargeSize,
        bodyLargeSize: AppTypography.bodyLargeSize,
        labelSmallSize: AppTypography.labelSmallSize,
        titleFont: AppTypography.titleFont,
        bodyFont: AppTypography.bodyFont,
        labelFont: AppTypography.labelFont
    )
}

// MARK: - Helpers
private func colorSchemeIsDark() -> Bool {
    // Detect system dark mode
    return UIScreen.main.traitCollection.userInterfaceStyle == .dark
}
