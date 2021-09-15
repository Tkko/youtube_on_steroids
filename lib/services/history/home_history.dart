import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/pages/home/home_page.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';

class HomeHistory extends BaseHistory {
  @override
  String key = HomePage().url;

  @override
  Future create(String data) async{
    List<String> homeHistory = show();
    homeHistory.add(data);
    await SharedPreferenceFacade.setStringList(homeHistory);
  }

  @override
  List<String> show() {
    return SharedPreferenceFacade.getStringList() ?? [];
  }

}