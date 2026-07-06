## 0.5.2+1

* Reorder README sections.

## 0.5.2

* Support Android Gradle Plugin 9 and Flutter's built-in Kotlin mode while keeping
  AGP 8 and Flutter's temporary `android.builtInKotlin=false` opt-out working.
* Stop declaring plugin-owned Android Gradle Plugin and Kotlin Gradle Plugin classpaths.
* Update the example Android app to Android Gradle Plugin 9.1.1.
* Tested example integration tests with:

  | Flutter | AGP | Kotlin mode |
  | --- | --- | --- |
  | 3.44.4 stable | 9.1.1 | Flutter AGP 9 opt-out |
  | 3.44.0 | 9.1.1 | Flutter AGP 9 opt-out |
  | 3.41.9 | 8.13.2 | legacy KGP |
  | 3.35.7 | 8.13.2 | legacy KGP |
  | 3.32.8 | 8.13.2 | legacy KGP |

* Thanks to @raph5640, @amanvishwakarma96, and @Joschiller for reporting the AGP 9 build problem.

## 0.5.1

* Add integration tests to verify plugin functionality across Android API levels
* Add unit coverage to ensure the plugin returns `null` on non-Android platforms
* Expand README with comprehensive troubleshooting guidance and defensive error-handling examples

## 0.5.0

* Breaking: Flutter SDK constraint is now >=3.10.0 (Dart 3-only). Apps on older Flutter versions can’t upgrade.
* Update Android tooling

## 0.4.1

* Maintenance release

## 0.4.0

* Upgrade Android dependencies (Gradle, AGP, Java, Kotlin)
* Widen `flutter_lints` constraints

## 0.3.6

* Return `null` on platforms other than Android, instead of throwing an exception

## 0.3.5

* Maintenance release
* Update `kotlin` and `gradle`

## 0.3.4

* Refactor native code

## 0.3.3

* Add topics to pubspec.yaml

## 0.3.2

* Improve `namespace` fix for `Android Gradle Plugin` versions < 7

## 0.3.1

* Fix `namespace` for `Android Gradle Plugin` versions < 7

## 0.3.0

* Add `namespace` for compatibility with `Android Gradle Plugin 8`
* Update `Gradle` version

## 0.2.0

* Update `Gradle` version
* Update `Android Gradle plugin` version
* Update `Kotlin` version
* Add Gradle wrapper files
* Update `pubspec.lock` of example (`url: "https://pub.dev"`)

## 0.1.3+1

* Improve readme: Add explanation for connection of `Android ID` and signing key

## 0.1.3

* Add building of example app to GitHub workflows
* Remove unneeded code

## 0.1.2

* Add `Flutter test` for example app to workflows

## 0.1.1+1

* Update readme

## 0.1.1

* Update example app dependencies

## 0.1.0

* Rename Android `applicationId`
* Recreate `android` folder from template

## 0.0.8

* Add more GitHub Actions for checking code quality
* Update kotlin_version from 1.6.10 to 1.7.20
* Update gradle from 7.1.2 to 7.3.1
* Add dependabot

## 0.0.7

* Add Google Play information to README.

## 0.0.6

* Lower minimal sdk version to `2.12.0`.

## 0.0.5

* Documentation typo fix.

## 0.0.4

* Small improvements.

## 0.0.3

* Improve example.

## 0.0.2

* Enhance description to get full pub.dev score.

## 0.0.1

* Initial release.
