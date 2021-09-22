import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  void getHistory(String key) async {
    try {
      emit(HistoryLoading());
      final historyList = SharedPreferenceFacade.getStringList(key);
      emit(HistoryLoaded(historyList));
    } on Exception {
      emit(HistoryError('failed loading history'));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
