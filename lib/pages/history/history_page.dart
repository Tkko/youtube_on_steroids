import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/cubits/history_cubit.dart';
import 'package:youtube_on_steroids/widgets/video_cards/small_video_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage();

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getHistory(context);
  }

  void getHistory(BuildContext context) {
    final cubit = BlocProvider.of<HistoryCubit>(context);
    cubit.getHistory('watch_history');
  }

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
          BlocConsumer<HistoryCubit, HistoryState>(listener: (context, state) {
            if (state is HistoryError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }, builder: (context, state) {
            if (state is HistoryInitial) {
              return Text('init');
            } else if (state is HistoryLoading) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.red[700],
              ));
            } else if (state is HistoryLoaded) {
              print(state.videos);
              return Expanded(
                child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return SmallVideoCard();
                  },
                ),
              );
            } else if (state is HistoryConverted) {
              return Center(
                child: Text(state.videos.first),
              );
            } else
              return Center(
                child: Text(state.toString()),
              );
          })
        ],
      ),
    );
  }
}
