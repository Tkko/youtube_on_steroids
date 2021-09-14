import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/pages/video/video_page.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/video_view_history.dart';

class Classic extends StatelessWidget {
  final YoutubePlaylist ytModel;

  const Classic({
    @required this.ytModel,
  });

  @override
  Widget build(BuildContext context) {
    BaseHistory history = VideoViewHistory();

    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPage(ytModel: ytModel)));
            history.create(jsonEncode(ytModel.toMap()));
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
}

