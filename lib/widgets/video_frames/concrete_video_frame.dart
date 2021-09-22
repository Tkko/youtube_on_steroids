import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/pages/video/video_fullscreen_page.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_setting.dart';

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

  playVideo(bool run) {
    setState(() {
      run ? _videoController.play() : _videoController.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

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
                    ? Container(
                        height: (_videoController.value.size.height /
                                _videoController.value.size.width) *
                            deviceWidth,
                        width: double.infinity,
                        color: Colors.black.withOpacity(0.3),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: deviceWidth,
                                  child: VideoSetting(),
                                ),
                                Container(
                                  width: deviceWidth,
                                  child: VideoPlayPause(playVideo,
                                      _videoController.value.isPlaying),
                                ),
                                Container(
                                  width: deviceWidth,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(width: deviceWidth * 0.03),
                                        Text(
                                            '${Helper.durationDisplay(_videoController.value.position)} /',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${Helper.durationDisplay(_videoController.value.duration)}',
                                            style: TextStyle(
                                                color: Colors.grey[200])),
                                        SliderTheme(
                                          data:
                                              SliderTheme.of(context).copyWith(
                                            activeTrackColor: Colors.red,
                                            inactiveTrackColor:
                                                Colors.grey[300],
                                            trackHeight: 4.0,
                                            thumbShape: RoundSliderThumbShape(
                                                enabledThumbRadius: 7.0),
                                            thumbColor: Colors.red,
                                            overlayColor:
                                                Colors.red.withAlpha(5),
                                          ),
                                          child: Container(
                                            width: deviceWidth * 0.66,
                                            child: Slider(
                                              value: _videoController
                                                  .value.position.inSeconds
                                                  .toDouble(),
                                              onChanged: (value) {
                                                setState(() {
                                                  _videoController.seekTo(
                                                      Duration(
                                                          seconds:
                                                              value.toInt()));
                                                });
                                              },
                                              min: 0.0,
                                              max: _videoController
                                                  .value.duration.inSeconds
                                                  .toDouble(),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: IconButton(
                                            icon: Icon(Icons.fullscreen),
                                            color: Colors.white,
                                            onPressed: () {
                                              darkFrame = false;
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return VideoFullscreenPage(
                                                    _videoController);
                                              }));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        _videoController.seekTo(
                                            _videoController.value.position -
                                                Duration(seconds: 10));
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: () {},
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onDoubleTap: () {
                                      setState(() {
                                        _videoController.seekTo(
                                            _videoController.value.position +
                                                Duration(seconds: 10));
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
