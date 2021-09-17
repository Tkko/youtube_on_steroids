import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/providers/history_provider.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Classic().display(context),
      body: Consumer<HistoryProvider>(
        builder: (context, provider, child){
          return ListView.builder(
            itemCount: provider.history.length,
            itemBuilder: (context, index) {
              return SmallVideoCard(ytModel: YoutubePlaylist.fromMap(jsonDecode(provider.history[index])));
            },
          );
        },
      ),
    );
  }
}
