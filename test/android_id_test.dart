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
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getAndroidId', () async {
    expect(await plugin.getId(), '42');
  });

  test('returns null on non-Android platforms', () async {
    addTearDown(() => debugDefaultTargetPlatformOverride = null);

    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;

    expect(await plugin.getId(), isNull);

    debugDefaultTargetPlatformOverride = TargetPlatform.iOS;

    expect(await plugin.getId(), isNull);

    debugDefaultTargetPlatformOverride = TargetPlatform.linux;

    expect(await plugin.getId(), isNull);

    debugDefaultTargetPlatformOverride = TargetPlatform.macOS;

    expect(await plugin.getId(), isNull);

    debugDefaultTargetPlatformOverride = TargetPlatform.windows;

    expect(await plugin.getId(), isNull);

    debugDefaultTargetPlatformOverride = TargetPlatform.android;

    expect(await plugin.getId(), '42');
  });
}
