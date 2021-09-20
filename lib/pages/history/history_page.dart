import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return SmallVideoCard();
          },
        ),
      ),
    );
  }
}
