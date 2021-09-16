import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeHelper {
  static Future<Video> getVideo(videoId) async {
    var yt = YoutubeExplode();
    Video video = await yt.videos.get(videoId);
    yt.close();
    return video;
  }

  static Future<List<Video>> getVideosFromList(list) async {
    List<Video> videos = [];
    for (var videoId in list) {
      var video = await getVideo(videoId);
      videos.add(video);
    }
    return videos;
  }

  static Future<List<Video>> getPlaylist(
      {playlistId, int limit, int offset, List<Video> data}) async {
    List<Video> videos = [];
    var yt = YoutubeExplode();

    await for (var video in yt.playlists.getVideos(playlistId).take(10)) {
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

  static Future<List<Video>> getVideoSuggestions(String videoTitle) async {
    var yt = YoutubeExplode();
    String query;
    //TODO:: remove video same as current

    List<String> words = videoTitle.split(' ');
    words.shuffle();
    query = words.take(3).join(' ');
    print(query);

    List<Video> video = await yt.search.getVideos(query);

    return video;
  }
}
