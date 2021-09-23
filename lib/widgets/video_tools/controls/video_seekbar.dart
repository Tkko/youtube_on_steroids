import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Seekbar extends StatefulWidget {
  final VideoPlayerController videoController;
  const Seekbar(this.videoController);

  @override
  _SeekbarState createState() => _SeekbarState();
}

class _SeekbarState extends State<Seekbar> {
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.red,
        inactiveTrackColor: Colors.grey[300],
        trackHeight: 4.0,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
        thumbColor: Colors.red,
        overlayColor: Colors.red.withAlpha(5),
      ),
      child: Slider(
        value: widget.videoController.value.position.inSeconds.toDouble(),
        onChanged: (value) {
          setState(() {
            widget.videoController.seekTo(Duration(seconds: value.toInt()));
          });
        },
        min: 0.0,
        max: widget.videoController.value.duration.inSeconds.toDouble(),
      ),
    );
  }
}
