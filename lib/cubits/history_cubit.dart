import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());
}
