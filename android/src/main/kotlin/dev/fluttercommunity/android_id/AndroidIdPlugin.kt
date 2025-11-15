package dev.fluttercommunity.android_id

import android.annotation.SuppressLint
import android.content.ContentResolver
import android.provider.Settings
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** AndroidIdPlugin */
class AndroidIdPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel

  private lateinit var contentResolver: ContentResolver

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    contentResolver = flutterPluginBinding.applicationContext.contentResolver
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "android_id")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getId" -> {
        try {
          result.success(getAndroidId())
        } catch (e: Exception) {
          result.error("ERROR_GETTING_ID", "Failed to get Android ID", e.localizedMessage)
        }
      }
      else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  // Fetch the Android ID while suppressing lint warning about hardware IDs
  @SuppressLint("HardwareIds")
  private fun getAndroidId(): String? {
    return Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
  }

  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val plugin = AndroidIdPlugin()
      plugin.contentResolver = registrar.context().contentResolver
      plugin.channel = MethodChannel(registrar.messenger(), "android_id")
      plugin.channel.setMethodCallHandler(plugin)
    }
  }
}
