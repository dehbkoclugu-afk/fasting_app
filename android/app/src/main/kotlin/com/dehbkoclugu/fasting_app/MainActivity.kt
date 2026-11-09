package com.dehbkoclugu.fasttrack

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.os.SystemClock
import android.provider.Settings

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "fasttrack/clock")
            .setMethodCallHandler { call, result ->
                if (call.method != "snapshot") {
                    result.notImplemented()
                } else {
                    try {
                        val bootCount = Settings.Global.getInt(
                            contentResolver, Settings.Global.BOOT_COUNT
                        )
                        result.success(mapOf(
                            "wallMilliseconds" to System.currentTimeMillis(),
                            "uptimeMilliseconds" to SystemClock.elapsedRealtime(),
                            "bootCount" to bootCount.toLong()
                        ))
                    } catch (error: Exception) {
                        result.error("clock_unavailable", "System clock unavailable", null)
                    }
                }
            }
    }
}
