import 'package:video_player/video_player.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';

class VideoPage extends StatefulWidget {
  final YoutubePlaylist ytModel;

  VideoPage({
    @required this.ytModel
  });

  @override
  _VideoPageState createState() => _VideoPageState(ytModel: ytModel);
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  final YoutubePlaylist ytModel;

  _VideoPageState({
    @required this.ytModel,
  });

  @override
  void initState() {
    super.initState();
    YoutubeExplodeFacade().getStreamUrl(ytModel.videoId).then((url){
      _controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if(_controller != null) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Classic().display(context),
      body: Column(
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            color: Colors.black,
            child: _controller != null
                ? Stack(
              children:[
                GestureDetector(
                  onTap: () =>  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  }),
                  child: Container(
                    width: double.infinity,
                    child:  _controller.value.isInitialized
                        ? AspectRatio(aspectRatio: _controller.value.aspectRatio, child: VideoPlayer(_controller))
                        : Text('Video loading...'),
                  ),
                ),
                !_controller.value.isPlaying
                    ? Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _controller.play();
                      });
                    },
                    child: Icon( Icons.play_arrow),
                  ),
                )
                    : Center(),
              ],
            )
                : Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
