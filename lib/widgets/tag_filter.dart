import 'package:youtube_on_steroids/app/app.dart';

class TagFilter extends StatelessWidget {
  /// That is here for only demonstration purpose!
  List<String> tags = ['All', 'Music', 'Game', 'Food', 'Animal', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 48.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 5),
        itemCount: tags.length,
        itemBuilder: (context, index) {
          return Container(
            constraints: BoxConstraints(
              minWidth: 45.0.w,
            ),
            margin: EdgeInsets.only(left: 10),
            child: InkWell(
              onTap: () => print("clicked"),
              child: FittedBox(
                fit: BoxFit.none,
                child: Text('${tags[index]}', style: index == 0
                    ? TextStyle(color: Colors.white)
                    : TextStyle(), // Only for demonstration purpose!
                ),
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(width: 2.0, color: index == 0 ? Colors.grey[600]: Colors.grey[300]), // Only for demonstration purpose!
                color: index == 0
                    ? Colors.grey[600]
                    : Color(0xF3F3F6FF), // Only for demonstration purpose!
                borderRadius: BorderRadius.all(Radius.circular(25.0))
            ),
          );
        },
      ),
    );
  }
}
