import 'package:flutter/rendering.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/app_bars/custom_video_page_app_bar.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';
import 'package:youtube_on_steroids/widgets/video_frames/concrete_video_frame.dart';
import 'package:youtube_on_steroids/widgets/video_page/video_info.dart';
import 'package:youtube_on_steroids/widgets/video_page/video_suggestions.dart';

class VideoPage extends StatefulWidget {
  const VideoPage();
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    final YoutubePlaylist ytModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomVideoPageAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ConcreteVideoFrame(ytModel),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VideoInfo(ytModel: ytModel),
                  VideoSuggestions(ytModel: ytModel)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
