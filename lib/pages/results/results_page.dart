import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/widgets/app_bar/custom_app_bar.dart';
import 'package:youtube_on_steroids/widgets/video_cards/video_item.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key key}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    String query = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomAppBar(
                hasFilters: false,
                isPinned: false,
                isFloating: true,
                isSnapped: true,
              ),
            ];
          },
          body: FutureBuilder<List<Video>>(
              future: YoutubeHelper.getSearchResults(query),
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
                        video: data[index],
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
