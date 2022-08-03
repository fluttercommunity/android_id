import 'package:flutter/services.dart';

/// The plugin class for retrieving the Android ID.
class AndroidId {
  const AndroidId();

  /// The method channel used to interact with the native platform.
  static const methodChannel = MethodChannel('android_id');

  /// Calls the native method to retrieve the Android ID.
  Future<String?> getId() => methodChannel.invokeMethod('getId');
}
