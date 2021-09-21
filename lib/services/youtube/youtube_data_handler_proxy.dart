import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/youtube/iyoutube.dart';
import 'package:youtube_on_steroids/services/youtube/youtube_data_handler.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';

class YoutubeDataHandlerProxy implements IYoutube {
  IYoutube dataHandler;
  String url;
  
  YoutubeDataHandlerProxy({
    @required this.url,
  }) {
    this.dataHandler = YoutubeDataHandler(url: url);
  }

  @override
  Widget build(BuildContext context) {
    if(SharedPreferenceFacade.getStringList(url) == null){
      return this.dataHandler.build(context);
    }else{
      List<String> jsonPlaylist = SharedPreferenceFacade.getStringList(url);
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: jsonPlaylist.length,
        itemBuilder: (context, index) {
          return BasicVideoCard(
            ytModel: YoutubePlaylist.fromJson(jsonDecode(jsonPlaylist[index])),
          );
        },
      );
    }
  }
}