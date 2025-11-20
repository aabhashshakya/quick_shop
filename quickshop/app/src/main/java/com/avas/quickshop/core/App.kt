package com.avas.quickshop.core

import android.app.Application
import com.avas.quickshop.flutter_utils.FlutterEvent
import com.avas.quickshop.flutter_utils.FlutterEventsRepository
import com.avas.quickshop.flutter_utils.Product
import dagger.hilt.android.HiltAndroidApp
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import javax.inject.Inject

@HiltAndroidApp
class App : Application() {
    @Inject
    lateinit var flutterEventsRepository: FlutterEventsRepository
    lateinit var flutterEngine: FlutterEngine

    val appScope = CoroutineScope(Dispatchers.Default)


    override fun onCreate() {
        super.onCreate()
        startAndCacheFlutterEngine()
    }

    companion object {
        const val ENGINE_ID = "flutter-engine"
        const val METHOD_CHANNEL = "method-channel"
    }

    private fun startAndCacheFlutterEngine(
    ) {
        flutterEngine = FlutterEngine(this)

        // Setup channels here
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            METHOD_CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "cacheUUID" -> {
                    val uuid = call.arguments as? String ?: return@setMethodCallHandler
                    appScope.launch {
                        flutterEventsRepository.emit(
                            FlutterEvent.CacheUUID(uuid)
                        )
                    }
                    result.success(true)
                }

                "pay" -> {
                    val productJson = call.arguments as? String ?: return@setMethodCallHandler
                    val product = Json.decodeFromString<Product>(productJson)
                    appScope.launch {
                        flutterEventsRepository.emit(
                            FlutterEvent.ProductSelected(product)
                        )
                    }
                    result.success(true)
                }

                "logout" -> {
                    appScope.launch {
                        flutterEventsRepository.emit(
                            FlutterEvent.UserLoggedOut
                        )
                    }
                    result.success(true)
                }

                else -> result.notImplemented()
            }
        }

        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault(),

            )

        FlutterEngineCache.getInstance().put(ENGINE_ID, flutterEngine)
    }
}
