import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeController {
  static Future<Video> getVideo(videoId) async {
    var yt = YoutubeExplode();
    Video video = await yt.videos.get(videoId);
    yt.close();
    return video;
  }

  static Future<List<Video>> getPlaylist(playlistId) async {
    List<Video> videos = [];
    var yt = YoutubeExplode();

    await for (var video in yt.playlists.getVideos(playlistId).take(20)) {
      videos.add(video);
    }

    return videos;
  }

  static Future<List<String>> getSearchSuggestions(String q) async {
    List<String> result;
    if (q.isNotEmpty) {
      print(q);
      var yt = new YoutubeHttpClient();
      result = await SearchClient(yt).getQuerySuggestions(q);
      print(result);
      yt.close();
    }
    return result;
  }

  static Future<List<Video>> getSearchResults(String keyword) async {
    var yt = new YoutubeHttpClient();
    List<Video> results;
    if (keyword.isNotEmpty) {
      results = await SearchClient(yt).getVideos(keyword);
    }
    yt.close();
    return results;
  }

  static Future<Channel> getChannelInfo(VideoId videoId) async {
    var yt = YoutubeExplode();
    var channel = await yt.channels.getByVideo(videoId);
    return channel;
  }

  static Future<List<Video>> getVideoSuggestions(
      List<String> keywords, String videoTitle) async {
    var yt = YoutubeExplode();
    String query;

    if (keywords.isNotEmpty) {
      keywords.shuffle();
      query = keywords.first;
    } else {
      query = videoTitle.substring(0, 5);
    }

    List<Video> video = await yt.search.getVideos(query);

    return video;
  }
}
