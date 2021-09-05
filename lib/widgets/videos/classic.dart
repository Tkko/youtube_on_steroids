import 'package:youtube_on_steroids/app/app.dart';

class Classic extends StatelessWidget {
  String _title = 'Lorem ipsum dolor sit amet, consectetur';
  String _metaContent = 'Lorem ipsum dolor sit amet';
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            height: 303.h,
            child: Column(
              children: [
                Container(
                  height: 211.h,
                  color: Colors.red,
                ),
                Container(
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
                        child: Image.asset('assets/images/user.png'),
                        borderRadius: BorderRadius.circular(23.0),
                      ),
                    ),
                    ),
                    title: Text(_title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),),
                    // title: RichText(
                    //   overflow: TextOverflow.ellipsis,
                    //   text: TextSpan(
                    //     style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    //     text: title,
                    //   )
                    // ),
                    subtitle: Text(_metaContent),
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
        },
      ),
    );
  }
}
