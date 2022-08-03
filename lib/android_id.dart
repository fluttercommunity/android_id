import 'android_id_platform_interface.dart';

class AndroidId {
  Future<String?> getId() {
    return AndroidIdPlatform.instance.getId();
  }
}
