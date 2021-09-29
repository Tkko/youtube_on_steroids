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
  bool controlsOverlay = true;

  @override
  void initState() {
    super.initState();
    //Turn screen to landscape
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    //Enter Fullscreen (remove phone navigation, status bar)
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  @override
  void dispose() {
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

    return Scaffold(
      body: Container(
        color: Colors.black,
        width: double.infinity,
        child: widget.videoController != null
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    controlsOverlay
                        ? controlsOverlay = false
                        : controlsOverlay = true;
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: widget.videoController.value.isInitialized
                          ? AspectRatio(
                              aspectRatio:
                                  widget.videoController.value.aspectRatio,
                              child: VideoPlayer(widget.videoController))
                          : Text('Video loading...'),
                    ),
                    controlsOverlay
                        ? Container(
                            color: Colors.black.withOpacity(0.3),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Stack(children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                  width: deviceWidth * 0.03),
                                              Text(
                                                  '${Helper.durationDisplay(widget.videoController.value.position)} /',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              Text(
                                                  Helper.durationDisplay(widget
                                                      .videoController
                                                      .value
                                                      .duration),
                                                  style: TextStyle(
                                                      color: Colors.grey[200])),
                                              Expanded(
                                                child: IconButton(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  icon: Icon(Icons.fullscreen),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    //reset to defaults then pop
                                                    SystemChrome
                                                        .setPreferredOrientations([
                                                      DeviceOrientation
                                                          .portraitUp
                                                    ]);
                                                    SystemChrome
                                                        .setEnabledSystemUIOverlays(
                                                            SystemUiOverlay
                                                                .values);
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                  width: deviceWidth * 0.03),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: deviceWidth,
                                          child: SliderTheme(
                                            data: SliderTheme.of(context)
                                                .copyWith(
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16),
                                              child: Slider(
                                                value: widget.videoController
                                                    .value.position.inSeconds
                                                    .toDouble(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.videoController
                                                        .seekTo(Duration(
                                                            seconds:
                                                                value.toInt()));
                                                  });
                                                },
                                                min: 0.0,
                                                max: widget.videoController
                                                    .value.duration.inSeconds
                                                    .toDouble(),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
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
                                          widget.videoController.seekTo(widget
                                                  .videoController
                                                  .value
                                                  .position -
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
                                          widget.videoController.seekTo(widget
                                                  .videoController
                                                  .value
                                                  .position +
                                              Duration(seconds: 10));
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ]),
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
