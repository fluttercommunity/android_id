import 'package:android_id/android_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const plugin = AndroidId();
  const channel = MethodChannel('android_id');
  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  final calls = <MethodCall>[];

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    calls.clear();
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (call) async {
      calls.add(call);
      return '42';
    });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getId calls the native lookup', () async {
    expect(await plugin.getId(), '42');
    expect(calls.single.method, 'getId');
    expect(calls.single.arguments, isNull);
  });

  test('preserves a null native result', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (_) async => null);
    expect(await plugin.getId(), isNull);
  });

  test('preserves a native lookup failure', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (_) async {
      throw PlatformException(code: 'ERROR_GETTING_ID', message: 'Failed to get Android ID');
    });
    await expectLater(
      plugin.getId(),
      throwsA(isA<PlatformException>().having((error) => error.code, 'code', 'ERROR_GETTING_ID')),
    );
  });

  test('reports missing Android registration', () async {
    binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
    await expectLater(plugin.getId(), throwsA(isA<MissingPluginException>()));
  });

  for (final platform in TargetPlatform.values.where((platform) => platform != TargetPlatform.android)) {
    test('returns null without a native call on ${platform.name}', () async {
      debugDefaultTargetPlatformOverride = platform;
      expect(await plugin.getId(), isNull);
      expect(calls, isEmpty);
    });
  }
}
