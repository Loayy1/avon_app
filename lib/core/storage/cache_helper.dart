import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _prefs;

  static const String tokenKey = "auth_token";
  static const String refreshTokenKey = "refresh_token";
  static const String userPhoneKey = "user_phone";

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<bool> saveToken(String token) async {
    await init();
    return await _prefs!.setString(tokenKey, token);
  }

  static String? getToken() {
    return _prefs?.getString(tokenKey);
  }

  static Future<bool> removeToken() async {
    await init();
    return await _prefs!.remove(tokenKey);
  }

  static Future<bool> saveString(String key, String value) async {
    await init();
    return await _prefs!.setString(key, value);
  }

  static String? getString(String key) {
    return _prefs?.getString(key);
  }

  static Future<bool> clearAll() async {
    await init();
    return await _prefs!.clear();
  }
}
