import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/constants.dart';

class VideoItem extends StatelessWidget {
  final VideoId id;
  final String thumbnail;
  final String title;
  final String author;
  final int views;
  final Duration duration;
  final DateTime publishDate;
  final ChannelId channelId;
  final String videoUrl;
  final bool isLive;

  VideoItem(
      {this.id,
      this.author,
      this.channelId,
      this.duration,
      this.publishDate,
      this.thumbnail,
      this.title,
      this.videoUrl,
      this.views,
      this.isLive});

  // Future<String> get getChannelUrl async {
  //   var yt = YoutubeExplode();
  //   var response = await yt.channels.get(channelId);
  //   return response.logoUrl;
  // }
  String _durationDisplay(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (this.isLive) {
      return 'LIVE';
    }
    if (duration.inHours == 0) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.SINGLE_VIDEO, arguments: id);
      },
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Image.network(
                thumbnail,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  width: 34,
                  color: this.isLive ? Colors.red : Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 5,
                  ),
                  child: FittedBox(
                    child: Text(
                      _durationDisplay(duration),
                      // '${duration.inHours}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListTile(
              title: Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: GestureDetector(
                child: CircleAvatar(
                  foregroundImage: NetworkImage(
                      'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png'),
                ),
              ),
              subtitle: Text('$author * $views views * $publishDate  '),
            ),
          )
        ],
      ),
    );
  }
}
