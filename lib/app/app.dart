import 'package:get_it/get_it.dart';
import 'package:youtube_on_steroids/app/core/api_client/api_client.dart';
export 'package:bloc/bloc.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/material.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:provider/provider.dart';
export 'package:youtube_on_steroids/app/styles/app_themes.dart';
export 'package:youtube_on_steroids/app/view/app_helper_widgets.dart';
export 'package:youtube_on_steroids/app/extensions.dart';

GetIt locator = GetIt.instance;

ApiClient get apiClient => locator<ApiClient>();

/// Print for debugging
void dd(d) {
  if (true) print(d);
}
