import 'package:flutter/rendering.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/app_bars/custom_video_page_app_bar.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';
import 'package:youtube_on_steroids/widgets/video_frames/concrete_video_frame.dart';

class VideoPage extends StatefulWidget {
  const VideoPage();
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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
    final YoutubePlaylist ytModel = ModalRoute.of(context).settings.arguments;
    //button builder for Likes, Dislikes and so on;
    Widget _buildButton(IconData icon, String text) {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Icon(
              icon,
              color: Colors.grey[700],
            ),
          ),
          Text(
            text,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ],
      );
    }

    //builds 3 blocks, video info block, button block, channel block;
    //can be separated;
    Widget _buildInfoBlock() {
      return Column(
        children: <Widget>[
          // video Info;
          ListTile(
            title: Text(
              ytModel.title,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              ytModel.view + '  views • ${Helper.convertToTimeAgo(DateTime.now())}',
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
                _buildButton(Icons.thumb_up_outlined, '10K'),
                //Dislikes
                _buildButton(Icons.thumb_down_outlined, '0'),
                _buildButton(Icons.share_outlined, "Share"),
                _buildButton(Icons.cloud_download_outlined, "Download"),
                _buildButton(Icons.playlist_add_outlined, "Save"),
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
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12))),
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

    Widget _buildSuggestions() {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return BasicVideoCard(
                ytModel: ytModel,
              );
            }),
      );
    }

    return Scaffold(
      appBar: CustomVideoPageAppBar(),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ConcreteVideoFrame(ytModel),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildInfoBlock(),
                  _buildSuggestions(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
