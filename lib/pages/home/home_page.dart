import 'dart:convert';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/playlist_preference.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart' as c_appbar;
import 'package:youtube_on_steroids/widgets/tag_filter.dart';
import 'package:youtube_on_steroids/widgets/video_cards/classic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final String _playlistUrl = 'PLz_ZtyOWL9BRNILDmtOX9Lmj_J_oPR2Qq';
  final int _loadAmount = 15;
  final int _skipAmount = 0;

  _HomePageState();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            child: FutureBuilder(
              future: getPlaylist(),
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
            ),
          ),
        ],
      ),
    );
  }

  /// Returns playlist from network or disk if it is accessible
  Future getPlaylist() async{
    List<YoutubePlaylist> playlistModel = [];
    List<String> playlistJson = [];

    PlaylistPreference.setPlaylistKey(_playlistUrl);
    await PlaylistPreference.init();

    if(PlaylistPreference.getPlaylist() != null) { //checks if data available on disk TODO:: if internet is not available and data on disk available then : take it from disk
      playlistJson = PlaylistPreference.getPlaylist();
      for(int i=0; i < playlistJson.length; i++) {
        playlistModel.add(YoutubePlaylist.fromMap(jsonDecode(playlistJson[i])));
      }

      return playlistModel;
    }

    final playlist = await YoutubeExplodeFacade().fetchPlayList(_playlistUrl, _loadAmount, _skipAmount);

    await playlist.forEach((e) {
      final current = YoutubePlaylist(
        videoId: e.id.toString(),
        title: e.title,
        duration: e.duration.toString(),
        author: e.author,
        coverImage: e.thumbnails.highResUrl,
        view: videoWatched(21000, 2400000),
      );
      playlistModel.add(current);
      playlistJson.add(jsonEncode(current.toMap()));
    });

    PlaylistPreference.setPlaylist(playlistJson);

    return playlistModel;
  }

  /// Generates random youtube watch
  String videoWatched(int min, int max) {
    final random = new Random();

    return NumberFormat.compact().format(min + random.nextInt(max-min));
  }
}
