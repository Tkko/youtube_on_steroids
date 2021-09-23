import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/utils/helper.dart';

class VideoDuration extends StatelessWidget {
  final VideoPlayerController _videoController;
  const VideoDuration(this._videoController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Text('${Helper.durationDisplay(_videoController.value.position)} /',
              style: TextStyle(color: Colors.white)),
          Text('${Helper.durationDisplay(_videoController.value.duration)}',
              style: TextStyle(color: Colors.grey[200])),
        ],
      ),
    );
  }
}
