import 'package:bloc/bloc.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/models/history_item.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';
part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInital());

  void getHistory() async {
    try {
      emit(HistoryLoading());
      final videosList = await WatchHistory.getHistory();
      print(videosList);
      emit(HistoryLoaded(videosList));
    } on Exception {
      emit(HistoryError('message'));
    }
  }
}
