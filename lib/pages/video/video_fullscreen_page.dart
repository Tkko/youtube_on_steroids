import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_on_steroids/app/app.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/video_setting.dart';

class VideoFullscreenPage extends StatefulWidget {
  // const VideoFullscreenPage({Key key}) : super(key: key);
  final VideoPlayerController videoController;
  const VideoFullscreenPage(this.videoController);

  @override
  _VideoFullscreenPageState createState() => _VideoFullscreenPageState();
}

class _VideoFullscreenPageState extends State<VideoFullscreenPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //Turn screen to landscape
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //Enter Fullscreen (remove phone navigation, status bar)
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //return to default orientation and system ui overlay
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  playVideo(bool run) {
    setState(() {
      run ? widget.videoController.play() : widget.videoController.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    bool darkFrame = true;

    return Scaffold(
      body: Container(
        color: Colors.black,
        child: widget.videoController != null
            ? GestureDetector(
                onTap: () {
                  print('tap');
                  setState(() {
                    darkFrame = !darkFrame;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: widget.videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  widget.videoController.value.aspectRatio,
                              child: VideoPlayer(widget.videoController))
                          : Text('Video loading...'),
                    ),
                    darkFrame
                        ? Container(
                            color: Colors.black.withOpacity(0.3),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: deviceWidth,
                                  child: VideoSetting(),
                                ),
                                Container(
                                  width: deviceWidth,
                                  child: VideoPlayPause(playVideo,
                                      widget.videoController.value.isPlaying),
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
                                        Text('hi',
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
                                                  widget.videoController.seekTo(
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
                                              //reset to defaults then pop
                                              SystemChrome
                                                  .setPreferredOrientations([
                                                DeviceOrientation.portraitUp
                                              ]);
                                              SystemChrome
                                                  .setEnabledSystemUIOverlays(
                                                      SystemUiOverlay.values);
                                              Navigator.of(context).pop();
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
              ),
      ),
    );
  }
}
