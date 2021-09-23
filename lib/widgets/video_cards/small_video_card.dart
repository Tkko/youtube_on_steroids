import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_frames/basic_video_frame.dart';

class SmallVideoCard extends StatelessWidget {
  final YoutubePlaylist ytModel;

  const SmallVideoCard({@required this.ytModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: BasicVideoFrame(ytModel),
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ListTile(
                title: RichText(
                  maxLines: 3,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    text: ytModel.title,
                  ),
                ),
                subtitle: RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    text:
                        '${ytModel.author}\n${Helper.generateRandomNum(110, 5000)} views',
                  ),
                ),
                trailing: InkWell(
                  onTap: () {
                    print('action!');
                  },
                  child: Icon(Icons.more_vert),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
