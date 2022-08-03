import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'android_id_platform_interface.dart';

/// An implementation of [AndroidIdPlatform] that uses method channels.
class MethodChannelAndroidId extends AndroidIdPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('android_id');

  @override
  Future<String?> getId() async {
    final version = await methodChannel.invokeMethod<String>('getId');
    return version;
  }
}
