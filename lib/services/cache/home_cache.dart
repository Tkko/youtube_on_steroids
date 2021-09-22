import 'package:youtube_on_steroids/pages/home/home_page.dart';
import 'package:youtube_on_steroids/services/cache/cache_service.dart';

class HomeHistory extends CacheService {
  @override
  String key = HomePage().url;

  @override
  Future create(String data) async{
    List<String> homeHistory = show();
    homeHistory.add(data);
    await setStringList(homeHistory);
  }

  @override
  List<String> show() {
    return getStringList() ?? [];
  }
}