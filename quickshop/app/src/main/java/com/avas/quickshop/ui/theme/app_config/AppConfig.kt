package com.avas.quickshop.ui.theme.app_config


/// Created by Aabhash Shakya on 18/11/2025

import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Serializable
data class AppConfig(val uuid: String, val shouldCacheUUID: Boolean, val theme: AppTheme) {
    fun toJson(): String = Json.encodeToString(this)
}

@Serializable
data class AppTheme(
    val themeMode: String,
    val colors: AppColorsPair,
    val spacing: AppSpacingConfig,
    val typography: AppTypographyConfig
)

@Serializable
data class AppColors(
    val primary: String,
    val secondary: String,
    val surface: String,
    val onSurface: String,
    val onPrimary: String,
    val onSecondary: String,
    val primaryContainer: String,
    val onPrimaryContainer: String
)

@Serializable
data class AppColorsPair(val light: AppColors, val dark: AppColors)

@Serializable
data class AppSpacingConfig(val small: Int, val medium: Int, val large: Int)

@Serializable
data class AppTypographyConfig(
    val titleLargeSize: Int,
    val bodyLargeSize: Int,
    val labelSmallSize: Int,
    val titleFont: String,
    val bodyFont: String,
    val labelFont: String
)


