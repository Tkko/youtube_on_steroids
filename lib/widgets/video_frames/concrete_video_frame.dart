import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/pages/video/video_fullscreen_page.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_controls_overlay.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_setting.dart';

class ConcreteVideoFrame extends StatefulWidget {
  final YoutubePlaylist ytModel;
  const ConcreteVideoFrame(this.ytModel);
  @override
  _ConcreteVideoFrameState createState() => _ConcreteVideoFrameState();
}

class _ConcreteVideoFrameState extends State<ConcreteVideoFrame> {
  VideoPlayerController _videoController;
  bool darkFrame = false;

  @override
  void initState() {
    super.initState();
    getStreamUrl(widget.ytModel.videoId);
  }

  void getStreamUrl(String id) async {
    String videoUrl = await YoutubeExplodeFacade().fetchStreamUrl(id);
    _videoController = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    if (_videoController != null) {
      _videoController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _videoController != null
        ? GestureDetector(
            onTap: () => setState(() {
              darkFrame = !darkFrame;
            }),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  child: _videoController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController))
                      : Text('Video loading...'),
                ),
                darkFrame
                    ? VideoOverlay(
                        videoController: _videoController,
                      )
                    : Container(),
              ],
            ),
          )
        : Container(
            height: 200.h,
            width: double.infinity,
            color: Colors.black,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
  }
}
