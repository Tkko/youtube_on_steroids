import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';

class SearchResultHistory extends BaseHistory {
  @override
  String key = 'searchResults';

  @override
  Future create(String data) async{
    List<String> searchHistory = show();

    if(searchHistory.contains(data)){
      searchHistory.removeWhere((element) => element == data);
    }
    searchHistory.insert(0, data);
    await SharedPreferenceFacade.setStringList(searchHistory);
  }

  @override
  List<String> show() {
    return SharedPreferenceFacade.getStringList() ?? [];
  }
}