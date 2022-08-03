import 'package:android_id/android_id.dart';
import 'package:android_id/android_id_method_channel.dart';
import 'package:android_id/android_id_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAndroidIdPlatform
    with MockPlatformInterfaceMixin
    implements AndroidIdPlatform {
  @override
  Future<String?> getId() => Future.value('42');
}

void main() {
  final AndroidIdPlatform initialPlatform = AndroidIdPlatform.instance;

  test('$MethodChannelAndroidId is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAndroidId>());
  });

  test('getAndroidId', () async {
    AndroidId androidIdPlugin = AndroidId();
    MockAndroidIdPlatform fakePlatform = MockAndroidIdPlatform();
    AndroidIdPlatform.instance = fakePlatform;

    expect(await androidIdPlugin.getId(), '42');
  });
}
