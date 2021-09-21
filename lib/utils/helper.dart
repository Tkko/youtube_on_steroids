import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Helper {
  static String durationDisplay(String stringDuration) {
    Duration duration = parseDuration(stringDuration);
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

  static Duration parseDuration(String input, {String separator = ','}) {
    final parts = input.split(separator).map((t) => t.trim()).toList();

    int days;
    int hours;
    int minutes;
    int seconds;
    int milliseconds;
    int microseconds;

    for (String part in parts) {
      final match = RegExp(r'^(\d+)(d|h|m|s|ms|us)$').matchAsPrefix(part);
      if (match == null) throw FormatException('Invalid duration format');

      int value = int.parse(match.group(1));
      String unit = match.group(2);

      switch (unit) {
        case 'd':
          if (days != null) {
            throw FormatException('Days specified multiple times');
          }
          days = value;
          break;
        case 'h':
          if (hours != null) {
            throw FormatException('Days specified multiple times');
          }
          hours = value;
          break;
        case 'm':
          if (minutes != null) {
            throw FormatException('Days specified multiple times');
          }
          minutes = value;
          break;
        case 's':
          if (seconds != null) {
            throw FormatException('Days specified multiple times');
          }
          seconds = value;
          break;
        case 'ms':
          if (milliseconds != null) {
            throw FormatException('Days specified multiple times');
          }
          milliseconds = value;
          break;
        case 'us':
          if (microseconds != null) {
            throw FormatException('Days specified multiple times');
          }
          microseconds = value;
          break;
        default:
          throw FormatException('Invalid duration unit $unit');
      }
    }

    return Duration(
        days: days ?? 0,
        hours: hours ?? 0,
        minutes: minutes ?? 0,
        seconds: seconds ?? 0,
        milliseconds: milliseconds ?? 0,
        microseconds: microseconds ?? 0);
  }
}
