import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/cubits/history_cubit.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
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
            onPressed: () {
              setState(() {
                WatchHistory().deleteHistory();
                final cubit = BlocProvider.of<HistoryCubit>(context);
                cubit.getHistory();
              });
            },
          ),
        ),
      );
    }

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              _buildButton('CLEAR  ALL WATCH HISTORY'),
              _buildButton('MANAGE HISTORY'),
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
              print('$state');
              if (state is HistoryInital) {
                return Text('init');
              } else if (state is HistoryLoading) {
                return Center(child: Text('No Watch History Data Available'));
              } else if (state is HistoryLoaded) {
                return state.videos != []
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: state.videos.length,
                            itemBuilder: (context, index) {
                              return HistoryVideoCard(
                                  item: state.videos[index]);
                            }),
                      )
                    : Center(
                        child: Text('No History Data'),
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
