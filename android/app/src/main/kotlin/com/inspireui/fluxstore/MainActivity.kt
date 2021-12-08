package com.inspireui.fluxstore

import android.content.Context
import androidx.annotation.NonNull
import com.google.android.gms.common.GoogleApiAvailability
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

// Replace 'com.inspireui.fluxstore' with your package name.
const val PACKAGE_NAME = "com.inspireui.fluxstore"

// DO NOT CHANGE THESE TWO LINES BELOW.
const val IS_GMS_AVAILABLE = "isGmsAvailable"
const val GMS_CHECK_METHOD_CHANNEL = "$PACKAGE_NAME/$IS_GMS_AVAILABLE"

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, GMS_CHECK_METHOD_CHANNEL).setMethodCallHandler { call, result ->
            // Note: This method is invoked on the main thread.
            when (call.method) {
                IS_GMS_AVAILABLE -> {
                    result.success(isGmsAvailable())
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun isGmsAvailable(): Boolean {
        return try {
            val context: Context = this@MainActivity.context
            val result: Int = GoogleApiAvailability.getInstance().isGooglePlayServicesAvailable(context)
            result == com.google.android.gms.common.ConnectionResult.SUCCESS
        } catch (_: Exception) {
            // Ignore errors. No GMS available as default.
            false
        }
    }
}