import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/cubits/history_cubit.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/cache/cache_service.dart';
import 'package:youtube_on_steroids/services/cache/video_view_cache.dart';
import 'package:youtube_on_steroids/widgets/history_text_button.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage();

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final CacheService cache = new VideoViewCache();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getHistory(context);
  }

  void getHistory(BuildContext context) {
    final cubit = BlocProvider.of<HistoryCubit>(context);
    cubit.getHistory('watch_history');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              HistoryTextButton(
                  text: 'CLEAR ALL WATCH HISTORY',
                  function: () {
                    print('clear history');
                  }),
              HistoryTextButton(
                  text: 'CLEAR ALL SEARCH HISTORY',
                  function: () {
                    print('clear search history');
                  }),
              HistoryTextButton(
                  text: 'CLEAR LOCAL DATA',
                  function: () {
                    SharedPreferenceFacade.clear();
                  }),
            ],
          ),
          BlocConsumer<HistoryCubit, HistoryState>(listener: (context, state) {
            if (state is HistoryError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }, builder: (context, state) {
            if (state is HistoryInitial) {
              return Container();
            }
            if (state is HistoryLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.red[700],
              ));
            }
            if (state is HistoryLoaded) {
              print(state.videos);
              return Expanded(
                child: ListView.builder(
                  itemCount: state.videos.length,
                  itemBuilder: (context, index) {
                    return SmallVideoCard(ytModel: state.videos[index]);
                  },
                ),
              );
            } else
              return Center(
                child: Text(state.toString()),
              );
          })
        ],
      ),
    );
  }
}
