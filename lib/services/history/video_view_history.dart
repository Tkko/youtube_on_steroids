import 'dart:convert';

import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';

class VideoViewHistory extends BaseHistory {
  @override
  String key = 'history';

  @override
  Future create(String data) async{
    List<String> videoHistory = show();

    if(videoHistory.contains(data)) {
      videoHistory.removeWhere((element) => element == data);
    }
    videoHistory.insert(0, data);
    await SharedPreferenceFacade.setStringList(videoHistory);
  }

  @override
  List<String> show() {
    return SharedPreferenceFacade.getStringList() ?? [];
  }
}

