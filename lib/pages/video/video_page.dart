import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/video_frames/concrete_video_frame.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({Key key}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ConcreteVideoPage()
        ],
      ),
    );
  }
}
