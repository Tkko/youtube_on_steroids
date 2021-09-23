import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_duration.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_seekbar.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_setting.dart';

import 'controls/video_play_pause.dart';

class FullscreenControlsOverlay extends StatefulWidget {
  final VideoPlayerController videoController;
  const FullscreenControlsOverlay({this.videoController});

  @override
  _FullscreenControlsOverlayState createState() =>
      _FullscreenControlsOverlayState();
}

class _FullscreenControlsOverlayState extends State<FullscreenControlsOverlay> {
  playVideo(bool run) {
    setState(() {
      run ? widget.videoController.play() : widget.videoController.pause();
    });
  }

  exitFullscreen() {
    //reset to defaults then pop
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Stack(children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VideoSetting(),
            VideoPlayPause(playVideo, widget.videoController.value.isPlaying),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: VideoDuration(widget.videoController),
                    ),
                    IconButton(
                      alignment: Alignment.centerRight,
                      icon: Icon(Icons.fullscreen_exit),
                      color: Colors.white,
                      onPressed: () {
                        exitFullscreen();
                      },
                    ),
                  ],
                ),
                Seekbar(widget.videoController),
              ],
            ),
          ],
        ),
        // Row(
        //   children: [
        //     Expanded(
        //       child: GestureDetector(
        //         onDoubleTap: () {
        //           setState(() {
        //             widget.videoController.seekTo(
        //                 widget.videoController.value.position -
        //                     Duration(seconds: 10));
        //           });
        //         },
        //       ),
        //     ),
        //     Expanded(
        //       child: GestureDetector(
        //         onDoubleTap: () {},
        //       ),
        //     ),
        //     Expanded(
        //       child: GestureDetector(
        //         onDoubleTap: () {
        //           setState(() {
        //             widget.videoController.seekTo(
        //                 widget.videoController.value.position +
        //                     Duration(seconds: 10));
        //           });
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ]),
    );
  }
}
