import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/cubits/app_cubit.dart';
import 'package:youtube_on_steroids/pages/error_page.dart';
import 'package:youtube_on_steroids/pages/results/results_page.dart';
import 'package:youtube_on_steroids/pages/splash_page.dart';
import 'package:youtube_on_steroids/pages/video/video_page.dart';
import 'package:youtube_on_steroids/pages/wrapper/wrapper_page.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  /// App Routes
  Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.SPLASH: (_) => SplashPage(),
    AppRoutes.ERROR: (_) => ErrorPage(),
    AppRoutes.WRAPPER: (_) => WrapperPage(),
    AppRoutes.SINGLE_VIDEO: (_) => VideoPage(),
    AppRoutes.SEARCH_RESULTS: (_) => ResultsPage(),
  };

  final appNavigatorKey = GlobalKey<NavigatorState>();

  BuildContext get appContext => appNavigatorKey.currentContext;

  final appThemes = AppThemes();

  void onAppStateChanged(_, AppState state) {
    if (state is AppStateLoaded) {
      appContext.push(const WrapperPage());
    }
    if (state is AppStateFailed) {
      appContext.push(const ErrorPage());
    }
  }

  String appPage(AppState state) {
    if (state is AppStateLoaded) return AppRoutes.WRAPPER;
    if (state is AppStateFailed) return AppRoutes.ERROR;
    return AppRoutes.SPLASH;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listener: onAppStateChanged,
      child: NetworkOverlay(
        theme: appThemes.theme,
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'YoutubeOnSteroids',
              navigatorKey: appNavigatorKey,
              // debugShowCheckedModeBanner: false,
              theme: appThemes.theme,
              routes: appRoutes,
              initialRoute: appPage(state),
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
