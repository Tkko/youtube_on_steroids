import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/app/constants.dart';
import 'package:youtube_on_steroids/utils/helper.dart';

class BasicVideoFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pushNamed(AppRoutes.VIDEO);
          },
          child: Container(
            width: double.infinity,
            child: Image.network(
                'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.black.withOpacity(0.8),
            ),
            margin: const EdgeInsets.only(right: 15.0, bottom: 10.0),
            padding: const EdgeInsets.all(2),
            child: Text('${Helper.durationDisplay(Duration(hours: 5))}',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
