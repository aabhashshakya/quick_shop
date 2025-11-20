package com.avas.quickshop.flutter_utils.app_config

/// Created by Aabhash Shakya on 18/11/2025

import androidx.compose.material3.ColorScheme
import androidx.compose.ui.graphics.Color
import com.avas.quickshop.ui.theme.*
import com.avas.quickshop.ui.theme.app_config.AppColors
import com.avas.quickshop.ui.theme.app_config.AppColorsPair
import com.avas.quickshop.ui.theme.app_config.AppSpacingConfig
import com.avas.quickshop.ui.theme.app_config.AppTheme
import com.avas.quickshop.ui.theme.app_config.AppTypographyConfig

//convert color to platform-independent values
fun Color.toHex(): String {
    val r = (this.red * 255).toInt()
    val g = (this.green * 255).toInt()
    val b = (this.blue * 255).toInt()
    return String.format("#%02X%02X%02X", r, g, b)
}

fun mapColorsToConfig(isDark: Boolean, colorScheme: ColorScheme): AppColors {
    return if (isDark) {
        AppColors(
            primary = colorScheme.primary.toHex(),
            secondary = colorScheme.secondary.toHex(),
            surface = colorScheme.surface.toHex(),
            onSurface = colorScheme.onSurface.toHex(),
            onPrimary = colorScheme.onPrimary.toHex(),
            onSecondary = colorScheme.onSecondary.toHex(),
            primaryContainer = colorScheme.primaryContainer.toHex(),
            onPrimaryContainer = colorScheme.onPrimaryContainer.toHex(),
        )
    } else {
        AppColors(
            primary = colorScheme.primary.toHex(),
            secondary = colorScheme.secondary.toHex(),
            surface = colorScheme.surface.toHex(),
            onSurface = colorScheme.onSurface.toHex(),
            onPrimary = colorScheme.onPrimary.toHex(),
            onSecondary = colorScheme.onSecondary.toHex(),
            primaryContainer = colorScheme.primaryContainer.toHex(),
            onPrimaryContainer = colorScheme.onPrimaryContainer.toHex(),
        )
    }
}

fun mapSpacingToConfig(): AppSpacingConfig {
    return AppSpacingConfig(
        small = 4,
        medium = 8,
        large = 16
    )
}

fun mapTypographyToConfig(): AppTypographyConfig {
    return AppTypographyConfig(
        titleLargeSize = Typography.titleLarge.fontSize.value.toInt(),
        bodyLargeSize = Typography.bodyLarge.fontSize.value.toInt(),
        labelSmallSize = Typography.labelSmall.fontSize.value.toInt(),
        titleFont = "Mulish",
        bodyFont = "Montserrat",
        labelFont = "Mulish"
    )
}

fun getAppTheme(isDark: Boolean, colorScheme: ColorScheme): AppTheme {
    return AppTheme(
        themeMode = if (isDark) "dark" else "light",
        colors = AppColorsPair(
            dark = mapColorsToConfig(true, colorScheme),
            light = mapColorsToConfig(false, colorScheme)
        ),
        spacing = mapSpacingToConfig(),
        typography = mapTypographyToConfig()
    )
}
