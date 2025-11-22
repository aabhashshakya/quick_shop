package com.avas.quickshop.features.login.ui.vm

import androidx.lifecycle.SavedStateHandle
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.avas.quickshop.features.login.data.AuthRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import java.util.UUID
import javax.inject.Inject

@HiltViewModel
class LoginViewModel @Inject constructor(
    private val repository: AuthRepository,
    savedStateHandle: SavedStateHandle
) : ViewModel() {

    private val _state = MutableStateFlow(LoginState())
    val state: StateFlow<LoginState> = _state.asStateFlow()

    // update username
    fun onUsernameChanged(username: String) {
        _state.update { it.copy(username = username, usernameError = null) }
    }

    // update password
    fun onPasswordChanged(password: String) {
        _state.update { it.copy(password = password, passwordError = null) }
    }

    // handle login
    fun login(onSuccess: (String) -> Unit) {
        val current = _state.value
        var hasError = false
        var usernameError: String? = null
        var passwordError: String? = null

        if (current.username.isBlank()) {
            usernameError = "Username cannot be empty"
            hasError = true
        }
        if (current.password.isBlank()) {
            passwordError = "Password cannot be empty"
            hasError = true
        }

        if (hasError) {
            _state.update {
                it.copy(usernameError = usernameError, passwordError = passwordError)
            }
            return
        }

        viewModelScope.launch {
            val generatedUUID = UUID.randomUUID().toString()
            onSuccess(generatedUUID)

            _state.update {
                it.copy(
                    loginSuccess = true,
                    username = "",
                    password = "",
                    usernameError = null,
                    passwordError = null
                )
            }
        }
    }
}