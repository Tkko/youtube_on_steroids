import 'package:flutter/material.dart';

class VideoButtons extends StatelessWidget {
  final String text;
  final IconData icon;
  const VideoButtons(
    this.icon,
    this.text,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Icon(
            icon,
            color: Colors.grey[700],
          ),
        ),
        Text(
          text,
          style: TextStyle(color: Colors.grey[700]),
        ),
      ],
    );
  }
}
