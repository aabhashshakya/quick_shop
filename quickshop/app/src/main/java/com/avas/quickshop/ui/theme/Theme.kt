package com.avas.quickshop.ui.theme

import android.os.Build
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.dynamicDarkColorScheme
import androidx.compose.material3.dynamicLightColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext

private val DarkColorScheme = darkColorScheme(
    primary = Green,
    secondary = DarkGreen,
    onPrimary = White,
    onSecondary = Grey,
    surface = Black,
    onSurface = White,
    primaryContainer = SurfaceDark,
    onPrimaryContainer = White,
)

private val LightColorScheme = lightColorScheme(
    primary = Green,
    secondary = DarkGreen,
    onPrimary = White,
    onSecondary = Grey,
    surface = White,
    onSurface = Black,
    primaryContainer = SurfaceLight,
    onPrimaryContainer = Black,
)


@Composable
fun QuickShopTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    dynamicColor: Boolean = false,
    content: @Composable () -> Unit
) {
    val colorScheme = when {
        dynamicColor && Build.VERSION.SDK_INT >= Build.VERSION_CODES.S -> {
            val context = LocalContext.current
            if (darkTheme) dynamicDarkColorScheme(context) else dynamicLightColorScheme(context)
        }

        darkTheme -> DarkColorScheme
        else -> LightColorScheme
    }

    MaterialTheme(
        colorScheme = colorScheme,
        typography = Typography,
        content = content
    )

}
