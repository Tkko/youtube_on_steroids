import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/app_page_routes.dart';

extension StateExt on State {
  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => this.theme.textTheme;
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => this.theme.textTheme;

  EdgeInsetsGeometry get devicePadding =>
      MediaQueryData.fromWindow(window).padding;

  double get bottomPadding => MediaQueryData.fromWindow(window).padding.bottom;

  double get topPadding => MediaQueryData.fromWindow(window).padding.top;

  bool get deviceNeedTopPadding =>
      kIsWeb || Platform.isAndroid ? true : this.topPadding < 35;

  double get relativeTopPadding =>
      this.topPadding + (deviceNeedTopPadding ? 12.w : 0);

  bool get deviceNeedBottomPadding =>
      kIsWeb || Platform.isAndroid ? true : this.bottomPadding < 20;

  double get relativeBottomPadding =>
      this.bottomPadding + (deviceNeedBottomPadding ? 8.w : 0);

  NavigatorState get nav => Navigator.of(this);

  bool get canPop => Navigator.canPop(this);

  Future push(Widget page, {String name}) {
    return nav.push(CupertinoAppRoute(
      builder: (_) => page,
      settings: RouteSettings(name: '${name ?? page}'),
    ));
  }

  /// See [pushTransparentRoute] Docs
  Future pushReplacement(Widget page, {String name}) =>
      nav.pushReplacement(CupertinoAppRoute(
        builder: (_) => page,
        settings: RouteSettings(name: '${name ?? page}'),
      ));

  Future popAndPushNamed(String page) => nav.popAndPushNamed(page);

  Future pushNamed(String routeName, {Object arguments}) =>
      nav.pushNamed(routeName, arguments: arguments);

  Future pushReplacementNamed(String routeName, {Object arguments}) =>
      nav.pushReplacementNamed(routeName, arguments: arguments);
}
