import 'package:youtube_on_steroids/services/cache/cache_service.dart';

class VideoViewCache extends CacheService {
  @override
  final String key = 'history';

  @override
  Future create(String data) async{
    List<String> videoHistory = show();

    if(videoHistory.contains(data)) {
      videoHistory.removeWhere((element) => element == data);
    }
    videoHistory.insert(0, data);
    await setStringList(videoHistory);
  }

  @override
  List<String> show() {
    return getStringList() ?? [];
  }
}