# android_id

[![Flutter Community: android_id](https://fluttercommunity.dev/_github/header/android_id)](https://github.com/fluttercommunity/community)

![Pub Version](https://img.shields.io/pub/v/android_id)

A Flutter plugin for retrieving the Android ID.

## Getting started

* Add plugin to pubspec.yaml
* Use it in your code (see examples of all methods below)

## Usage

```dart
const _androidIdPlugin = AndroidId();

final String? androidId = await _androidIdPlugin.getId();
```

Optional defensive handling - treats registration/runtime failures as null instead of crashing:

```dart
const _androidIdPlugin = AndroidId();

String? androidId;
try {
  androidId = await _androidIdPlugin.getId();
} on MissingPluginException {
  print('Failed to get Android ID: MissingPluginException');
  androidId = null;
} on PlatformException catch (e) {
  print('Failed to get Android ID: ${e.message}');
  androidId = null;
}
```

**Note:** `getId()` returns `null` on non-Android platforms (iOS, Web, etc.). On Android, it throws `MissingPluginException` if the plugin is not properly registered (see more [below](https://pub.dev/packages/android_id#troubleshooting)).

## Important

Please note that on `Android 8` and above, the `Android ID` is not unique per device, but also per signing key the app was built with:

<blockquote>
On Android 8.0 (API level 26) and higher versions of the platform, a 64-bit number (expressed as a hexadecimal string), <b>unique to each combination of app-signing key, user, and device.</b>

The value may change if a factory reset is performed on the device or if an APK signing key changes.
</blockquote>

[Android API reference](https://developer.android.com/reference/android/provider/Settings.Secure#ANDROID_ID)

[Stack Overflow explanation](https://stackoverflow.com/a/43393373)

## Google Play

Before using this plugin in your app, make sure to follow Google Play guidelines.
For example [here](https://support.google.com/googleplay/android-developer/answer/6048248#zippy=%2Cpersistent-identifiers-including-android-id):

<blockquote>
<b>Persistent identifiers, including Android ID</b>

Use for non-advertising purposes<br>
You can use persistent identifiers as long as you have a [privacy policy](https://support.google.com/googleplay/android-developer/answer/9859455) and handle the data in accordance with the [Developer Distribution Agreement](https://play.google.com/about/developer-distribution-agreement.html#use) and all applicable privacy laws in the areas where you make your app available.
</blockquote>

## Troubleshooting

If you're experiencing `MissingPluginException`, try these steps in order:

1. **Full Rebuild**: Stop the app completely and rebuild from scratch
   ```bash
   flutter clean
   flutter pub get
   flutter run
   ```

2. **Check Flutter Version**: Ensure you're using Flutter 3.10.0 or higher
   ```bash
   flutter --version
   ```

3. **Verify Android Embedding**: Check `android/app/src/main/.../MainActivity.kt` (or `.java`)
    - Should import: `io.flutter.embedding.android.FlutterActivity`
    - Should NOT import: `io.flutter.app.FlutterActivity` (legacy v1 embedding)

   If using v1 embedding, migrate to v2 following [this guide](https://github.com/flutter/flutter/blob/main/docs/platforms/android/Upgrading-pre-1.12-Android-projects.md)

4. **Check Hot Reload**: Plugin registration happens during cold start. If using hot reload/restart:
    - Stop the app completely
    - Run `flutter run` again (not hot restart)

5. **Invalidate Caches**: For Android Studio/IntelliJ:
    - File → Invalidate Caches → Invalidate and Restart

6. **Test on Real Device**: If on emulator, try on a physical Android device

If none of these work, please open an issue with:
- Flutter version (`flutter --version`)
- Output of `flutter doctor -v`
- Your `pubspec.yaml` dependencies
- Full error stack trace
- Whether it happens in a fresh project (`flutter create test_app`)
