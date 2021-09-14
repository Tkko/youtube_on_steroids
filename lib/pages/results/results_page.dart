import 'dart:math';

import 'package:intl/intl.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class ResultsPage extends StatefulWidget {

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final keyword = ModalRoute.of(context).settings.arguments as String;
    final videoSeen = Helper();

    return Scaffold(
      appBar: Classic().display(context),
      body: FutureBuilder(
        future: YoutubeExplodeFacade().fetchSearchResults(keyword),
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
              return ListView.builder (
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {

                  return SmallVideoCard(
                    playlist: YoutubePlaylist(
                      videoId: snapshot.data[index].id.toString(),
                      title:  snapshot.data[index].title,
                      duration: snapshot.data[index].duration.toString(),
                      author: snapshot.data[index].author,
                      coverImage: snapshot.data[index].thumbnails.highResUrl,
                      view: videoSeen.videoSeen(21000, 2400000),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
