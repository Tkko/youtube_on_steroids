import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/search/search.dart';

class CustomAppBar extends StatefulWidget {
  // const CustomAppBar({Key key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  // TextEditingController _searchQueryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        // _isSearching
        //     ?
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: Icon(Icons.search))
        // : IconButton(
        //     onPressed: () {
        //       setState(() {
        //         _isSearching = true;
        //       });
        //     },
        //     icon: Icon(Icons.search))
      ],
      // title: _isSearching
      //     ? TypeAheadField<String>(
      //         textFieldConfiguration: TextFieldConfiguration(
      //             style: TextStyle(
      //               color: Colors.black,
      //             ),
      //             cursorColor: Colors.black,
      //             autofocus: true,
      //             decoration: InputDecoration(
      //               // focusedBorder: UnderlineInputBorder(
      //               //     borderRadius: BorderRadius.circular(23)),
      //               // enabledBorder: UnderlineInputBorder(
      //               //     borderRadius: BorderRadius.circular(23)),
      //               // fillColor: Colors.white,
      //               filled: true,
      //               hintText: 'Search Here',
      //             )),
      //         suggestionsCallback: getSuggestions,
      //         suggestionsBoxDecoration: SuggestionsBoxDecoration(
      //             elevation: 30,
      //             constraints: BoxConstraints(
      //               maxHeight: 400,
      //             )),
      //         itemBuilder: (context, data) {
      //           final suggestion = data;
      //           return Container(
      //             decoration: BoxDecoration(
      //                 border: Border(
      //               bottom: BorderSide(width: 1, color: Colors.grey),
      //             )),
      //             child: ListTile(
      //               title: Text(suggestion),
      //             ),
      //           );
      //         },
      //         onSuggestionSelected: (suggestion) {
      //           // getVideos(suggestion);
      //         },
      //       )
      //     : Text(''),
      leading: Container(
        width: 50,
        child:
            //  _isSearching
            // ? IconButton(
            //     onPressed: () {
            //       setState(() {
            //         _isSearching = false;
            //       });
            //     },
            //     icon: Icon(Icons.arrow_back))
            // :
            Image.network(
          'https://www.vippng.com/png/full/5-53780_youtube-logo-youtube-text-logo-png.png',
          fit: BoxFit.fitWidth,
        ),
      ),
      pinned: false,
      snap: true,
      floating: true,
      forceElevated: true,
      elevation: 10,
    );
  }
}
