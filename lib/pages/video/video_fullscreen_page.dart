import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_on_steroids/app/app.dart';

import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_setting.dart';
import 'package:youtube_on_steroids/widgets/video_tools/fullscreen_controls_overlay.dart';

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
                        ? FullscreenControlsOverlay(
                            videoController: widget.videoController,
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
