import 'package:youtube_on_steroids/app/app.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  const AppCard({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340.w,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 4.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.w),
        color: context.theme.cardColor,
      ),
      child: child,
    );
  }
}
