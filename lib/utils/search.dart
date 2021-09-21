import 'package:youtube_on_steroids/app/app.dart';

import 'package:flutter/material.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class Search extends SearchDelegate<List<String>> {
  Search();
  List<String> data = [
    'a-placeholder1',
    'b-PlaceHolder2',
    'c-placeHolder3',
    'c-Placeholder5'
  ];
  List<String> history = [
    'history1',
    'history2',
    'history3',
    'history4',
  ];
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
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return SmallVideoCard();
      },
    );
  }

  Widget _historyList() {
    return ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          print(history);
          return Row(children: <Widget>[
            Expanded(
              flex: 17,
              child: GestureDetector(
                onTap: () {
                  query = history[index];
                  showResults(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(width: 1, color: Colors.grey[350]))),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
        });
  }

  Widget _suggestionList() {
    final List<String> suggest =
        data.where((element) => element.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggest.length,
      itemBuilder: (context, index) {
        return Row(children: <Widget>[
          Expanded(
            flex: 17,
            child: GestureDetector(
              onTap: () {
                query = suggest[index];
                showResults(context);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.grey[350]))),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                          Text('${suggest[index]}'),
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
                    query = suggest[index];
                  },
                  icon: Icon(Icons.north_west),
                ),
              ))
        ]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return _historyList();
    } else {
      return _suggestionList();
    }
  }
}
