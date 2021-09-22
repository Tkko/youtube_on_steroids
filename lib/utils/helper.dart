import 'dart:math';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String durationDisplay(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration == null) {
      return 'Error';
    }
    if (duration.inHours == 0) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static String compactNumber(int num) {
    return NumberFormat.compact().format(num);
  }

  static String convertToTimeAgo(DateTime date) {
    if (date == null) {
      return 'A long time ago';
    }
    return timeago.format(date);
  }

  static String generateRandomNum(int min, int max){
    return compactNumber(min + Random().nextInt(max-min));
  }
}
