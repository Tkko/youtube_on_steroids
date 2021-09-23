import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/cache/video_view_cache.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  void getHistory(String key) async {
    try {
      emit(HistoryLoading());
      final historyList = VideoViewCache().show();
      final List<YoutubePlaylist> results = [];
      historyList.forEach((element) {
        results.add(
          YoutubePlaylist.fromJson(
            jsonDecode(element),
          ),
        );
      });
      emit(HistoryLoaded(results));
    } on Exception {
      emit(HistoryError('failed loading history'));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
