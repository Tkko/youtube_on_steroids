import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/widgets/app_bars/custom_app_bar_filters.dart';

class CustomAppBar extends StatefulWidget {
  final bool hasFilters;
  final bool isPinned;
  //Is floating determines if app bar should appear as soon as user scrolls up;
  final bool isFloating;
  CustomAppBar({
    @required this.hasFilters,
    @required this.isFloating,
    @required this.isPinned,
  });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  List<String> searchHist;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {
            print('showSearch()');
          },
          icon: Icon(
            Icons.search,
            size: 24,
            color: Colors.black38,
          ),
        ),
        CircleAvatar(
          maxRadius: 15,
          backgroundImage: AssetImage('assets/images/user.png'),
        )
      ],
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).popAndPushNamed(AppRoutes.WRAPPER);
        },
        child: Container(
          width: 100,
          child: Image.asset(
            'assets/images/logo.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      pinned: widget.isPinned,
      snap: widget.isFloating,
      floating: widget.isFloating,
      forceElevated: true,
      elevation: 10,
      bottom: widget.hasFilters
          ? CustomAppBarFilters()
          : PreferredSize(
              child: Container(), preferredSize: Size.fromHeight(0)),
    );
  }
}
