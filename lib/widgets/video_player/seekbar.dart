import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final controller;
  const SeekBar(this.controller);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double durationToDouble(Duration duration) {
    final val = duration.inSeconds.toDouble();
    return val;
  }

  String _durationDisplay(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    if (duration.inHours == 0) {
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 14,
      margin: EdgeInsets.only(left: 6),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Row(
          children: [
            Text(
              _durationDisplay(widget.controller.value.position),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' / ${_durationDisplay(widget.controller.value.duration)}',
              style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            SliderTheme(
              data: SliderThemeData(
                  trackHeight: 2,
                  activeTrackColor: Colors.red[600],
                  inactiveTrackColor: Colors.grey[700].withOpacity(0.7),
                  thumbColor: Colors.red,
                  overlayColor: Colors.red[600].withOpacity(0.2)),
              child: Container(
                width: 300,
                child: Slider(
                  onChanged: (val) {
                    setState(() {
                      widget.controller.seekTo(Duration(seconds: val.toInt()));
                    });
                  },
                  min: 0.0,
                  value: durationToDouble(widget.controller.value.position),
                  max: durationToDouble(widget.controller.value.duration),
                  // onChangeEnd: (val) {
                  //   setState(() {
                  //     widget.controller.seekTo(Duration(seconds: val.toInt()));
                  //   });
                  // },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
