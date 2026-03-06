import 'package:get_storage/get_storage.dart';

class StorageService {
  static final GetStorage _storage = GetStorage();

  static Future<void> init() async {
    await GetStorage.init();
  }

  static Future<void> write(String key, dynamic value) async {
    await _storage.write(key, value);
  }
  static dynamic read(String key)  {
    return _storage.read(key);
  }

  static Future<void> saveLanguage(String language) async {
    await _storage.write('til', language);
  }

  static String? getLanguage() {
    return _storage.read<String>('til');
  }

  static Future<void> savePushNotificationEnabled(bool enabled) async {
    await _storage.write('push_notifications_enabled', enabled);
  }

  static bool getPushNotificationEnabled() {
    return _storage.read<bool>('push_notifications_enabled') ?? false;
  }
}
