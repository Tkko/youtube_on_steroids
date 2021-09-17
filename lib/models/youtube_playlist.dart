import 'package:youtube_on_steroids/app/app.dart';

class YoutubePlaylist {
  final String videoId;
  final String title;
  final String duration;
  final String author;
  final String coverImage;
  final String view;

  const YoutubePlaylist({
    @required this.videoId,
    @required this.title,
    @required this.duration,
    @required this.author,
    @required this.coverImage,
    @required this.view,
  });

  Map<String, dynamic> toMap() {
    return {
      'videoId': this.videoId,
      'title': this.title,
      'duration': this.duration,
      'author': this.author,
      'coverImage': this.coverImage,
      'view': this.view,
    };
  }

  factory YoutubePlaylist.fromMap(Map<String, dynamic> map) {
    return YoutubePlaylist(
      videoId: map['videoId'] as String,
      title: map['title'] as String,
      duration: map['duration'] as String,
      author: map['author'] as String,
      coverImage: map['coverImage'] as String,
      view: map['view'] as String,
    );
  }
}