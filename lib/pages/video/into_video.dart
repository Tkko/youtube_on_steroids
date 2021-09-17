import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_tools/play_pause.dart';
import 'package:youtube_on_steroids/widgets/video_tools/setting.dart';

class IntoVideo extends StatefulWidget {
  final YoutubePlaylist ytModel;

  IntoVideo({
    @required this.ytModel
  });

  @override
  _IntoVideoState createState() => _IntoVideoState(ytModel: ytModel);
}

class _IntoVideoState extends State<IntoVideo> {
  VideoPlayerController _videoController;
  YoutubeExplodeFacade ytFacade = YoutubeExplodeFacade();
  YoutubePlaylist ytModel;
  Helper helper = Helper();
  bool darkFrame = false;

  _IntoVideoState({
    @required this.ytModel,
  });

  @override
  void initState() {
    super.initState();
    YoutubeExplodeFacade().fetchStreamUrl(ytModel.videoId).then((url){
      _videoController = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
          _videoController.play();
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(_videoController != null) {
      _videoController.dispose();
    }
  }

  playVideo(bool run){
    setState(() {
      run ? _videoController.play() : _videoController.pause();
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 200.h,
      width: double.infinity,
      color: Colors.black,
      child: _videoController != null
          ? GestureDetector(
        onTap: () =>  setState(() {
          darkFrame = !darkFrame;
        }),
        child: Stack(
          children:[
            Container(
              width: double.infinity,
              child:  _videoController.value.isInitialized
                  ? AspectRatio(aspectRatio: _videoController.value.aspectRatio, child: VideoPlayer(_videoController))
                  : Text('Video loading...'),
            ),
            darkFrame
                ? Container(
              width: double.infinity,
              height: 200.h,
              color: Colors.black.withOpacity(0.3),
              child: Column(
                children: [
                  Container(
                    width: deviceWidth,
                    height: 66.666.h,
                    // color: Colors.red,
                    child: Setting(),
                  ),
                  Container(
                    width: deviceWidth,
                    height: 66.666.h,
                    // color: Colors.blue,
                    child: PlayPause(playVideo, _videoController.value.isPlaying),
                  ),
                  Container(
                    width: deviceWidth,
                    height: 66.666.h,
                    // color: Colors.pink,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          SizedBox(width: deviceWidth * 0.03),
                          Text('${helper.durationToTime(_videoController.value.position.toString())} /', style: TextStyle(color: Colors.white)),
                          Text(' ${helper.durationToTime(ytModel.duration)}', style: TextStyle(color: Colors.grey[200])),
                          SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              activeTrackColor: Colors.red,
                              inactiveTrackColor: Colors.grey[300],
                              trackHeight: 4.0,
                              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7.0),
                              thumbColor: Colors.red,
                              overlayColor: Colors.red.withAlpha(5),
                            ),
                            child:Container(
                              width: deviceWidth * 0.66,
                              child: Slider(
                                value: helper.durationToDouble(_videoController.value.position.toString()),
                                onChanged: (value){
                                  setState(() {
                                    _videoController.seekTo(Duration(seconds: (value * 60).toInt()));
                                  });
                                },
                                min: 0.0,
                                max: helper.durationToDouble(ytModel.duration),
                              ),
                            ),
                          ),
                          Expanded(child:
                          IconButton(
                            onPressed: (){},
                            icon: Icon(Icons.fullscreen, color: Colors.white,),
                          ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
                : Container(),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
