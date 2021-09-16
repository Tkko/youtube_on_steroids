part of 'history_cubit.dart';

abstract class HistoryState {
  const HistoryState();
}

class HistoryInital extends HistoryState {
  const HistoryInital();
}

class HistoryLoading extends HistoryState {
  const HistoryLoading();
}

class HistoryLoaded extends HistoryState {
  final List<HistoryItem> videos;
  const HistoryLoaded(this.videos);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    print('$o');
    print('videos in history loaded : $videos');
    return o is HistoryLoaded && o.videos == videos;
  }

  @override
  int get hashCode => videos.hashCode;
}

class HistoryConverted extends HistoryState {
  final List<Video> videos;
  const HistoryConverted(this.videos);
}

class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HistoryError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
