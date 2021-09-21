import 'package:youtube_on_steroids/app/app.dart';

class VideoSetting extends StatefulWidget {
  @override
  _VideoSettingState createState() => _VideoSettingState();
}

class _VideoSettingState extends State<VideoSetting> {
  bool switcherState = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: Switch.adaptive(
            activeColor: Colors.white,
            value: switcherState,
            onChanged: (state) {
              setState(() {
                switcherState = !switcherState;
              });
            },
          ),
        ),
        SizedBox(width: 10),
        Icon(
          Icons.settings,
          size: 32.0,
          color: Colors.white,
        ),
        SizedBox(width: 15),
      ],
    );
  }
}
