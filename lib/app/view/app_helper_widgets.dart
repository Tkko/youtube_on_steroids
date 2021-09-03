import 'dart:io';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/core/http_request_handler/http_request_handler.dart';

class InitScreenUtils extends StatelessWidget {
  final Widget child;

  InitScreenUtils({@required this.child});

  void setOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    this.setOrientation();
    this.setStatusBarColor();
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth != 0) {
          ScreenUtil.init(
            constraints,
            orientation: Orientation.portrait,
            designSize: Size(375, 812),
            // allowFontScaling: true,
          );
        }
        return child;
      },
    );
  }
}

class NetworkOverlay extends StatelessWidget {
  final Widget child;
  final ThemeData theme;

  NetworkOverlay({this.child, this.theme});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          child,
          StreamBuilder<ApiResponse>(
            stream: apiClient.responseStream,
            builder: (_, snap) {
              if (snap.data is ApiFailureResponse &&
                  snap.data.exception is SocketException)
                return Theme(data: theme, child: NetworkErrorSnackBar());
              return SizedBox();
            },
          )
        ],
      ),
    );
  }
}

class NetworkErrorSnackBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.primaryColorDark.withOpacity(.25),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.bottomCenter,
          height: 1000.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: 345.w,
                  height: 80.w,
                  margin:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 24.w),
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 14.w),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: theme.primaryColorLight.withOpacity(.2),
                          spreadRadius: 5,
                          blurRadius: 15,
                          offset: Offset(6, 3), // changes position of shadow
                        ),
                      ],
                      color: theme.primaryColorDark,
                      borderRadius: BorderRadius.circular(18.w)),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline_rounded, size: 30),
                      SizedBox(width: 14.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Internet connection',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText1.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor.withOpacity(0.6)),
                          ),
                          SizedBox(height: 4.w),
                          Text(
                            'Reconnecting',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyText1.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
