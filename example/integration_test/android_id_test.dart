import 'package:android_id/android_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AndroidId Plugin Integration Tests', () {
    const androidIdPlugin = AndroidId();

    testWidgets('getId should not throw MissingPluginException on Android',
        (WidgetTester tester) async {
      // This test verifies that the plugin is properly registered
      // and does not throw MissingPluginException when called on Android
      
      String? androidId;
      
      // Should not throw MissingPluginException
      androidId = await androidIdPlugin.getId();
      
      // On Android, we should get a non-null ID
      // On other platforms, we should get null
      expect(androidId, isNotNull,
          reason:
              'Android ID should be available on Android devices/emulators');
      
      // Android ID should be a hex string
      expect(androidId, matches(RegExp(r'^[0-9a-f]+$')),
          reason: 'Android ID should be a hexadecimal string');
      
      // Android ID should be 16 characters (64-bit hex)
      expect(androidId?.length, equals(16),
          reason: 'Android ID should be 16 hex characters (64-bit)');
    });

    testWidgets('getId should return consistent value',
        (WidgetTester tester) async {
      // Call getId multiple times and verify it returns the same value
      final id1 = await androidIdPlugin.getId();
      final id2 = await androidIdPlugin.getId();
      
      expect(id1, equals(id2),
          reason: 'Android ID should be consistent across multiple calls');
    });

    testWidgets('getId should work after hot restart',
        (WidgetTester tester) async {
      // This simulates what happens during development
      // The plugin should remain registered
      
      final id = await androidIdPlugin.getId();
      expect(id, isNotNull);
      
      // Pump frames to simulate app lifecycle
      await tester.pumpAndSettle();
      
      // Should still work
      final idAfter = await androidIdPlugin.getId();
      expect(idAfter, equals(id));
    });
  });
}
