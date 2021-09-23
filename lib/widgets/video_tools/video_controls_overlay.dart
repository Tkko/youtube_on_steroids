import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/pages/video/video_fullscreen_page.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_duration.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_seekbar.dart';
import 'package:youtube_on_steroids/widgets/video_tools/controls/video_setting.dart';

class VideoOverlay extends StatefulWidget {
  final VideoPlayerController videoController;
  const VideoOverlay({this.videoController});

  @override
  _VideoOverlayState createState() => _VideoOverlayState();
}

class _VideoOverlayState extends State<VideoOverlay> {
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = widget.videoController;
  }

  playVideo(bool run) {
    setState(() {
      run ? _videoController.play() : _videoController.pause();
    });
  }

  enterFullscreen() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return VideoFullscreenPage(_videoController);
    }));
  }

  double calculateVideoPlayerHeight() {
    double deviceWidth = MediaQuery.of(context).size.width;

    return (_videoController.value.size.height /
            _videoController.value.size.width) *
        deviceWidth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: calculateVideoPlayerHeight(),
      width: double.infinity,
      color: Colors.black.withOpacity(0.3),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              VideoSetting(),
              VideoPlayPause(playVideo, _videoController.value.isPlaying),
              Container(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    VideoDuration(_videoController),
                    Expanded(child: Seekbar(_videoController)),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.fullscreen),
                      color: Colors.white,
                      onPressed: () {
                        enterFullscreen();
                      },
                    ),
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
                      _videoController.seekTo(_videoController.value.position -
                          Duration(seconds: 10));
                    });
                  },
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    setState(() {
                      _videoController.seekTo(_videoController.value.position +
                          Duration(seconds: 10));
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
