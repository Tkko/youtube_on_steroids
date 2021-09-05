import 'package:flutter/src/widgets/framework.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/appbars/base_appbar.dart';

class Classic implements BaseAppbar {
  @override
  Widget display() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Image.asset('assets/images/logov2.png'),
          );
        },
      ),
      leadingWidth: 130,
      actions: [
        Icon(Icons.search, size: 30),
        Container(
          padding: EdgeInsets.all(13.0),
          margin: const EdgeInsets.only(left: 10.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 30,
              maxHeight: 30,
              minWidth: 30,
              maxWidth: 30,
            ),
            child: ClipRRect(
              child: Image.asset('assets/images/user.png'),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        child: Container(
          color: Colors.black.withOpacity(0.2),
          height: 2.0,
        ),
        preferredSize: Size.fromHeight(2.0),
      ),
    );
  }

}