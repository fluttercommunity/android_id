import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The plugin class for retrieving the Android ID.
class AndroidId {
  const AndroidId();

  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('android_id');

  /// Calls the native method to retrieve the Android ID.
  ///
  /// Returns the Android ID on Android devices, or null on other platforms
  /// or if the plugin is not properly registered.
  Future<String?> getId() async {
    final isAndroid =
        !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return null;

    try {
      return await _methodChannel.invokeMethod<String?>('getId');
    } on MissingPluginException {
      // Plugin is not registered (e.g., using legacy v1 embedding)
      return null;
    }
  }
}
