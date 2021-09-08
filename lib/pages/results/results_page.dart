import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/custom_app_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({Key key}) : super(key: key);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    String query = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              CustomAppBar(),
            ];
          },
          body: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }
}
