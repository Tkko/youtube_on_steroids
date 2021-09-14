import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';

class YoutubeExplodeFacade {
  final YoutubeExplode yt = new YoutubeExplode();

  Future fetchPlayList(String playlistUrl, int quantity, int skip) async {
    final playlist = await yt.playlists.get(playlistUrl);
    final playlistVideos = yt.playlists.getVideos(playlist.id).take(quantity).skip(skip);
    final videoSeen = Helper();

    List<YoutubePlaylist> playlistModel = [];
    await playlistVideos.forEach((e) {
      playlistModel.add(
          YoutubePlaylist(
            videoId: e.id.toString(),
            title: e.title,
            duration: e.duration.toString(),
            author: e.author,
            coverImage: e.thumbnails.highResUrl,
            view: videoSeen.videoSeen(21000, 2400000),
          ),
      );
    });

    return playlistModel;
  }

  Future<String> getStreamUrl(String videoId) async {
    final manifest = await yt.videos.streamsClient.getManifest(videoId);

    return manifest.muxed.first.url.toString();
  }

  Future fetchSearchResults(String keyword) async {
    final keywords = await yt.search.getVideos(keyword).timeout(Duration(seconds: 5));

    return keywords;
  }
}