import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/core/api_client/api_client.dart';
import 'package:youtube_on_steroids/app/view/app_helper_widgets.dart';
import 'package:youtube_on_steroids/app/view/app_view.dart';
import 'package:youtube_on_steroids/cubits/app_cubit.dart';
import 'package:youtube_on_steroids/facades/shared_preference_facade.dart';

void main() async {
  Future<bool> registerLocalSingletons() async {
    try {
      locator.registerSingleton<ApiClient>(ApiClient());
      return true;
    } catch (e) {
      dd('registerLocalSingletons $e');
      return false;
    }
  }

  Future<bool> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await registerLocalSingletons();
    return true;
  }

  await init();
  await SharedPreferenceFacade.init();
  await SharedPreferenceFacade.clear();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final appCubit = AppCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appCubit,
      child: InitScreenUtils(child: AppView()),
    );
  }
}
