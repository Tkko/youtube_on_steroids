import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/pages/history/history_page.dart';
import 'package:youtube_on_steroids/pages/home/home_page.dart';
import 'package:youtube_on_steroids/widgets/app_bar/custom_app_bar.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage();

  @override
  _WrapperPageState createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              _selectedIndex == 0
                  ? CustomAppBar(
                      hasFilters: true,
                      isFloating: true,
                      isSnapped: true,
                      isPinned: false,
                    )
                  : CustomAppBar(
                      hasFilters: false,
                      isFloating: true,
                      isSnapped: true,
                      isPinned: false,
                    )
            ];
          },
          body: [
            HomePage(),
            HistoryPage(),
          ][_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
