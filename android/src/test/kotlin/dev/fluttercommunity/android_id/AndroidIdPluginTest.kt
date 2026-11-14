package dev.fluttercommunity.android_id

import android.content.ContentResolver
import android.provider.Settings
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import org.junit.Before
import org.junit.Test
import org.junit.runner.RunWith
import org.mockito.Mockito.*
import org.robolectric.RobolectricTestRunner
import org.robolectric.RuntimeEnvironment
import org.robolectric.annotation.Config
import org.robolectric.annotation.Implementation
import org.robolectric.annotation.Implements

@RunWith(RobolectricTestRunner::class)
@Config(sdk = [24, 26, 36])
class AndroidIdPluginTest {
  private lateinit var plugin: AndroidIdPlugin
  private lateinit var binding: FlutterPlugin.FlutterPluginBinding
  private lateinit var messenger: BinaryMessenger
  private lateinit var result: MethodChannel.Result

  @Before
  fun setUp() {
    plugin = AndroidIdPlugin()
    binding = mock(FlutterPlugin.FlutterPluginBinding::class.java)
    messenger = mock(BinaryMessenger::class.java)
    result = mock(MethodChannel.Result::class.java)
    `when`(binding.applicationContext).thenReturn(RuntimeEnvironment.getApplication())
    `when`(binding.binaryMessenger).thenReturn(messenger)
    plugin.onAttachedToEngine(binding)
  }

  @Test
  fun returnsTheSecureAndroidId() {
    Settings.Secure.putString(binding.applicationContext.contentResolver, Settings.Secure.ANDROID_ID, "abc123")
    plugin.onMethodCall(MethodCall("getId", null), result)
    verify(result).success("abc123")
    verifyNoMoreInteractions(result)
  }

  @Test
  fun returnsNullWhenTheSettingIsUnavailable() {
    Settings.Secure.putString(binding.applicationContext.contentResolver, Settings.Secure.ANDROID_ID, null)
    plugin.onMethodCall(MethodCall("getId", null), result)
    verify(result).success(null)
    verifyNoMoreInteractions(result)
  }

  @Test
  @Config(shadows = [DeniedSecureSettings::class])
  fun returnsPlatformErrorWhenTheSettingCannotBeRead() {
    plugin.onMethodCall(MethodCall("getId", null), result)
    verify(result).error("ERROR_GETTING_ID", "Failed to get Android ID", "Access denied")
    verifyNoMoreInteractions(result)
  }

  @Test
  fun unknownMethodsAreNotImplemented() {
    plugin.onMethodCall(MethodCall("unknown", null), result)
    verify(result).notImplemented()
    verifyNoMoreInteractions(result)
  }

  @Test
  fun detachingUnregistersTheChannel() {
    clearInvocations(messenger)
    plugin.onDetachedFromEngine(binding)
    verify(messenger).setMessageHandler("android_id", null)
  }
}

@Implements(Settings.Secure::class)
class DeniedSecureSettings {
  companion object {
    @JvmStatic
    @Implementation
    fun getString(resolver: ContentResolver, name: String): String? {
      if (name == Settings.Secure.ANDROID_ID) throw SecurityException("Access denied")
      return null
    }
  }
}
