import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../widgets/video_item.dart';

class HomePage extends StatelessWidget {
  const HomePage();
  Future<List<Video>> getPlayList() async {
    List<Video> videos = [];
    var yt = YoutubeExplode();

    await for (var video in yt.playlists
        .getVideos('PLtE5j1bLtffCx_6gjkywC6hdNMpOe23_O')
        .take(20)) {
      videos.add(video);
    }

    return videos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Video>>(
            future: getPlayList(),
            builder: (context, snapshot) {
              // Data is loading here
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
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
            }),
      ),
    );
  }
}
