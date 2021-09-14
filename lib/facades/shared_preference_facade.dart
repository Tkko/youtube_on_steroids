import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceFacade {
  static SharedPreferences _preferences;

  static String _key;

  static void setKey(String key) {
    _key = key;
  }

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future clear() async => _preferences.clear();

  static Future setStringList(List<String> list) async => await _preferences.setStringList(_key, list);

  static List<String> getStringList()  => _preferences.getStringList(_key);
}