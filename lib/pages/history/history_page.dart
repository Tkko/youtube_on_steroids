import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/providers/history_provider.dart';
import 'package:youtube_on_steroids/utils/playlist_preference.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Classic().display(context),
      body: FutureBuilder(
        future: retrieveHistory(),
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
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return SmallVideoCard(playlist: YoutubePlaylist.fromMap(jsonDecode(snapshot.data[index])));
                },
              );
            }
          }
        },
      ),
    );
  }

  Future retrieveHistory() async {
    await PlaylistPreference.init();

    PlaylistPreference.setPlaylistKey('history');

    return PlaylistPreference.getPlaylist() ?? [];
  }
}
