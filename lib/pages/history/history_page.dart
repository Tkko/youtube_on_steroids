import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/video_view_history.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BaseHistory history = VideoViewHistory();
    List<String> data = history.show();
    return Scaffold(
      appBar: Classic().display(context),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return SmallVideoCard(playlist: YoutubePlaylist.fromMap(jsonDecode(data[index])));
        },
      ),
    );
  }
}
