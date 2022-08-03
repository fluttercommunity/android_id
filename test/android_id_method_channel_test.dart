import 'package:android_id/android_id_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelAndroidId platform = MethodChannelAndroidId();
  const MethodChannel channel = MethodChannel('android_id');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getAndroidId', () async {
    expect(await platform.getId(), '42');
  });
}
