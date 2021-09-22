import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';

abstract class CacheService {
  String key;

  Future setStringList(data) async{
    await SharedPreferenceFacade.setStringList(key, data);
  }

  List<String> getStringList() {
    return SharedPreferenceFacade.getStringList(key);
  }

  Future create(String data);
  List<String> show();
}