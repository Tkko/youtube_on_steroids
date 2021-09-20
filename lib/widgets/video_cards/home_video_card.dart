import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  VideoItem({
    this.video,
  });

  // void saveToHistory() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   List<String> historyList = prefs.getStringList('video_history') ?? [];
  //   historyList.removeWhere((element) => element == video.id.toString());
  //   if (historyList.length == 20) {
  //     historyList.removeAt(0);
  //   }
  //   historyList.add(video.id.toString());
  //   prefs.setStringList('video_history', historyList);
  //   print('added to history');
  // }

  //TODO:: get logo url;
  final String logoUrl =
      'https://www.oseyo.co.uk/wp-content/uploads/2020/05/empty-profile-picture-png-2-2.png';

  String _durationDisplay(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (video.isLive) {
      return 'LIVE';
    }
    if (video.duration == null) {
      return 'Error';
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
    return
        //  InkWell(
        //   onTap: () {
        //     WatchHistory().saveHistory(video);
        //     Navigator.of(context)
        //         .pushNamed(AppRoutes.SINGLE_VIDEO, arguments: video.id);
        //   },
        // child:
        Column(
      children: <Widget>[
        Stack(
          children: [
            Image.network(
              video.thumbnails.mediumResUrl,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                height: 16,
                color: video.isLive ? Colors.red : Colors.black87,
                padding: EdgeInsets.symmetric(
                  vertical: 1,
                  horizontal: 4,
                ),
                margin: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    _durationDisplay(video.duration),
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
              '${video.title}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            leading: GestureDetector(
              child: CircleAvatar(
                foregroundImage: NetworkImage(logoUrl),
              ),
            ),
            subtitle: Text(
              '${video.author} • ${NumberFormat.compact().format(video.engagement.viewCount)}  views • ${video.publishDate}',
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ),
        )
      ],
      // ),
    );
  }
}
