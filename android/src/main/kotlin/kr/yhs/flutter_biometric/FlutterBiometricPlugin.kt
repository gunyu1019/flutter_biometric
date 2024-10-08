package kr.yhs.flutter_biometric

import androidx.annotation.NonNull

import android.os.Build
import androidx.annotation.NonNull
import android.content.Context
import android.app.Activity
import androidx.biometric.BiometricPrompt
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
    } else if (call.method == "authorize") {
        val argument = call.arguments as Map<String, String>
        val promptInfo = getPrompt(
            title = argument.get("title"),
            negativeButtonText = argument.get("negativeButtonText"),
            subtitle = argument.get("subtitle"),
            description = argument.get("description")
        )
        authorize(promptInfo, object : BiometricPrompt.AuthenticationCallback() {
            override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
                super.onAuthenticationError(errorCode, errString)
                result.error(errorCode, errString)
            }

            override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
                super.onAuthenticationSucceeded(result)
                result.success(true)
            }

            override fun onAuthenticationFailed() {
                super.onAuthenticationFailed()
                result.success(false)
            }

        })
    }else {
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

    fun authorize(
        prompt: BiometricPrompt.PromptInfo
        callback: BiometricPrompt.AuthenticationCallback
    ) {
        
    }

    fun getPrompt(
        title: String,
        negativeButtonText: String,
        subtitle: String? = null
        description: String? = null
    ): BiometricPrompt.PromptInfo {
        return BiometricPrompt.PromptInfo.Builder().apply {
            // Required
            setTitle(title)
            setNegativeButtonText(negativeButtonText)

            // Optional
            setSubtitle(subtitle)
            setDescription(description)
        }.build()
    }
}
