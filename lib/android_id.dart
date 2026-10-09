import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The plugin class for retrieving the Android ID.
class AndroidId {
  const AndroidId();

  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('android_id');

  /// Returns Android's `Settings.Secure.ANDROID_ID`, or `null` when unavailable.
  ///
  /// Returns `null` on non-Android platforms, including web. On Android 8.0 and
  /// newer, the ID is scoped to the app-signing key, user, and device; it can
  /// change after a factory reset or signing-key change.
  ///
  /// Throws [MissingPluginException] when the Android plugin is not registered
  /// and [PlatformException] when the native lookup fails.
  Future<String?> getId() async {
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return null;

    return _methodChannel.invokeMethod<String?>('getId');
  }
}
