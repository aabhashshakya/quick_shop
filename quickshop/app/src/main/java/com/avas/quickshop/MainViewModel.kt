package com.avas.quickshop

/// Created by Aabhash Shakya on 19/11/2025
import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.avas.quickshop.features.login.data.AuthRepository
import com.avas.quickshop.flutter_utils.FlutterEvent
import com.avas.quickshop.flutter_utils.FlutterEventsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MainViewModel @Inject constructor(
    private val authRepository: AuthRepository,
    private val flutterEventsRepository: FlutterEventsRepository
) : ViewModel() {


    private val _isUserLoggedIn = MutableStateFlow<Boolean?>(null)
    val isUserLoggedIn = _isUserLoggedIn.asStateFlow()
    val uuid = authRepository.uuidFlow

    private val _flutterEvent = MutableStateFlow<FlutterEvent?>(null)
    val flutterEvent: StateFlow<FlutterEvent?> = _flutterEvent

    init {
        observeFlutterEvents()
        viewModelScope.launch {
            getStartDestination()
        }
    }

    suspend fun getStartDestination() {
        _isUserLoggedIn.value = authRepository.isUserLoggedIn()
    }


    private fun observeFlutterEvents() {
        viewModelScope.launch {
            flutterEventsRepository.events.collect { event ->

                when (event) {

                    is FlutterEvent.CacheUUID -> {
                        Log.i("FlutterEvent", "Cached uuid")
                        authRepository.saveUUID(event.uuid)
                    }

                    is FlutterEvent.ProductSelected -> {
                        // You can handle this if needed
                        Log.i("FlutterEvent", "Payment complete")
                        _flutterEvent.value = event
                    }

                    is FlutterEvent.UserLoggedOut -> {
                        Log.i("FlutterEvent", "User logged out")
                        authRepository.logout()

                    }

                }
            }
        }
    }

    fun clearFlutterEvent() {
        _flutterEvent.value = null
    }
}
