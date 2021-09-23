import 'package:flutter/material.dart';

class HistoryTextButton extends StatelessWidget {
  final String text;
  final Function function;
  const HistoryTextButton({@required this.text, @required this.function});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 9.8, horizontal: 7.98),
        child: TextButton(
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 14, height: 1.2),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
          onPressed: function,
        ),
      ),
    );
  }
}
