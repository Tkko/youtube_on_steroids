import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/widgets/video_player/seekbar.dart';

class FullscreenVideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  const FullscreenVideoPlayerWidget(this.controller);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<FullscreenVideoPlayerWidget> {
  bool _isControlVisible = true;
  // bool _isVideoLoading = false;
  @override
  void initState() {
    super.initState();
    widget.controller
      ..addListener(() {
        setState(() {});
      });
  }

  void _pause() {
    widget.controller.pause();
    if (!_isControlVisible) {
      setState(() {
        _isControlVisible = !_isControlVisible;
      });
    }
  }

  void _play() {
    widget.controller.play();
    if (!_isControlVisible) {
      setState(() {
        _isControlVisible = !_isControlVisible;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    // if (widget.controller != null) {
    //   widget.controller.dispose();
    //   print('DISPOSED========DISPOSED=====DISPOSED');
    //   // _isVideoLoading = false;
    //   _isControlVisible = false;
    //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    // }
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
    Widget _buildPlayerButtons({Function function, IconData icon}) {
      return Container(
        // margin: EdgeInsets.fromLTRB(, 0, double.infinity, 0),
        child: IconButton(
            constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
            padding: EdgeInsets.zero,
            iconSize: 40,
            onPressed: widget.controller.value != null ? function : () {},
            icon: Icon(
              icon,
              color: Colors.white,
            )),
      );
    }

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Stack(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: AspectRatio(
            aspectRatio: widget.controller.value.aspectRatio,
            child: VideoPlayer(widget.controller),
          ),
        ),
        Positioned.fill(
          child: InkWell(
            onTap: () {
              setState(() {
                _isControlVisible = !_isControlVisible;
              });
            },
            child: Container(
              color: _isControlVisible
                  ? Color.fromRGBO(0, 0, 0, 0.3)
                  : Color.fromRGBO(0, 0, 0, 0),
              child: Align(
                alignment: Alignment.center,
                child: AnimatedOpacity(
                  opacity: _isControlVisible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: PopupMenuButton<double>(
                                  icon: Icon(
                                    Icons.settings_outlined,
                                    color: Colors.white,
                                  ),
                                  initialValue:
                                      widget.controller.value.playbackSpeed,
                                  tooltip: 'Playback speed',
                                  onSelected: (speed) {
                                    widget.controller.setPlaybackSpeed(speed);
                                  },
                                  itemBuilder: (context) {
                                    return [
                                      for (final speed in [0.5, 1.0, 1.5, 2.0])
                                        PopupMenuItem(
                                          value: speed,
                                          child: Text('${speed}x'),
                                        )
                                    ];
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPlayerButtons(
                                  function: () {}, icon: Icons.skip_previous),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: IconButton(
                                    // constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),

                                    padding: EdgeInsets.zero,
                                    iconSize: 60,
                                    onPressed: widget.controller.value != null
                                        ? () {
                                            setState(() {
                                              widget.controller.value.isPlaying
                                                  ? _pause()
                                                  : _play();
                                            });
                                          }
                                        : () {},
                                    icon: Icon(
                                      widget.controller.value != null
                                          ? widget.controller.value.isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow
                                          : Icons.question_answer_rounded,
                                      color: Colors.white,
                                    )),
                              ),
                              _buildPlayerButtons(
                                  function: () {}, icon: Icons.skip_next),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                flex: 7,
                                child: SeekBar(widget.controller),
                              ),
                              Expanded(
                                flex: 1,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    splashColor: Color.fromRGBO(0, 0, 0, 0),
                                    onPressed: () {
                                      if (deviceOrientation ==
                                          Orientation.landscape) {
                                        SystemChrome.setPreferredOrientations(
                                            [DeviceOrientation.portraitUp]);
                                        SystemChrome.setEnabledSystemUIOverlays(
                                            SystemUiOverlay.values);
                                      } else {
                                        SystemChrome.setPreferredOrientations(
                                            [DeviceOrientation.landscapeLeft]);
                                        SystemChrome.setEnabledSystemUIOverlays(
                                            []);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.fullscreen_sharp,
                                      color: Colors.white,
                                      size: 24,
                                    )),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
