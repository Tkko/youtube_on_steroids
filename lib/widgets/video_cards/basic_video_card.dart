import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/widgets/video_frames/basic_video_frame.dart';

class BasicVideoCard extends StatelessWidget {
  final YoutubePlaylist ytModel;

  BasicVideoCard({
    @required this.ytModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 303.h,
      child: Column(
        children: [
          Container(
            // video frame
            height: 200.h,
            child: BasicVideoFrame(ytModel),
          ),
          Container(
            // video description
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: 92.h,
            ),
            child: ListTile(
              leading: InkWell(
                onTap: () {
                  print('clicked');
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 50,
                    maxHeight: 50,
                    minWidth: 50,
                    maxWidth: 50,
                  ),
                  child: ClipRRect(
                    child: Image.asset('assets/images/userv2.jpg'),
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                ),
              ),
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
              subtitle: Text(
                '${ytModel.author}' + " • " + ytModel.view,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              trailing: Transform.translate(
                offset: Offset(15, -10),
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
