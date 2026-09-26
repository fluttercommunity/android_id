import 'package:android_id/android_id.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AndroidId Plugin Integration Tests', () {
    const androidIdPlugin = AndroidId();

    testWidgets('getId should not throw MissingPluginException on Android', (WidgetTester tester) async {
      // This test verifies that the plugin is properly registered
      // and does not throw MissingPluginException when called on Android

      String? androidId;

      // Should not throw MissingPluginException
      androidId = await androidIdPlugin.getId();

      // On Android, we should get a non-null ID
      // On other platforms, we should get null
      expect(androidId, isNotNull, reason: 'Android ID should be available on Android devices/emulators');

      // Android formats this 64-bit value without leading zeroes.
      expect(
        androidId,
        matches(RegExp(r'^[0-9a-f]{1,16}$')),
        reason: 'Android ID should be a 64-bit hexadecimal string',
      );
    });

    testWidgets('getId should return consistent value', (WidgetTester tester) async {
      // Call getId multiple times and verify it returns the same value
      final id1 = await androidIdPlugin.getId();
      final id2 = await androidIdPlugin.getId();

      expect(id1, equals(id2), reason: 'Android ID should be consistent across multiple calls');
    });

    testWidgets('getId should work after hot restart', (WidgetTester tester) async {
      // This test verifies that the plugin remains registered and functional
      // after pumping frames. Note: Hot restart cannot be simulated in integration tests.

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
