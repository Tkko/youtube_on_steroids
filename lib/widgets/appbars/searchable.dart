import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/appbars/i_appbar.dart';

class Searchable implements IAppbar {
  @override
  Widget display(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          print('close Search bar');
        },
      ),
      titleSpacing: 0,
      title: TextField(
        decoration: const InputDecoration(
          hintText: 'Поиск на YouTube',
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
          ),
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 3, left: 3),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Icon(Icons.search, size: 30),
        ),
      ],
    );
  }

}