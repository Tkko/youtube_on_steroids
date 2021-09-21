import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFacade {
  static SharedPreferences _preferences;

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future clear() async => _preferences.clear();

  static Future setStringList(String key, List<String> list) async => await _preferences.setStringList(key, list);

  static List<String> getStringList(String key)  => _preferences.getStringList(key);
}