import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';

import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/helpers/youtube_explode_helper.dart';
import 'package:youtube_on_steroids/widgets/video_cards/home_video_card.dart';

import 'history/search_history.dart';

class Search extends SearchDelegate<List<String>> {
  final List<String> history;
  Search(this.history);

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
    final searchKeyword = query;
    // TODO: get this in results page;
    return FutureBuilder(
        future: YoutubeHelper.getSearchResults(searchKeyword),
        builder: (context, snapshot) {
          // Data is loading here
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          // Data is loaded
          final data = snapshot.data;
          if (!snapshot.hasData) {
            return Text('No data');
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return VideoItem(
                  video: data[index],
                );
              },
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: YoutubeHelper.getSearchSuggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Row(children: <Widget>[
                      Expanded(
                        flex: 17,
                        child: GestureDetector(
                          onTap: () {
                            SearchHistory.saveSearchHistory(history[index]);
                            Navigator.of(context).popAndPushNamed(
                                AppRoutes.SEARCH_RESULTS,
                                arguments: history[index]);
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
            final data = snapshot.data;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Row(children: <Widget>[
                  Expanded(
                    flex: 17,
                    child: GestureDetector(
                      onTap: () {
                        SearchHistory.saveSearchHistory(data[index]);
                        Navigator.of(context).popAndPushNamed(
                            AppRoutes.SEARCH_RESULTS,
                            arguments: data[index]);
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
}
