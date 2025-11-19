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
