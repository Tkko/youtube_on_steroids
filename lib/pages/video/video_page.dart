import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';

class VideoPage extends StatefulWidget {
  const VideoPage();
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  bool _isControlVisible = false;
  Future<dynamic> _initializeVideoPlayerFuture;
  void initPlayer(String videoUrl) {
    var yt = YoutubeExplode();
    var stream = yt.videos.get(videoUrl);

    // _initializeVideoPlayerFuture = _controller.initialize();

    // _controller = VideoPlayerController.network(videoUrl)
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
    //     setState(() {});
    //   });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://www.youtube.com/watch?v=TdrL3QxjyVw')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   String playUrl = ModalRoute.of(context).settings.arguments as String;
    //   initPlayer(playUrl);
    // });
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _controller.value.isInitialized
              ? Stack(children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _isControlVisible = !_isControlVisible;
                      });
                    },
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.center,
                        child: AnimatedOpacity(
                          opacity: _isControlVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Container(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                },
                                icon: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 70,
                                  color: Colors.white,
                                )),
                          ),
                        )),
                  )
                ])
              : Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
