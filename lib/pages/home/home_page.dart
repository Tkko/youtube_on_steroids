import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/video_cards/basic_video_card.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder:(context, index) {
                return BasicVideoCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
