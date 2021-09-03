import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_on_steroids/app/app.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppStateInitial()) {
    init();
  }

  void init() async {
    if (state is AppStateLoading) return;
    try {
      // make request here if needed,
      emit(AppStateLoaded());
    } catch (e) {
      dd('AppCubit init $e');
      emit(AppStateFailed('$e'));
    }
  }
}
