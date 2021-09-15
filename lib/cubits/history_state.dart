part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryUploadingState extends HistoryState {}

class HistoryUploadedState extends HistoryState {
  final List<YoutubePlaylist> youtubePlaylist;
  HistoryUploadedState({this.youtubePlaylist});
}

class HistoryErrorState extends HistoryState {
  final Error error;
  HistoryErrorState({this.error});
}
