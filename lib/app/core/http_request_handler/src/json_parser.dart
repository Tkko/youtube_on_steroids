part of http_request_handler;

extension IterableExt on Iterable {
  List<T> asList<T>() => this.toList(growable: false);
}

extension MapExt on Map {
  List<T> asList<T>(String p) => this[p] is Iterable ? this[p] : [];

  Map asMap(String p) => this[p] is Map ? this[p] as Map : {};

  String s(String p) {
    try {
      final param = this[p];
      if (param == null) return null;
      if (param is String) return param;
      if (param is bool) return '';
      return param.toString();
    } catch (e) {
      print('parse String $e');
      return null;
    }
  }

  int i(String p) {
    try {
      final param = this[p];
      if (param is int) return param;
      if (param == null) return null;
      if (param is double) return param.toInt();
      if (param is String) return double.tryParse(param)?.toInt();
    } catch (e) {
      print('parse int $e');
    }
    return 0;
  }

  double d(String p) {
    try {
      final param = this[p];
      if (param is double) return param;
      if (param == null) return null;
      if (param is int) return param.toDouble();
      if (param is String) return double.parse(param);
    } catch (e) {
      print('parse double $e');
    }
    return .0;
  }

  bool b(String p) {
    try {
      final param = this[p];
      if (param is bool) return param;
      if (param is int) return param == 1;
      if (param is String) return param == '1';
    } catch (e) {
      print('parse boolean $e');
    }
    return false;
  }

  DateTime dt(String p) {
    final param = this[p];
    if (param == null) return null;
    try {
      return DateTime.parse(param);
    } catch (e) {
      print('parse DateTime $e');
      return null;
    }
  }

  to<T>(String p) {
    switch (T) {
      case int:
        return i(p);
      case double:
        return d(p);
      case bool:
        return b(p);
      case String:
        return s(p);
    }
  }
}
