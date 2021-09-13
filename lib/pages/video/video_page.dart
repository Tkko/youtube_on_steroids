// import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/services/search.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/video_item.dart';

class VideoPage extends StatefulWidget {
  const VideoPage();
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  // VideoId videoId;
  String videoUrl = '';
  bool _isVideoLoading = true;
  bool _isVideoLoaded = true;
  bool _isControlVisible = true;
  String _errorMessage;
  Video _video;

  void initPlayer() async {
    print('went into initPlayer');
    if (videoUrl != '') {
      _controller = VideoPlayerController.network(videoUrl);
      await _controller.initialize().then((value) {
        setState(() {
          _isVideoLoaded = true;
          _isControlVisible = true;
        });
      });
      print('${_controller.value.isInitialized}');
      print('waiting for init in controller');
    } else {
      _isVideoLoading = false;
      return;
    }
  }

  void getUrl() async {
    _video = ModalRoute.of(context).settings.arguments;

    if (_video.id == null) {
      _isVideoLoading = false;
    } else {
      setState(() {
        _isVideoLoading = true;
      });
      var yt = YoutubeHttpClient();
      try {
        var streamInfo = await StreamsClient(yt).getManifest(_video.id);
        var muxed = streamInfo.muxed.sortByVideoQuality().first;
        print('got stream Info');
        videoUrl = muxed.url.toString();
        initPlayer();
        yt.close();
        // setState(() {});
      } on VideoUnplayableException catch (e) {
        print('$e');
        setState(() {
          _isVideoLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }
  //TODO:: comments not working;

  // Future<CommentsList> getCommentInfo() async {
  //   var yt = YoutubeHttpClient();
  //   var comments = await CommentsClient(yt).getComments(_video);
  //   print(comments.first);
  //   return comments;
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUrl();
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      _isVideoLoading = false;
      _isControlVisible = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildButton(IconData icon, String text) {
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

    Widget _buildPlayerStack() {
      return Stack(children: [
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
                    constraints: BoxConstraints(maxHeight: 50, maxWidth: 50),
                    padding: EdgeInsets.zero,
                    iconSize: 70,
                    onPressed: _controller.value != null
                        ? () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          }
                        : () {},
                    icon: Icon(
                      _controller.value != null
                          ? _controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow
                          : Icons.question_answer_rounded,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        )
      ]);
    }

    Widget _buildInfoBlock(channel) {
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
              '${_video.title}',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              '${_video.engagement.viewCount} views • ${_video.publishDate} day ago',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            trailing: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
              size: 24,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildButton(
                    Icons.thumb_up_outlined, '${_video.engagement.likeCount}'),
                _buildButton(Icons.thumb_down_outlined,
                    '${_video.engagement.dislikeCount}'),
                _buildButton(Icons.share_outlined, "Share"),
                _buildButton(Icons.cloud_download_outlined, "Download"),
                _buildButton(Icons.playlist_add_outlined, "Save"),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 0.5),
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(channel.logoUrl.toString()),
                    ),
                    title: Text(
                      '${channel.title}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                    subtitle: Text(
                      "${NumberFormat.compact().format(channel.subscribersCount)} subscribers",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "SUBSCRIBE",
                      style: TextStyle(color: Colors.red),
                    ))
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(12, 8, 8, 0),
            child: Text(
              'Up Next',
              textAlign: TextAlign.start,
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border(
          //       bottom: BorderSide(color: Colors.grey, width: 0.5),
          //     ),
          //   ),
          //   child: Row(
          //     children: <Widget>[
          //       Expanded(
          //         child: ListTile(
          //           title: Row(
          //             children: [
          //               Text(
          //                 'Comments',
          //                 overflow: TextOverflow.ellipsis,
          //                 style: TextStyle(fontSize: 14),
          //               ),
          //               Text(
          //                 ' • ${comment.length}',
          //                 style:
          //                     TextStyle(color: Colors.grey[600], fontSize: 14),
          //               )
          //             ],
          //           ),
          //           trailing: Icon(Icons.unfold_more),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      );
    }

    Widget _buildSuggestions(List<Video> video) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: video.length,
            itemBuilder: (context, index) {
              return VideoItem(video: video[index]);
            }),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        leadingWidth: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.WRAPPER);
          },
          child: Container(
            width: 150,
            child: Image.network(
              'https://download.logo.wine/logo/YouTube/YouTube-White-Full-Color-Logo.wine.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: Icon(
                Icons.search,
                size: 24,
                color: Colors.white60,
              ))
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            YoutubeHelper.getChannelInfo(_video.id),
            YoutubeHelper.getVideoSuggestions(
                _video.keywords, _video.title.toString()),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: <Widget>[
                  _isVideoLoading
                      ? _isVideoLoaded
                          ? _controller.value.isInitialized
                              ? _buildPlayerStack()
                              : CircularProgressIndicator()
                          : Stack(children: [
                              Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                              Positioned.fill(
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ])
                      : Container(
                          height: 300,
                          width: double.infinity,
                          color: Colors.black,
                          child: Text(
                            _errorMessage ?? 'Error Loading Video',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildInfoBlock(snapshot.data[0]),
                          _buildSuggestions(snapshot.data[1]),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            print('snapshot error : ${snapshot.error}');
            print('Video : ${_video.author} - ${_video.title}');
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
      // ),
      // ),
    );
  }
}
