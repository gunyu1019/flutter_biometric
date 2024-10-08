package kr.yhs.flutter_biometric

import androidx.annotation.NonNull

import android.os.Build
import androidx.annotation.NonNull
import android.content.Context
import android.app.Activity
import androidx.biometric.BiometricPrompt
import androidx.biometric.BiometricPrompt.PromptInfo
import androidx.biometric.BiometricManager

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding

/** FlutterBiometricPlugin */
class FlutterBiometricPlugin: FlutterPlugin, MethodCallHandler, ActivityAware {
  private lateinit var channel : MethodChannel
    private lateinit var activity: Activity
    private lateinit var context: Context

    // Flutter Plugin
  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_biometric")
    channel.setMethodCallHandler(this)
  }
  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  // MethodCallHandler
  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "canAuthorization") {
        val result = this.canAuthorization()
        when(result) {
            BiometricManager.BIOMETRIC_SUCCESS => result.success(10)
            BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE => result.success(01)
            BiometricManager.BIOMETRIC_ERROR_HW_UNAVAILABLE => result.success(02)
            BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED => result.success(05)
            else => result.error()
        }
    } else {
      result.notImplemented()
    }
  }

  // ActivityAware
  override fun onAttachedToActivity(activityPluginBinding: ActivityPluginBinding) {
    activity = activityPluginBinding.activity;
  }

  override fun onDetachedFromActivity() = Unit;

    // In Method
    fun canAuthorization(): int {
        val biometricManager = BiometticManager.from(context)
        return biometricManager.canAuthenticate(BiometricManager.Authenticators.BIOMETRIC_WEAK)
    }
}
