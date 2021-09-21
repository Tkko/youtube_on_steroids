import 'package:youtube_on_steroids/app/app.dart';

class YoutubePlaylist {
  final String videoId;
  final String title;
  final String author;
  final String coverImage;
  final String view;
  final String duration;
  final bool isLive;

  YoutubePlaylist({
    @required this.videoId,
    @required this.title,
    @required this.author,
    @required this.coverImage,
    @required this.view,
    @required this.isLive,
    @required this.duration,
  });

  Map<String, dynamic> toJson() {
    return {
      "videoId": this.videoId,
      "title": this.title,
      "author": this.author,
      "coverImage": this.coverImage,
      "view": this.view,
      "isLive": this.isLive,
      "duration": this.duration,
    };
  }

  factory YoutubePlaylist.fromJson(Map<String, dynamic> json) {
    return YoutubePlaylist(
      videoId: json["videoId"],
      title: json["title"],
      author: json["author"],
      coverImage: json["coverImage"],
      view: json["view"],
      isLive: json["isLive"] == 'true',
      duration: json['duration']
    );
  }

}