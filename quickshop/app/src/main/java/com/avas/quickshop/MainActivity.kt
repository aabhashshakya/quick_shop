package com.avas.quickshop

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.os.Bundle
import android.util.Log
import androidx.activity.addCallback
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.activity.viewModels
import androidx.compose.foundation.background
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.*
import androidx.compose.material3.ColorScheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.*
import androidx.compose.ui.Modifier
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.core.view.WindowCompat
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.commit
import com.avas.quickshop.core.App.Companion.ENGINE_ID
import com.avas.quickshop.core.App.Companion.METHOD_CHANNEL
import com.avas.quickshop.features.login.ui.LoginScreen
import com.avas.quickshop.features.payment_success.PaymentSuccessScreen
import com.avas.quickshop.flutter_utils.FlutterEvent
import com.avas.quickshop.flutter_utils.app_config.getAppTheme
import com.avas.quickshop.ui.theme.QuickShopTheme
import com.avas.quickshop.ui.theme.app_config.AppConfig
import dagger.hilt.android.AndroidEntryPoint
import io.flutter.embedding.android.FlutterFragment
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.plugin.common.MethodChannel

@AndroidEntryPoint
class MainActivity : FragmentActivity() {

    private val mainViewModel: MainViewModel by viewModels()

    companion object {
        const val FLUTTER_FRAGMENT_TAG = "flutter_fragment"

        val FLUTTER_CONTAINER_ID =
            android.R.id.content //use activity's layout
    }

    private var flutterFragment: FlutterFragment? = null

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        installSplashScreen().setKeepOnScreenCondition {
            mainViewModel.isUserLoggedIn.value == null
        }

        flutterFragment = savedInstanceState?.let {
            supportFragmentManager.findFragmentByTag(FLUTTER_FRAGMENT_TAG) as? FlutterFragment
        } ?: run {
            FlutterFragment.withCachedEngine(ENGINE_ID).shouldAttachEngineToActivity(true)
                .build<FlutterFragment>()
        }

        // Handle hardware back within flutter
        onBackPressedDispatcher.addCallback(this) {
            flutterFragment?.onBackPressed() ?: moveTaskToBack(true)
        }


        setContent {
            QuickShopTheme {
                val uuid by mainViewModel.uuid.collectAsState(null)
                val flutterEvent by mainViewModel.flutterEvent.collectAsState(initial = null)
                val isDark = isSystemInDarkTheme()
                val colorScheme = MaterialTheme.colorScheme

                SideEffect {

                    WindowCompat.getInsetsController(
                        window,
                        window.decorView
                    ).isAppearanceLightStatusBars = !isDark

                }

                LaunchedEffect(uuid, flutterEvent) {
                    when {
                        uuid.isNullOrEmpty() -> {
                            removeFlutterFragment()
                        }

                        flutterEvent is FlutterEvent.ProductSelected -> removeFlutterFragment()
                        else -> {

                            addFlutterFragment(
                                uuid!!,
                                shouldCacheUUID = false,
                                isDark,
                                colorScheme
                            )
                        }
                    }
                }

                Scaffold(
                    Modifier
                        .fillMaxSize()
                        .background(
                            MaterialTheme.colorScheme.surface
                        )
                ) { padding ->
                    Box(modifier = Modifier.padding(padding)) {
                        when {
                            uuid.isNullOrEmpty() -> LoginScreen(onLoginClicked = { generatedUUID ->

                                addFlutterFragment(
                                    generatedUUID,
                                    shouldCacheUUID = true,
                                    isDark,
                                    colorScheme
                                )
                            })

                            flutterEvent is FlutterEvent.ProductSelected -> {
                                val product = (flutterEvent as FlutterEvent.ProductSelected).product
                                PaymentSuccessScreen(
                                    product = product,
                                    modifier = Modifier.fillMaxSize(),
                                    onContinueShopping = {
                                        mainViewModel.clearFlutterEvent()
                                        // LaunchedEffect will handle re-adding Flutter
                                    })
                            }

                            else -> {
                                // Placeholder while Flutter overlays the container
                                Box(
                                    modifier = Modifier
                                        .fillMaxSize()
                                        .background(MaterialTheme.colorScheme.surface)
                                )
                            }
                        }
                    }
                }
            }
        }
    }


    private fun addFlutterFragment(
        uuid: String,
        shouldCacheUUID: Boolean,
        isDark: Boolean,
        colorScheme: ColorScheme
    ) {
        flutterFragment?.let { fragment ->
            if (supportFragmentManager.findFragmentByTag(FLUTTER_FRAGMENT_TAG) == null) {
                sendAppConfigToFlutter(
                    uuid,
                    shouldCacheUUID,
                    isDark,
                    colorScheme
                )
                supportFragmentManager.commit {
                    add(FLUTTER_CONTAINER_ID, fragment, FLUTTER_FRAGMENT_TAG)
                }

            }
        }
    }

    private fun removeFlutterFragment() {
        flutterFragment?.let { fragment ->
            if (supportFragmentManager.findFragmentByTag(FLUTTER_FRAGMENT_TAG) != null) {
                supportFragmentManager.commit {
                    remove(fragment)
                }
            }
        }
    }

    private fun sendAppConfigToFlutter(
        uuid: String,
        shouldCacheUUID: Boolean,
        isDark: Boolean,
        colorScheme: ColorScheme
    ) {
        val engine = FlutterEngineCache.getInstance().get(ENGINE_ID) ?: return
        MethodChannel(engine.dartExecutor.binaryMessenger, METHOD_CHANNEL).invokeMethod(
            "setAppConfig",
            AppConfig(
                uuid = uuid,
                shouldCacheUUID = shouldCacheUUID,
                theme = getAppTheme(isDark, colorScheme)
            ).toJson()
        )
    }

    // --------------------------------------------------------------------
    // FLUTTER LIFECYCLE FORWARDING
    // --------------------------------------------------------------------
    override fun onPostResume() {
        super.onPostResume()
        flutterFragment?.onPostResume()
    }

    @SuppressLint("MissingSuperCall")
    override fun onNewIntent(intent: Intent) {
        flutterFragment?.onNewIntent(intent)
    }

    @SuppressLint("MissingSuperCall")
    override fun onRequestPermissionsResult(
        requestCode: Int, permissions: Array<out String>, grantResults: IntArray
    ) {
        flutterFragment?.onRequestPermissionsResult(requestCode, permissions, grantResults)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        flutterFragment?.onActivityResult(requestCode, resultCode, data)
    }

    @SuppressLint("MissingSuperCall")
    override fun onUserLeaveHint() {
        flutterFragment?.onUserLeaveHint()
    }

    override fun onTrimMemory(level: Int) {
        super.onTrimMemory(level)
        flutterFragment?.onTrimMemory(level)
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.i("lifecycle", "Activity destroyed!")
    }
}

private tailrec fun Context.findActivity(): Activity? = when (this) {
    is Activity -> this
    is ContextWrapper -> baseContext.findActivity()
    else -> null
}