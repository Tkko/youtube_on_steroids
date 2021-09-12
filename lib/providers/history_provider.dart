import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';

class HistoryProvider with ChangeNotifier {
  List<YoutubePlaylist> history = [];

  void create(YoutubePlaylist playlist) {
    history.add(playlist);
    print('added successful');
    notifyListeners();
  }
}