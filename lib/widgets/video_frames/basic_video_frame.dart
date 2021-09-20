import 'package:youtube_on_steroids/app/app.dart';

class BasicVideoFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () async{

          },
          child: Container(
            width: double.infinity,
            child:  Image.network('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_960_720.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity, alignment: Alignment.center),
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
            child: Text('10:20', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
