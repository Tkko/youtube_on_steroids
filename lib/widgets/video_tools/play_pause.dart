import 'package:youtube_on_steroids/app/app.dart';

class PlayPause extends StatelessWidget {
  final Function setVideoState;
  final bool currentVideoState;

  PlayPause(this.setVideoState, this.currentVideoState);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        Icon(Icons.skip_previous, size: 40.0, color: Colors.white),
        InkWell(
          onTap: (){
            currentVideoState ? setVideoState(false) : setVideoState(true);
          },
          child: Icon(currentVideoState ? Icons.pause : Icons.play_arrow, size: 60.0, color: Colors.white),
        ),

        Icon(Icons.skip_next, size: 40.0, color: Colors.white),
        SizedBox(),
      ],
    );
  }
}
