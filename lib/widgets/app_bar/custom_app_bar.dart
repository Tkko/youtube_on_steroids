import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/search/search.dart';
import 'package:youtube_on_steroids/widgets/app_bar/app_bar_filters.dart';

class CustomAppBar extends StatefulWidget {
  // const CustomAppBar({Key key}) : super(key: key);
  bool hasFilters = true;
  bool isPinned;
  bool isFloating;
  bool isSnapped;
  CustomAppBar(
      {this.hasFilters, this.isFloating, this.isPinned, this.isSnapped});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(
              Icons.search,
              size: 24,
              color: Colors.black38,
            ))
      ],
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          Navigator.of(context).popAndPushNamed(AppRoutes.WRAPPER);
        },
        child: Container(
          width: 100,
          child: Image.network(
            'https://www.vippng.com/png/full/5-53780_youtube-logo-youtube-text-logo-png.png',
            fit: BoxFit.fill,
          ),
        ),
      ),
      pinned: widget.isPinned,
      snap: widget.isSnapped,
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
