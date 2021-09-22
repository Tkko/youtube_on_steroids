import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/pages/video/video_fullscreen_page.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_setting.dart';

class ConcreteVideoFrame extends StatefulWidget {
  @override
  _ConcreteVideoFrameState createState() => _ConcreteVideoFrameState();
}

class _ConcreteVideoFrameState extends State<ConcreteVideoFrame> {
  VideoPlayerController _videoController;
  bool darkFrame = false;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.network(
        'https://cdn.videvo.net/videvo_files/video/free/2013-09/large_watermarked/AbstractRotatingCubesVidevo_preview.mp4')
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

    return
        //  Container(
        //   // height: 200.h,
        //   width: double.infinity,
        //   color: Colors.black,
        //   child:
        _videoController != null
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
                            height: 200.h,
                            // padding: EdgeInsets.symmetric(vertical: ),
                            width: double.infinity,
                            // height: 200.h,
                            color: Colors.black.withOpacity(0.3),
                            child: Column(
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
                                      children: [
                                        SizedBox(width: deviceWidth * 0.03),
                                        Text('0:00 /',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            '${Helper.durationDisplay(Duration(hours: 5))}',
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
                                              value: 2.00,
                                              onChanged: (value) {
                                                setState(() {
                                                  _videoController.seekTo(
                                                      Duration(
                                                          seconds: (value * 60)
                                                              .toInt()));
                                                });
                                              },
                                              min: 0.0,
                                              max: 12.10,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            child: Hero(
                                              tag: 'HeroFullscreen',
                                              child: Icon(
                                                Icons.fullscreen,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return VideoFullscreenPage(
                                                    _videoController);
                                              })).then((val) {
                                                setState(() {});
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(color: Colors.white),
                // ),
              );
  }
}
