import 'package:youtube_on_steroids/services/cache/cache_service.dart';

class SearchResultHistory extends CacheService {
  @override
  String key = 'search_result';

  @override
  Future create(String data) async{
    List<String> searchHistory = show();

    if(searchHistory.contains(data)){
      searchHistory.removeWhere((element) => element == data);
    }
    searchHistory.insert(0, data);
    await setStringList(searchHistory);
  }

  @override
  List<String> show() {
    return getStringList() ?? [];
  }
}