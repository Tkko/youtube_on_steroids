import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/constants.dart';

class CustomAppBarFilters extends StatelessWidget with PreferredSizeWidget {
  // const CustomAppBarFilters({Key key}) : super(key: key);
  final List filters = ['All', 'Music', 'Gameplay', 'Comedies', 'Pop Music'];

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      height: 48,
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black45))),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, i) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            margin: i == 0
                ? EdgeInsets.fromLTRB(16, 9, 8, 9)
                : EdgeInsets.fromLTRB(0, 9, 8, 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[400], width: 0.6),
              //TODO: Demo
              color: i == 0 ? Color(0xFF606060) : Colors.grey[300],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(AppRoutes.SEARCH_RESULTS, arguments: filters[i]);
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${filters[i]}',
                  style: TextStyle(
                      fontSize: 16,
                      color: i == 0 ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48);
}
