import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/youtube/iyoutube.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';

class YoutubeDataHandler implements IYoutube {
  final YoutubeExplodeFacade ytFacade = YoutubeExplodeFacade();
  final List<YoutubePlaylist> playlistModel = [];
  final List<String> playlistString = [];
  final String url;

  YoutubeDataHandler({
    @required this.url
  });

  Future handler() async {
    final playlist = await ytFacade.fetchPlayList(url, 15, 0);

    await playlist.forEach((e) {
      final YoutubePlaylist current = YoutubePlaylist(
        videoId: e.id.toString(),
        title: e.title,
        author: e.author,
        coverImage: e.thumbnails.highResUrl,
        view: '2100',
        isLive: e.isLive,
      );
      playlistModel.add(current);
      playlistString.add(jsonEncode(current.toJson()));
    });

    createCache(url);

    return playlistModel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handler(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('Loading...'),
          );
        }else {
          if(snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }else{
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return BasicVideoCard(ytModel: snapshot.data[index],);
              },
            );
          }
        }
      }
    );
  }

  /// Here is logic of save on disk
  void createCache(String url) async{
    await SharedPreferenceFacade.setStringList(url, playlistString);
  }

}