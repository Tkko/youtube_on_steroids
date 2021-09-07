import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/app_bar/custom_app_bar.dart';
import 'package:youtube_on_steroids/widgets/video_item.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key key}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Future<List<Video>> getResults(query) async {
    var yt = YoutubeExplode();
    List<Video> response = await yt.search.getVideos(query);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    String query = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomAppBar(),
            ];
          },
          body: FutureBuilder<List<Video>>(
              future: getResults(query),
              builder: (context, snapshot) {
                // Data is loading here
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                // Data is loaded
                final data = snapshot.data;
                if (!snapshot.hasData) {
                  return Text('No data');
                } else {
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return VideoItem(
                        id: data[index].id,
                        channelId: data[index].channelId,
                        author: data[index].author,
                        videoUrl: data[index].url,
                        views: data[index].engagement.viewCount,
                        duration: data[index].duration,
                        publishDate: data[index].publishDate,
                        thumbnail: data[index].thumbnails.mediumResUrl,
                        title: data[index].title,
                        isLive: data[index].isLive,
                      );
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
