import 'package:flutter/material.dart';

class CustomAppBarFilters extends StatelessWidget with PreferredSizeWidget {
  // const CustomAppBarFilters({Key key}) : super(key: key);
  final List filters = ['All', 'Music', 'Gameplay', 'Comedies', 'Pop Music'];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
        height: 60,
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.black45))),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filters.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: EdgeInsets.fromLTRB(0, 10, 8, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[350],
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('${filters[i]}'),
                ),
              );
            }));
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
