package com.avas.quickshop.flutter_utils

/// Created by Aabhash Shakya on 19/11/2025
import kotlinx.coroutines.flow.MutableSharedFlow
import kotlinx.coroutines.flow.asSharedFlow
import kotlinx.serialization.Serializable
import javax.inject.Inject
import javax.inject.Singleton

@Singleton
class FlutterEventsRepository @Inject constructor() {

    private val _events = MutableSharedFlow<FlutterEvent>()
    val events = _events.asSharedFlow()

    suspend fun emit(event: FlutterEvent) {
        _events.emit(event)
    }
}

//types of events coming from Flutter
sealed class FlutterEvent {
    data class CacheUUID(val uuid: String) : FlutterEvent()

    data class ProductSelected(val product: Product) : FlutterEvent()
    object UserLoggedOut : FlutterEvent()
}


@Serializable
data class Product(
    val id: Int,
    val title: String,
    val price: Double,
    val description: String,
    val category: String,
    val image: String,
    val rating: Rating? = null
)

@Serializable
data class Rating(
    val rate: Double,
    val count: Int
)

