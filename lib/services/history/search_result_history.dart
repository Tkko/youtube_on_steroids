import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';

class SearchResultHistory extends BaseHistory {
  @override
  String key = 'searchResult';

  @override
  void create(data) {
    List<String> searchHistory = show();

    if(searchHistory.contains(data)){
      searchHistory.removeWhere((element) => element == data);
    }
    searchHistory.insert(0, data);

    SharedPreferenceFacade.setStringList(searchHistory);
  }

  @override
  List<String> show() {
    return SharedPreferenceFacade.getStringList() ?? [];
  }
}