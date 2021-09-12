import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/pages/video/video_page.dart';
import 'package:youtube_on_steroids/providers/history_provider.dart';
import 'package:youtube_on_steroids/utils/playlist_preference.dart';

class Classic extends StatelessWidget {
  final YoutubePlaylist ytModel;

  const Classic({
    @required this.ytModel,
  });

  @override
  Widget build(BuildContext context) {
    // final historyModel = Provider.of<HistoryProvider>(context, listen: false);
    return Stack(
          children: [
            GestureDetector(
                      onTap: () async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(ytModel: ytModel)));
                        await addHistory();
                      },
                      child: Container(
                        width: double.infinity,
                        child:  Image.network(ytModel.coverImage, fit: BoxFit.cover, width: double.infinity, height: double.infinity, alignment: Alignment.center),
                      ),
                    ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  color: Colors.black.withOpacity(0.8),
                ),
                margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
                padding: const EdgeInsets.all(2),
                child: Text(ytModel.durationTime(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
    );
  }

  Future addHistory() async{
    PlaylistPreference.setPlaylistKey('history');
    await PlaylistPreference.init();
    List<String> historyPlaylists = PlaylistPreference.getPlaylist() ?? [];

    String ytModelToJson = jsonEncode(ytModel.toMap());
    if(historyPlaylists.contains(ytModelToJson)){
      historyPlaylists.removeWhere((element) => element == ytModelToJson);
    }

    historyPlaylists.insert(0, ytModelToJson);
    PlaylistPreference.setPlaylist(historyPlaylists);
  }

}

