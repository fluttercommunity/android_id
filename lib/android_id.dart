import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The plugin class for retrieving the Android ID.
class AndroidId {
  const AndroidId();

  /// The method channel used to interact with the native platform.
  static const _methodChannel = MethodChannel('android_id');

  /// Calls the native method to retrieve the Android ID.
  Future<String?> getId() async {
    final isAndroid = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    if (!isAndroid) return null;

    return _methodChannel.invokeMethod<String?>('getId');
  }
}
