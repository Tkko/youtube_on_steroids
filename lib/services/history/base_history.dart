import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';

abstract class BaseHistory {
  String key;

  Future setStringList(data) async{
    await SharedPreferenceFacade.setStringList(key, data);
  }

  List<String> getStringList() {
    return SharedPreferenceFacade.getStringList(key);
  }

  ///Abstract methods
  Future create(String data);
  List<String> show();
}