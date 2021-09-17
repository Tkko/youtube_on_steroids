import 'dart:math';

import 'package:intl/intl.dart';

/// Helper class is used for testing purpose
class Helper {
  String videoSeen(int min, int max) {
    final random = new Random();

    return NumberFormat.compact().format(min + random.nextInt(max-min));
  }

  String durationToTime(String duration) {
    String time = "";
    int i = 0;

    while(duration[i] != '.'){
      if(duration[0] == '0'){
        if(i < 3 && (duration[i] == '0' || duration[i] == ':')){
          i++;
          continue;
        }

      }
      time += duration[i];
      i++;
    }

    return time;
  }

  double durationToDouble(String duration) {
    String time = durationToTime(duration);
    String num = '';
    for(int i=0; i<time.length; i++) {
      if(time[i] == ':') {
        num += '.';
      }else{
        num += time[i];
      }
    }
    return double.parse(num); //TODO BUG Will be when time is like 1:MM:HH
  }
}