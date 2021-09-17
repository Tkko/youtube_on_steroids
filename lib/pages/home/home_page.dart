import 'dart:convert';

import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/home_history.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart' as c_appbar;
import 'package:youtube_on_steroids/widgets/tag_filter.dart';
import 'package:youtube_on_steroids/widgets/video_cards/classic.dart';

class HomePage extends StatefulWidget {
  final String url = 'PLz_ZtyOWL9BRNILDmtOX9Lmj_J_oPR2Qq';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(url);
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final String url;
  Future playlistFromNetwork;
  List<String> playlistFromDisk;
  BaseHistory history = HomeHistory();

  _HomePageState(this.url);

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    _getPlaylist();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _getPlaylist(){
    playlistFromDisk = history.show();

    if(history.show().length == 0){
      playlistFromNetwork = getFromNetwork();
    }
  }

  _onScroll() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('Load more item...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: c_appbar.Classic().display(context),
      body: Column(
        children: [
          TagFilter(),
          Expanded(
            flex: 10,
            child: playlistFromDisk.length == 0
            ?FutureBuilder(
              future: playlistFromNetwork,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: Text('Loading...'),
                  );
                }else {
                  if(snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }else{
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Classic(
                          ytModel: snapshot.data[index],
                        );
                      },
                    );
                  }
                }
              },
            )
            :ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: playlistFromDisk.length,
              itemBuilder: (context, index) {
                return Classic(
                    ytModel: YoutubePlaylist.fromMap(jsonDecode(playlistFromDisk[index]))
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future getFromNetwork() async{
    final videoSeen = Helper();
    final ytFacade = YoutubeExplodeFacade();
    final playlist = await ytFacade.fetchPlayList(url, 15, 0);
    final List<YoutubePlaylist> playlistModel = [];

    await playlist.forEach((e) async {
      final current =
        YoutubePlaylist(
          videoId: e.id.toString(),
          title: e.title,
          duration: e.duration.toString(),
          author: e.author,
          coverImage: e.thumbnails.highResUrl,
          view: videoSeen.videoSeen(21000, 2400000),
        );
      playlistModel.add(current);

      await history.create(jsonEncode(current.toMap()));
    });

    return playlistModel;
  }
}
