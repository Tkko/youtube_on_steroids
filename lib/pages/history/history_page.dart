import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/cubits/history_cubit.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/services/history/search_history.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';
import 'package:youtube_on_steroids/widgets/video_cards/history_video_card.dart';
import 'dart:io';

class HistoryPage extends StatefulWidget {
  const HistoryPage();

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Future<List<Video>> getHistoryVideos() async {
  //   List<String> history = await HistoryController.getHistory();
  //   List<Video> historyVideos = await YoutubeHelper.getVideosFromList(history);
  //   return historyVideos;
  // }

  @override
  void didChangeDependencies() async {
    getHistory(context);
    super.didChangeDependencies();
  }

  void getHistory(BuildContext context) {
    final cubit = BlocProvider.of<HistoryCubit>(context);
    cubit.getHistory();
  }

  @override
  Widget build(BuildContext context) {
    Widget _settingsDialog(context) {
      bool searchHistorySwitch = false;
      bool watchHistorySwitch;
      bool allHistorySwitch;
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 50,
        backgroundColor: Colors.white,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              child: Text('History Settings',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ), // bottom part
            Container(
                child: Center(
                    child:
                        Text('Dialog not working as intended...'))), // top part
          ],
        ),
      );
    }

    ScaffoldFeatureController _showSnackBar({
      String text,
      Duration duration = const Duration(seconds: 3),
    }) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
          duration: duration,
          action: SnackBarAction(
            onPressed: () {},
            label: 'Dismiss',
            textColor: Colors.yellow[100],
          ),
        ),
      );
    }

    Widget _buildButton(String text, Function function) {
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
            onPressed: function,
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              _buildButton('CLEAR  ALL WATCH HISTORY', () {
                setState(() {
                  WatchHistory().deleteHistory();
                  final cubit = BlocProvider.of<HistoryCubit>(context);
                  cubit.getHistory();
                });
                _showSnackBar(
                  text: 'Watch History Cleared',
                );
              }),
              _buildButton('CLEAR ALL SEARCH HISTORY', () {
                setState(() {
                  SearchHistory.clearSearchHistory();
                });
                _showSnackBar(text: 'Search History Cleared Successfully');
              }),
              _buildButton('HISTORY SETTINGS', () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return _settingsDialog(context);
                    });
              }),
            ],
          ),
          BlocConsumer<HistoryCubit, HistoryState>(
            listener: (context, state) {
              if (state is HistoryError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is HistoryInital) {
                return Text('init');
              } else if (state is HistoryLoading) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.red[700],
                ));
              } else if (state is HistoryLoaded) {
                print(state.videos);
                return state.videos.isNotEmpty
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.videos.length,
                            itemBuilder: (context, index) {
                              return HistoryVideoCard(
                                  item: state.videos[index]);
                            }),
                      )
                    : Center(
                        child: Text('No Watch History Data Available'),
                      );
              } else if (state is HistoryConverted) {
                return Center(
                  child: Text(state.videos.first.title.toString()),
                );
              } else
                return Center(child: Text('$state'));
            },
          ),
        ],
      ),
    );
  }
}
