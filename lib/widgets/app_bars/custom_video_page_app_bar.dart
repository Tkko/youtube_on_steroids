import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/utils/search.dart';

class CustomVideoPageAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomVideoPageAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: Colors.black87,
      leadingWidth: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).popAndPushNamed(AppRoutes.WRAPPER);
        },
        child: Container(
          width: 150,
          child: Image.asset(
            'assets/images/logo-inverted.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(
              Icons.search,
              size: 24,
              color: Colors.white60,
            )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            maxRadius: 15,
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
