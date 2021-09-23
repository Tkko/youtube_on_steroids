import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_page/video_buttons.dart';

class VideoInfo extends StatelessWidget {
  final YoutubePlaylist ytModel;
  const VideoInfo({this.ytModel});

  void showDescriptionModal(context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 500,
          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  width: 50,
                  child: Divider(
                    height: 15,
                    thickness: 5,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 24),
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700]),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                        ),
                        iconSize: 24,
                      ),
                    )
                  ],
                ),
                Divider(
                  thickness: 2,
                ),
              ]),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Description goes here'),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // video Info;
        ListTile(
          title: Text(
            ytModel.title,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            ytModel.view +
                '  views • ${Helper.convertToTimeAgo(DateTime.now())}',
            style: TextStyle(color: Colors.grey[600], fontSize: 12),
          ),
          trailing: IconButton(
            onPressed: () {
              showDescriptionModal(context);
            },
            padding: EdgeInsets.zero,
            icon: Icon(Icons.keyboard_arrow_down_sharp),
            color: Colors.black,
            iconSize: 24,
          ),
        ),
        //buttons
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //Likes
              VideoButtons(Icons.thumb_up_outlined, '10K'),
              //Dislikes
              VideoButtons(Icons.thumb_down_outlined, '0'),
              VideoButtons(Icons.share_outlined, "Share"),
              VideoButtons(Icons.cloud_download_outlined, "Download"),
              VideoButtons(Icons.playlist_add_outlined, "Save"),
            ],
          ),
        ),
        //channel
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
              bottom: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/userv2.jpg'),
                    ),
                    title: Text(
                      'Channel Title',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text("10M subscribers",
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 12))),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "SUBSCRIBE",
                    style: TextStyle(color: Colors.red),
                  ))
            ],
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
          child: Text(
            'Up Next',
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
