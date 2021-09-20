import 'package:flutter/material.dart';

class CustomAppBarFilters extends StatelessWidget with PreferredSizeWidget {
  final List filters = [
    'All',
    'Music',
    'Gameplay',
    'Comedies',
    'Pop Music',
    'Flutter',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black45))),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 14),
            margin: index == 0
                ? EdgeInsets.fromLTRB(16, 9, 8, 9)
                : EdgeInsets.fromLTRB(0, 9, 8, 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[400], width: 0.6),
              //TODO: Demo version of selected filter
              color: index == 0 ? Color(0xFF606060) : Colors.grey[300],
            ),
            child: GestureDetector(
              onTap: () {
                //On filter click; attach search here;
                print(filters[index]);
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${filters[index]}',
                  style: TextStyle(
                      fontSize: 16,
                      color: index == 0 ? Colors.white : Colors.black),
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
