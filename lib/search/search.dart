import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';

import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/widgets/video_item.dart';

class Search extends SearchDelegate<List<String>> {
  @override
  String get searchFieldLabel => 'Search Here...';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
        fontSize: 5.0,
      );
  Future<List<String>> getSuggestions(String q) async {
    List<String> result;
    if (q.isNotEmpty) {
      print(q);
      var yt = new YoutubeHttpClient();
      result = await SearchClient(yt).getQuerySuggestions(q);
      print(result);
    }
    return result;
  }

  Future<List<Video>> getResults(String keyword) async {
    var yt = new YoutubeHttpClient();
    List<Video> results;
    if (keyword.isNotEmpty) {
      results = await SearchClient(yt).getVideos(keyword);
    }
    return results;
  }

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
    //TODO: get this in results page;
    return FutureBuilder<List<Video>>(
        future: getResults(searchKeyword),
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
                  id: data[index].id,
                  channelId: data[index].channelId,
                  author: data[index].author,
                  videoUrl: data[index].url,
                  views: data[index].engagement.viewCount,
                  duration: data[index].duration,
                  publishDate: data[index].publishDate,
                  thumbnail: data[index].thumbnails.mediumResUrl,
                  title: data[index].title,
                );
              },
            );
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<String>>(
        future: getSuggestions(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            //TODO: show previous Searches
            return Center(child: Text('No Search history'));
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
                            Text('${data[index]}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                        child: IconButton(
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
