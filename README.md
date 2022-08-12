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

final String androidId = await _androidIdPlugin.getId();
```

## Google Play

Before using this plugin in your app, make sure to follow Google Play guidelines.
For example [here](https://support.google.com/googleplay/android-developer/answer/6048248#zippy=%2Cpersistent-identifiers-including-android-id):

<blockquote>
<b>Persistent identifiers, including Android ID</b>

Use for non-advertising purposes
You can use persistent identifiers as long as you have a [privacy policy](https://support.google.com/googleplay/android-developer/answer/9859455) and handle the data in accordance with the [Developer Distribution Agreement](https://play.google.com/about/developer-distribution-agreement.html#use) and all applicable privacy laws in the areas where you make your app available.
</blockquote>
