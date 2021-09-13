import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/services/history.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/history_item.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage();

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future<List<Video>> getHistoryVideos() async {
    List<String> history = await HistoryController.getHistory();
    List<Video> historyVideos = await YoutubeHelper.getVideosFromList(history);
    return historyVideos;
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButton(String text) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9.8, horizontal: 7.98),
          child: TextButton(
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 14, height: 1.2),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            onPressed: () {},
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: getHistoryVideos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Video> history = snapshot.data;
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _buildButton('CLEAR ALL WATCH HISTORY'),
                    _buildButton('PAUSE WATCH HISTORY'),
                    _buildButton('MANAGE ALL HISTORY'),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          HistoryItem(video: history[index]),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      )),
    );
  }
}
