import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'android_id_method_channel.dart';

abstract class AndroidIdPlatform extends PlatformInterface {
  /// Constructs a AndroidIdPlatform.
  AndroidIdPlatform() : super(token: _token);

  static final Object _token = Object();

  static AndroidIdPlatform _instance = MethodChannelAndroidId();

  /// The default instance of [AndroidIdPlatform] to use.
  ///
  /// Defaults to [MethodChannelAndroidId].
  static AndroidIdPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AndroidIdPlatform] when
  /// they register themselves.
  static set instance(AndroidIdPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getId() => _instance.getId();
}
