import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/services/history/base_history.dart';
import 'package:youtube_on_steroids/services/history/search_result_history.dart';

class YoutubeSearch extends SearchDelegate {
  BaseHistory history = SearchResultHistory();
  YoutubeExplodeFacade ytFacade = YoutubeExplodeFacade();

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
      future: ytFacade.fetchKeywordSuggestion(query),
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
                      onTap: () async{
                        await history.create(query);
                        await history.create(snapshot.data[index]);
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
            onTap: () async{
              await history.create(data[index]);
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