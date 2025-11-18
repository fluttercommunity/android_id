import 'package:android_id/android_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const plugin = AndroidId();
  const channel = MethodChannel('android_id');

  TestWidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (methodCall) async => '42');
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getAndroidId', () async {
    expect(await plugin.getId(), '42');
  });

  test('returns null when plugin is not registered', () async {
    // Remove the mock handler to simulate MissingPluginException
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);

    // Should return null instead of throwing MissingPluginException
    expect(await plugin.getId(), null);
  });

  test('returns null on non-Android platforms', () async {
    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    // Should return null on iOS without calling the method channel
    expect(await plugin.getId(), null);

    // Reset to Android for other tests
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
  });
}
