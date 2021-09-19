import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';

import '../../widgets/video_cards/home_video_card.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController controller;
  List<Video> _data;
  String _playlistId = 'PLFs4vir_WsTyY31efyHdmtp9l7DpR0Wvi';
  int _limit = 20;
  int _offset = 0;

  void initState() {
    super.initState();
    getData();
  }

  Future<List<Video>> getData() async {
    //TODO
    _data = await YoutubeHelper.getPlaylist(
        playlistId: _playlistId, limit: _limit, offset: _offset);

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Video>>(
            //TODO: try qubits
            future: getData(),
            builder: (context, snapshot) {
              // Data is loading here
              if (!snapshot.hasData) {
                return CircularProgressIndicator(
                  color: Colors.red[700],
                );
              }
              // Data is loaded
              final data = snapshot.data;
              if (!snapshot.hasData) {
                return Text('No data');
              } else {
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          WatchHistory().saveHistory(data[index]);
                          Navigator.of(context).pushNamed(
                              AppRoutes.SINGLE_VIDEO,
                              arguments: data[index].id);
                        },
                        child: VideoItem(video: data[index]));
                  },
                );
              }
            }),
      ),
    );
  }
}
