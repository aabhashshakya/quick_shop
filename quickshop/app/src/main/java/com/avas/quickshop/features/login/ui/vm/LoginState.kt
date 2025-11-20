package com.avas.quickshop.features.login.ui.vm

/// Created by Aabhash Shakya on 18/11/2025
data class LoginState(
    val username: String = "",
    val password: String = "",
    val usernameError: String? = null,
    val passwordError: String? = null,
    val isLoading: Boolean = false,
    val loginSuccess: Boolean = false,
)
