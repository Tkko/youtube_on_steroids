import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/services/youtube/youtube_data_handler_proxy.dart';

class HomePage extends StatelessWidget {
  final String url = 'PLvDdvz8B_JZuUwkzjevxMS4L0kBsv0DuN';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: YoutubeDataHandlerProxy(url: url).build(context),
          ),
        ],
      ),
    );
  }
}
