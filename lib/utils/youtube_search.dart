import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/search_result_history.dart';

class YoutubeSearch extends SearchDelegate {
  List<String> suggestions;
  BaseHistory history = SearchResultHistory();

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
                        history.create(query);
                        history.create(snapshot.data[index]);
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
    List<String> data = history.show();

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) =>
          ListTile(
            title: Text(data[index]),
            onTap: () {
              history.create(data[index]);
              Navigator.popAndPushNamed(
                context,
                AppRoutes.RESULT_PAGE,
                arguments: data[index],
              );
              },
          ),
    );
  }
}