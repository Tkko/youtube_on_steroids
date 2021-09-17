import 'package:youtube_on_steroids/app/app.dart';

class Setting extends StatefulWidget {
  // const Setting();

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
        Icon(Icons.settings, size: 32.0),
        SizedBox(width: 15),
      ],
    );
  }
}
