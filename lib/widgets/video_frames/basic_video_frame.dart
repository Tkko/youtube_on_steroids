import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';

class BasicVideoFrame extends StatelessWidget {
  final YoutubePlaylist ytModel;
  const BasicVideoFrame(this.ytModel);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.VIDEO, arguments: ytModel);
          },
          child: Container(
            width: double.infinity,
            child: Image.network(ytModel.coverImage,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.black.withOpacity(0.8),
            ),
            margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
            padding: const EdgeInsets.all(2),
            child: Text(ytModel.duration,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
