import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/tag_filter.dart';
import 'package:youtube_on_steroids/widgets/videos/classic.dart';
import 'package:youtube_on_steroids/youtube/video.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TagFilter(),
          Classic(),
        ],
      ),
    );
  }
}
