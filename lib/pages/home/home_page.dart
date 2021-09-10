import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:youtube_on_steroids/controllers/youtube_explode_controller.dart';

import '../../widgets/video_item.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Video>> _data;
  void initState() {
    super.initState();
    _data = YoutubeController.getPlaylist('PLFs4vir_WsTyY31efyHdmtp9l7DpR0Wvi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Video>>(
            //TODO: try qubits
            future: _data,
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
                    return VideoItem(data[index]);
                  },
                );
              }
            }),
      ),
    );
  }
}
