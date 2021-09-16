import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/models/history_item.dart';

class WatchHistory {
  const WatchHistory();

  void saveHistory(Video video) async {
    print('saving history...');
    var historyItem = new HistoryItem(
      videoId: video.id.toString(),
      channelName: video.author,
      duration: _durationToString(video.duration, video.isLive),
      isLive: video.isLive,
      thumbnailUrl: video.thumbnails.lowResUrl,
      views: video.engagement.viewCount,
      title: video.title,
    );
    final prefs = await SharedPreferences.getInstance();
    print('got prefs in save');
    var historyList = prefs.getStringList('video_history') ?? [];
    historyList.removeWhere(
        (element) => element == jsonEncode(HistoryItem.toMap(historyItem)));
    print('replaced old');

    if (historyList.length == 20) {
      historyList.removeAt(0);
    }
    historyList.add(jsonEncode(HistoryItem.toMap(historyItem)));
    prefs.setStringList('video_history', historyList);
    print(historyList);
    print('added to history');
  }

  static Future<List<HistoryItem>> getHistory() async {
    // print('getting history');
    final prefs = await SharedPreferences.getInstance();
    // print('got prefs in get');
    List<String> history = prefs.getStringList('video_history') ?? [];
    // print(history);
    List<HistoryItem> item = List.from(
        history.map((model) => HistoryItem.fromJson(json.decode(model))));
    item = new List.from(item.reversed);
    // List<HistoryItem> videos = List<HistoryItem>.from(jsonDecode(history));
    // print(videos);
    return item;
  }

  void deleteHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('video_history').then((value) => print(value));
    print('removed');
  }

  String _durationToString(Duration duration, bool isLive) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (isLive) {
      return 'LIVE';
    }
    if (duration.inHours == 0) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
