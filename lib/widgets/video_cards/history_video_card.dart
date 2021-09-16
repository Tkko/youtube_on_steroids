import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/models/history_item.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';

class HistoryVideoCard extends StatelessWidget {
  final HistoryItem item;
  HistoryVideoCard({
    this.item,
  });
  final video = {
    'isLive': false,
  };

  // String _durationDisplay(Duration duration) {
  //   String twoDigits(int n) => n.toString().padLeft(2, "0");
  //   // if (video.isLive) {
  //   // return 'LIVE';
  //   // }
  //   if (duration.inHours == 0) {
  //     String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //     String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //     return "$twoDigitMinutes:$twoDigitSeconds";
  //   }
  //   String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  //   String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  //   return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  // }

  @override
  Widget build(BuildContext context) {
    print(item.thumbnailUrl);
    return InkWell(
        onTap: () {
          // WatchHistory().saveHistory(video);
          Navigator.of(context).pushNamed(AppRoutes.SINGLE_VIDEO,
              arguments: VideoId.fromString(item.videoId));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 160,
                    child: AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: Image.network(
                        item.thumbnailUrl,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      height: 16,
                      color: item.isLive ? Colors.red : Colors.black87,
                      padding: EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 4,
                      ),
                      margin: EdgeInsets.all(5),
                      child: FittedBox(
                        child: Text(
                          item.duration,
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${item.title}',
                        // 'hielo',
                        maxLines: 3,
                        // softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text('${item.channelName}',
                          // 'hola',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12)),
                      Text('${NumberFormat.compact().format(item.views)} views',
                          textAlign: TextAlign.start,
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 12))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
