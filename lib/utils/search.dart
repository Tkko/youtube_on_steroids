import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';

import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/services/cache/search_cache.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class Search extends SearchDelegate<List<String>> {
  Search();
  String clickedQuery;
  final YoutubeExplodeFacade ytFacade = YoutubeExplodeFacade();

  @override
  String get searchFieldLabel => 'Search Here...';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontSize: 5.0,
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear)),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
        future: resultHandler(),
        builder: (context, snapshot) {
          // Data is loading here
          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.red[700],
            ));
          }
          // Data is loaded
          final data = snapshot.data;
          if (!snapshot.hasData) {
            return Text('No data');
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return SmallVideoCard(
                  ytModel: data[index],
                );
              },
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: YoutubeExplodeFacade().fetchKeywordSuggestion(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            List<String> history = SearchResultHistory().show();
            return Center(
              child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Row(children: <Widget>[
                      Expanded(
                        flex: 17,
                        child: GestureDetector(
                          onTap: () {
                            clickedQuery = history[index];
                            query = history[index];
                            showResults(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey[350]))),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            height: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      IconButton(
                                        iconSize: 20,
                                        color: Colors.grey[700],
                                        icon: Icon(Icons.history),
                                        onPressed: () {},
                                      ),
                                      Text('${history[index]}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Container(
                            child: IconButton(
                              iconSize: 16,
                              onPressed: () {
                                query = history[index];
                              },
                              icon: Icon(Icons.north_west),
                            ),
                          ))
                    ]);
                  }),
            );
          }
          if (!snapshot.hasData) {
            return Text('No data');
          } else {
            final List<String> data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(children: <Widget>[
                  Expanded(
                    flex: 17,
                    child: GestureDetector(
                      onTap: () {
                        query = data[index];
                        clickedQuery = data[index];
                        showResults(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.grey[350]))),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        height: 50,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  IconButton(
                                    iconSize: 20,
                                    color: Colors.grey[700],
                                    icon: Icon(Icons.search),
                                    onPressed: () {},
                                  ),
                                  Text('${data[index]}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Container(
                        child: IconButton(
                          iconSize: 16,
                          onPressed: () {
                            query = data[index];
                          },
                          icon: Icon(Icons.north_west),
                        ),
                      ))
                ]);
              },
            );
          }
        });
  }

  Future resultHandler() async {
    String searchKeyword;
    if (clickedQuery != null) {
      searchKeyword = clickedQuery;
    }
    SearchResultHistory().create(searchKeyword ?? query);

    List<Video> results =
        await ytFacade.fetchSearchResults(searchKeyword ?? query);
    List<YoutubePlaylist> videos = [];
    results.forEach((e) {
      final YoutubePlaylist current = YoutubePlaylist(
        videoId: e.id.toString(),
        title: e.title,
        author: e.author,
        coverImage: e.thumbnails.highResUrl,
        view: '2100',
        isLive: e.isLive,
        duration: Helper.durationDisplay(e.duration),
      );
      videos.add(current);
    });
    return videos;
  }
}
