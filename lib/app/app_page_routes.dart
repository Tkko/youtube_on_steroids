import 'package:youtube_on_steroids/app/app.dart';

class TransparentRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  final WidgetBuilder builder;

  @override
  final String title;

  /// Builds the primary contents of the route.
  @override
  final bool maintainState;

  final Color backgroundColor;

  TransparentRoute({
    @required this.builder,
    @required this.backgroundColor,
    this.title,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = true,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 150);

  @override
  Color get barrierColor => backgroundColor;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;
}

class SlidingRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  final WidgetBuilder builder;

  @override
  final String title;

  /// Builds the primary contents of the route.
  @override
  final bool maintainState;

  final Color backgroundColor;

  SlidingRoute({
    @required this.builder,
    @required this.backgroundColor,
    this.title,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = true,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  @override
  Color get barrierColor => backgroundColor;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 150);
}

class CupertinoAppRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  CupertinoAppRoute({
    @required this.builder,
    this.title,
    RouteSettings settings,
    this.maintainState = true,
    bool fullscreenDialog = false,
  })  : assert(builder != null),
        assert(maintainState != null),
        assert(fullscreenDialog != null),
        super(settings: settings, fullscreenDialog: fullscreenDialog);

  final WidgetBuilder builder;

  @override
  Color get barrierColor => Colors.red.withOpacity(0);

  @override
  final String title;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  final bool maintainState;

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  bool canTransitionFrom(TransitionRoute<dynamic> previousRoute) => true;

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  Duration get reverseTransitionDuration => Duration(milliseconds: 150);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.base,
      child: Builder(builder: builder),
    );
  }
}
