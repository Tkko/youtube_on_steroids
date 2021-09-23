import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';

class VideoSuggestions extends StatelessWidget {
  final YoutubePlaylist ytModel;
  const VideoSuggestions({this.ytModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          //List of suggested videos
          ...[
            BasicVideoCard(
              ytModel: ytModel,
            ),
            BasicVideoCard(
              ytModel: ytModel,
            ),
          ]
        ],
      ),
    );
  }
}
