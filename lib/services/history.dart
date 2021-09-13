import 'package:shared_preferences/shared_preferences.dart';

class HistoryController {
  //TODO

  static void saveHistory(String videoId) async {
    print('saving history...');
    final prefs = await SharedPreferences.getInstance();
    print('got prefs in save');
    List<String> historyList = prefs.getStringList('video_history') ?? [];
    historyList.removeWhere((element) => element == videoId);
    print('replaced old');

    if (historyList.length == 20) {
      historyList.removeAt(0);
    }
    historyList.add(videoId);
    prefs.setStringList('video_history', historyList);

    print('added to history');
  }

  static Future<List<String>> getHistory() async {
    print('getting history');
    final prefs = await SharedPreferences.getInstance();
    print('got prefs in get');
    List<String> history = prefs.getStringList('video_history') ?? [];
    print(history);

    history = new List.from(history.reversed);
    print(history);

    return history;
  }
}
