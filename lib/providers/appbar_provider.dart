import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';
import 'package:youtube_on_steroids/widgets/appbars/i_appbar.dart';
import 'package:youtube_on_steroids/widgets/appbars/searchable.dart';

class AppbarProvider with ChangeNotifier {
  IAppbar appbar = Classic();

  void switchAppbar(IAppbar appbar) { //TODO:: appbar must be changing after click on SearchButton | Note: Re-build only 'appbar' not whole 'Scaffold'
    this.appbar = appbar;

    notifyListeners();
  }
}