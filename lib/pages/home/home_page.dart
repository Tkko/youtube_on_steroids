import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/facades/youtube_explode_facade.dart';
import 'package:youtube_on_steroids/widgets/appbars/classic.dart' as c_appbar;
import 'package:youtube_on_steroids/widgets/tag_filter.dart';
import 'package:youtube_on_steroids/widgets/video_cards/classic.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final String _playlistUrl = 'PLz_ZtyOWL9BRNILDmtOX9Lmj_J_oPR2Qq';
  final int _loadAmount = 15;
  final int _skipAmount = 0;

  _HomePageState();

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _onScroll() {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      print('Load more item...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: c_appbar.Classic().display(context),
      body: Column(
        children: [
          TagFilter(),
          Expanded(
            flex: 10,
            child: FutureBuilder(
              future: YoutubeExplodeFacade().fetchPlayList(_playlistUrl, _loadAmount, _skipAmount),
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
                    return ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Classic(
                          ytModel: snapshot.data[index],
                        );
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
