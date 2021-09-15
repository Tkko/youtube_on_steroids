import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';

abstract class BaseHistory {
  String key;

  BaseHistory() {
    SharedPreferenceFacade.setKey(key);
  }

  ///Abstract methods
  Future create(String data);
  List<String> show();
}