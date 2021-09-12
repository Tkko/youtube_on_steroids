import 'package:shared_preferences/shared_preferences.dart';

class PlaylistPreference {
  static SharedPreferences _preferences;

  static String _playlistKey;

  static String setPlaylistKey(String id) {
    _playlistKey = id;
  }

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setPlaylist(List<String> playlistModel) async =>
      await _preferences.setStringList(_playlistKey, playlistModel);

  static List<String> getPlaylist()  => _preferences.getStringList(_playlistKey);

}