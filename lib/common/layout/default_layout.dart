import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';

// 모든 레이아웃에 적용하고 하는 것들
// 필요시 staefull로 바꾸어서 적용하고 싶은 화면에서 아래의 폴더로 한번 감싸고 원래 구현하려던 것을 아래에 넣는다.
// api나 연결 같은 것들
//
class DefaultLayout extends StatelessWidget {
  final child;
  final backgroundcolor;
  final String? title;
  final PreferredSizeWidget? appbar;
  final Widget? bottomNavigationBar;

  const DefaultLayout(
      {Key? key,
      required this.child,
      this.backgroundcolor,
      this.bottomNavigationBar,
      this.title,
      this.appbar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor ?? Colors.white,
      appBar: appbar ?? checktitle(),
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }

  AppBar? checktitle() {
    if (title == null) {
      return null;
    } else {
      return AppBar(
        foregroundColor: Colors.black,
        backgroundColor: PRIMARY_COLOR,
        elevation: 0,
        title: Text(
          title!,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
        ),
      );
    }
  }
}
