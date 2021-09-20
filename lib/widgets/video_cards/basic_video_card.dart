import 'package:youtube_on_steroids/app/app.dart';
import 'package:youtube_on_steroids/widgets/video_frames/basic_video_frame.dart';

class BasicVideoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 303.h,
      child: Column(
        children: [
          Container( // video frame
            height: 211.h,
            child: BasicVideoFrame(),
          ),
          Container( // video description
            width: double.infinity,
            constraints: BoxConstraints(
              maxHeight: 92.h,
            ),
            child: ListTile(
              leading: InkWell(
                onTap: () { print('clicked');},
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 50,
                    maxHeight: 50,
                    minWidth: 50,
                    maxWidth: 50,
                  ),
                  child: ClipRRect(
                    child: Image.asset('assets/images/userv2.jpg'),
                    borderRadius: BorderRadius.circular(23.0),
                  ),
                ),
              ),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
                  text: 'Here is title',
                ),
              ),
              subtitle: Text('Author name' + " · " + '200K'),
              trailing: Transform.translate(
                offset: Offset(0,-10),
                child: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
