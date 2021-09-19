// import 'package:http/http.dart' as http;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/services/history/search_history.dart';
import 'package:youtube_on_steroids/services/history/watch_history.dart';
import 'package:youtube_on_steroids/services/search.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/home_video_card.dart';
import 'package:youtube_on_steroids/widgets/video_player/video_player_widget.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoPage extends StatefulWidget {
  const VideoPage();
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  VideoPlayerController _controller;
  VideoId videoId;
  String videoUrl = '';
  bool _isVideoLoading = true;
  bool _isVideoLoaded = true;
  // bool _isControlVisible = true;
  String _errorMessage;
  Video _video;
  DateTime daysAgo;
  List<String> searchHist;

  void initPlayer() async {
    print('went into initPlayer');
    if (videoUrl != '') {
      _controller = VideoPlayerController.network(videoUrl);
      await _controller.initialize().then((value) {
        setState(() {
          _isVideoLoaded = true;
        });
      });
      searchHist = await SearchHistory.getSearchHistory();
      print('${_controller.value.isInitialized}');
      print('waiting for init in controller');
    } else {
      _isVideoLoading = false;
      return;
    }
  }

  void getUrl() async {
    videoId = ModalRoute.of(context).settings.arguments;
    _video = await YoutubeHelper.getVideo(videoId);
    if (_video.id == null) {
      _isVideoLoading = false;
    } else {
      setState(() {
        _isVideoLoading = true;
      });
      try {
        await YoutubeHelper.getStreamUrl(videoId).then((value) {
          videoUrl = value;
          initPlayer();
        });

        // setState(() {});
      } on Exception catch (e) {
        print('$e');
        setState(() {
          _isVideoLoading = false;
          _errorMessage = e.toString();
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (_controller != null && _controller.value.isInitialized) {
      _controller.dispose();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller == null || _controller.value == null) {
      getUrl();
    }
  }

  void showDescriptionModal(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    child: Divider(
                      height: 15,
                      thickness: 5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 24),
                          child: Text(
                            'Description',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700]),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[600],
                          ),
                          iconSize: 24,
                        ),
                      )
                    ],
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Text(_video.description),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      print('DISPOSED========DISPOSED=====DISPOSED');
      _isVideoLoading = false;
      // _isControlVisible = false;
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceOrientation = MediaQuery.of(context).orientation;
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

    Widget _buildInfoBlock(
      channel,
    ) {
      daysAgo = new DateTime.now()
          .subtract(new Duration(days: _video.publishDate.day));
      return Column(
        children: <Widget>[
          ListTile(
            title: Text(
              '${_video.title}',
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Text(
              '${NumberFormat.compact().format(_video.engagement.viewCount)}  views • ${timeago.format(daysAgo)}',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            trailing: IconButton(
              onPressed: () {
                showDescriptionModal(context);
              },
              padding: EdgeInsets.zero,
              icon: Icon(Icons.keyboard_arrow_down_sharp),
              color: Colors.black,
              iconSize: 24,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildButton(Icons.thumb_up_outlined,
                    '${NumberFormat.compact().format(_video.engagement.likeCount)}'),
                _buildButton(Icons.thumb_down_outlined,
                    '${NumberFormat.compact().format(_video.engagement.dislikeCount)}'),
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
                    subtitle: channel.subscribersCount != null
                        ? Text(
                            "${NumberFormat.compact().format(channel.subscribersCount)} subscribers",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12))
                        : Container(),
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
              return GestureDetector(
                  onTap: () {
                    WatchHistory().saveHistory(video[index]);
                    Navigator.of(context).popAndPushNamed(
                        AppRoutes.SINGLE_VIDEO,
                        arguments: video[index].id);
                  },
                  child: VideoItem(video: video[index]));
            }),
      );
    }

    return Scaffold(
      appBar: deviceOrientation == Orientation.portrait
          ? AppBar(
              brightness: Brightness.dark,
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
                      showSearch(
                          context: context, delegate: Search(searchHist));
                    },
                    icon: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.white60,
                    ))
              ],
            )
          : PreferredSize(child: Container(), preferredSize: Size.zero),
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            YoutubeHelper.getChannelInfo(videoId),
            YoutubeHelper.getVideoSuggestions(videoId.toString()),
          ]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  //TODO fix this mess
                  _isVideoLoading
                      ? _isVideoLoaded
                          ? _controller.value != null
                              ? VideoPlayerWidget(_controller)
                              : CircularProgressIndicator(
                                  color: Colors.red[700],
                                )
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
                    child: deviceOrientation == Orientation.portrait
                        ? SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                deviceOrientation == Orientation.portrait
                                    ? _buildInfoBlock(snapshot.data[0])
                                    : Container(),
                                deviceOrientation == Orientation.portrait
                                    ? _buildSuggestions(snapshot.data[1])
                                    : Container(),
                              ],
                            ),
                          )
                        : Container(),
                  )
                ],
              );
            }
            // print('snapshot error : ${snapshot.error}');
            // print('Video : ${_video.author} - ${_video.title}');
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red[700],
              ),
            );
          },
        ),
      ),
      // ),
    );
  }
}
