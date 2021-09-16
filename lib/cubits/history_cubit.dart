import 'package:bloc/bloc.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/models/history_item.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';
// import 'package:youtube_explode_dart/youtube_explode_dart.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInital());

  void getHistory() async {
    try {
      emit(HistoryLoading());
      // final prefs = await SharedPreferences.getInstance();
      // final videos = prefs.getStringList('video_history');
      final videosList = await WatchHistory.getHistory();
      print(videosList);
      // List<Video> historyVideos =
      //     await YoutubeHelper.getVideosFromList(videosList);
      emit(HistoryLoaded(videosList));
    } on Exception {
      emit(HistoryError('message'));
    }
  }

  // void init() async {
  //   try {
  //     emit(HistoryLoading());
  //     final prefs = await SharedPreferences.getInstance();
  //     videos = prefs.getStringList('video_history');
  //     emit(HistoryLoaded(videos));
  //   } on Exception {
  //     emit(HistoryError("Couldn't fetch weather. Sorry :( "));
  //   }
  // }

  // void getHistory() async {
  //   try {
  //     emit(HistoryLoading());

  //     emit(HistoryLoaded(videos));
  //   } on Exception {
  //     emit(HistoryError("Couldn't fetch weather. Sorry :( "));
  //   }
  // }

  // void addToHistory(String videoId) async {
  //   print('saving history...');
  //   final prefs = await SharedPreferences.getInstance();
  //   print('got prefs in save');
  //   List<String> historyList = prefs.getStringList('video_history') ?? [];
  //   historyList.removeWhere((element) => element == videoId);
  //   print('replaced old');

  //   if (historyList.length == 20) {
  //     historyList.removeAt(0);
  //   }
  //   historyList.add(videoId);
  //   prefs.setStringList('video_history', historyList);

  //   print('added to history');
  // }
}
