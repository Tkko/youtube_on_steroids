import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/utils/playlist_preference.dart';

class YoutubeSearch extends SearchDelegate {
  List<String> suggestions;

  Future currentResult(String key) async {
    List<String> currentQuerySuggestions = await YoutubeExplode().search.getQuerySuggestions(key);

    return currentQuerySuggestions;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: currentResult(query),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: Text('Loading...'),
          );
        }else {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  ListTile(
                      onTap: () {
                        addSearchHistory();
                        Navigator.popAndPushNamed(
                          context,
                          AppRoutes.RESULT_PAGE,
                          arguments: snapshot.data[index],
                        );
                      },
                      title: Text(snapshot.data[index])
                  ),
            );
          }
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: retrieveSearchHistory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Text('Loading...'),
          );
        } else {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    title: Text(snapshot.data[index]),
                    onTap: () {
                      Navigator.popAndPushNamed(
                        context,
                        AppRoutes.RESULT_PAGE,
                        arguments: snapshot.data[index],
                      );
                    },
                  ),
            );
          }
        }
      },
    );
  }

  Future<void> addSearchHistory() async {
    await PlaylistPreference.init();

    PlaylistPreference.setPlaylistKey('searchResult');

    List<String> searchHistory = PlaylistPreference.getPlaylist() ?? [];

    if(searchHistory.contains(query)){
      searchHistory.removeWhere((element) => element == query);
    }

    searchHistory.insert(0, query);
    PlaylistPreference.setPlaylist(searchHistory);
  }

  Future retrieveSearchHistory() async {
    await PlaylistPreference.init();
    PlaylistPreference.setPlaylistKey('searchResult');

    return PlaylistPreference.getPlaylist() ?? [];
  }
}