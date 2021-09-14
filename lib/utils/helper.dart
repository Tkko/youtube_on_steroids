import 'dart:math';

import 'package:intl/intl.dart';

/// Helper class is used for testing purpose
class Helper {
  String videoSeen(int min, int max) {
    final random = new Random();

    return NumberFormat.compact().format(min + random.nextInt(max-min));
  }
}