import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/video_view_history.dart';

class HistoryProvider with ChangeNotifier {
  BaseHistory videoView = VideoViewHistory();
  List<String> history = VideoViewHistory().show();


  void getHistory() {
    history = videoView.show();
    notifyListeners();
  }
}