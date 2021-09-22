import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/widgets/video_frames/basic_video_frame.dart';

class SmallVideoCard extends StatelessWidget {
  final YoutubePlaylist ytModel;

  const SmallVideoCard({
    @required this.ytModel
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 140.h,
      child: Center(
        child: Container(
          width: double.infinity,
          height: 120.h,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 140.h,
                child: Center(
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    child: BasicVideoFrame(ytModel),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: 140.h,
                child: ListTile(
                  title: RichText(
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
                          '${ytModel.author}\n${ytModel.view} watching',
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
            ],
          ),
        ),
      ),
    );
  }
}
