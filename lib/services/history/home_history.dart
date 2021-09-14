import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';

class HomeHistory implements BaseHistory {
  @override
  String key;

  void setKey(String key) {
    this.key = key;
  }

  @override
  void create(String data) {
    List<String> homeHistory = show();
    homeHistory.add(data);
    SharedPreferenceFacade.setStringList(homeHistory);
  }

  @override
  List<String> show() {
    print(SharedPreferenceFacade.getStringList());
    return SharedPreferenceFacade.getStringList() ?? [];
  }

}