import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeExplodeFacade {
  final YoutubeExplode yt = new YoutubeExplode();

  Future fetchPlayList(String playlistUrl, int quantity, int skip) async {
    final playlist = await yt.playlists.get(playlistUrl);
    final playlistVideos = yt.playlists.getVideos(playlist.id).take(quantity).skip(skip);

    return playlistVideos;
  }

  Future<String> fetchStreamUrl(String videoId) async {
    final manifest = await yt.videos.streamsClient.getManifest(videoId);

    return manifest.muxed.last.url.toString();
  }

  Future fetchSearchResults(String keyword) async {
    return await yt.search.getVideos(keyword).timeout(Duration(seconds: 8));
  }

  Future<List<String>> fetchKeywordSuggestion(String keyword) async{
    return await YoutubeExplode().search.getQuerySuggestions(keyword);
  }
}