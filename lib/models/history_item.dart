import 'dart:convert';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class HistoryItem {
  final String videoId;
  final String title;
  final String duration;
  final bool isLive;
  final String channelName;
  final String thumbnailUrl;
  final int views;
  HistoryItem({
    this.channelName,
    this.duration,
    this.title,
    this.videoId,
    this.views,
    this.isLive,
    this.thumbnailUrl,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> jsonData) {
    return HistoryItem(
      videoId: jsonData['videoId'],
      title: jsonData['title'],
      channelName: jsonData['channelName'],
      thumbnailUrl: jsonData['thumbnailUrl'],
      isLive: jsonData['isLive'],
      duration: jsonData['duration'],
      views: jsonData['views'],
    );
  }

  static Map<String, dynamic> toMap(HistoryItem history) => {
        'videoId': history.videoId,
        'title': history.title,
        'channelName': history.channelName,
        'thumbnailUrl': history.thumbnailUrl,
        'isLive': history.isLive,
        'duration': history.duration,
        'views': history.views,
      };

  // static String encode(HistoryItem history) => json.encode(
  //       history
  //           .map<Map<String, dynamic>>((history) => HistoryItem.toMap(history))
  //           .toList(),
  //     );

  static List<HistoryItem> decode(String histories) =>
      (json.decode(histories) as List<dynamic>)
          .map<HistoryItem>((item) => HistoryItem.fromJson(item))
          .toList();
}
