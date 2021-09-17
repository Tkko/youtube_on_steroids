import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final String variable = 'variable';

  HistoryCubit() : super(HistoryInitial()){
    setUp();
  }

  void setUp() {
    if(state is HistoryUploadingState) return;
    try {
      return emit(HistoryUploadedState());
    }catch(e) {
      print('Произошла ошибка!');
      emit(HistoryErrorState());
    }
  }

}
