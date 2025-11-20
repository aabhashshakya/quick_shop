package com.avas.quickshop.ui.theme

/// Created by Aabhash Shakya on 18/11/2025

import androidx.compose.runtime.staticCompositionLocalOf

data class AppSpacing(
    val small: Int = 4,
    val medium: Int = 8,
    val large: Int = 16,
    val xLarge: Int = 32
)

val LocalSpacing = staticCompositionLocalOf { AppSpacing() }
