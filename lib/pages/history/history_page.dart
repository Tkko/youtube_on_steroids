import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage();

  @override
  Widget build(BuildContext context) {
    Widget _buildButton({String text, Function function}) {
      return Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 9.8, horizontal: 7.98),
          child: TextButton(
            child: Text(
              text,
              style: TextStyle(color: Colors.black, fontSize: 14, height: 1.2),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            onPressed: function,
          ),
        ),
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              _buildButton(
                  text: 'CLEAR ALL WATCH HISTORY',
                  function: () {
                    print('clear history');
                  }),
              _buildButton(
                  text: 'CLEAR ALL SEARCH HISTORY',
                  function: () {
                    print('clear search history');
                  }),
              _buildButton(
                  text: 'MANAGE HISTORY',
                  function: () {
                    print('Manage History');
                  }),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return SmallVideoCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
