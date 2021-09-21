part of 'history_cubit.dart';

@immutable
abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<String> videos;
  HistoryLoaded(this.videos);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is HistoryLoaded && o.videos == videos;
  }

  @override
  int get hashCode => videos.hashCode;
}

class HistoryConverted extends HistoryState {
  final List<String> videos;
  HistoryConverted(this.videos);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HistoryError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
