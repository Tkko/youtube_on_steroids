import 'package:flutter/cupertino.dart';
import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/models/youtube_playlist.dart';
import 'package:youtube_on_steroids/pages/video/into_video.dart';
import 'package:youtube_on_steroids/utils/helper.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart' as app_bar;
import 'package:youtube_on_steroids/widgets/video_cards/classic.dart';

class VideoPage extends StatefulWidget {
  final YoutubePlaylist ytModel;

  VideoPage({
    @required this.ytModel
  });

  @override
  _VideoPageState createState() => _VideoPageState(ytModel: ytModel);
}

class _VideoPageState extends State<VideoPage> {
  final YoutubePlaylist ytModel;
  final Helper helper = Helper();
  bool darkFrame = false;

  _VideoPageState({
    @required this.ytModel,
  });



  @override
  Widget build(BuildContext context) {

    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: app_bar.Classic().display(context),
      body: Column(
        children: [
          IntoVideo(ytModel: ytModel),
          Expanded(
            child: Container(
              width: double.infinity,
              // color: Colors.red,
              child: ListView(
                children: [
                  ListTile(
                      title: Text(ytModel.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                      subtitle: Text('${ytModel.view} views - 1 years ago'),
                      trailing: Icon(Icons.arrow_drop_down),
                  ),
                  Container(
                    width: double.infinity,
                    height: 70.h,
                    margin: const EdgeInsets.only(top: 8),
                    // color: Colors.greenAccent,
                    child: Row(
                      children: [
                        SizedBox(width: deviceWidth * 0.09),
                        Column(
                          children: [
                            InkWell(
                              onTap: () => print("shit"),
                              child: Icon(Icons.thumb_up_outlined, size: 28,),
                            ),
                            Text('200K'),
                          ],
                        ),
                        SizedBox(width: deviceWidth * 0.09),

                        Column(
                          children: [
                            InkWell(
                              onTap: () => print("shit"),
                              child: Icon(Icons.thumb_down_outlined, size: 28,),
                            ),
                            Text('1.2K'),
                          ],
                        ),
                        SizedBox(width: deviceWidth * 0.09),

                        Column(
                          children: [
                            InkWell(
                              onTap: () => print("shit"),
                              child: Icon(Icons.share_outlined, size: 28,),
                            ),
                            Text('Share'),
                          ],
                        ),
                        SizedBox(width: deviceWidth * 0.09),

                        Column(
                          children: [
                            InkWell(
                              onTap: () => print("shit"),
                              child: Icon(Icons.whatshot_outlined, size: 28,),
                            ),
                            Text('Save'),
                          ],
                        ),
                        SizedBox(width: deviceWidth * 0.09),
                        Column(
                          children: [
                            InkWell(
                              onTap: () => print("shit"),
                              child: Icon(Icons.flag_outlined, size: 28,),
                            ),
                            Text('Report'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  ListTile(
                    leading: InkWell(
                      onTap: () { print('clicked');},
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: 50,
                          maxHeight: 50,
                          minWidth: 50,
                          maxWidth: 50,
                        ),
                        child: ClipRRect(
                          child: Image.asset('assets/images/userv2.jpg'),
                          borderRadius: BorderRadius.circular(23.0),
                        ),
                      ),
                    ),
                    title: Text(ytModel.author, style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('300K subscribers'),
                    trailing: Text('SUBSCRIBE', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17)),
                  ),
                  Divider(
                    height: 10,
                    thickness: 1,
                  ),
                  FutureBuilder(
                    future: YoutubeExplodeFacade().fetchSearchResults('tax'),
                    builder:(BuildContext context, AsyncSnapshot snapshot){
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
                          List<Widget> videos = [];
                          // TODO:: SAVE IT IN MAP
                          for(int i=0; i<snapshot.data.length; i++){
                            videos.add(Classic(
                              ytModel: YoutubePlaylist(
                                videoId: snapshot.data[i].id.toString(),
                                title:  snapshot.data[i].title,
                                duration: snapshot.data[i].duration.toString(),
                                author: snapshot.data[i].author,
                                coverImage: snapshot.data[i].thumbnails.highResUrl,
                                view: '200',
                              )),
                            );
                          }
                          return Column(
                            children: videos,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
