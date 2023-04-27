import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_study_feat_infrun/user/view/login_screen.dart';

import 'common/component/CustomTextFormField.dart';
import 'common/view/SplashScreen.dart';

void main() {
  runApp(MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      // 머터리얼앱에서 폰트테마 설정
      //  pubspec.yaml 에 폰트 등록 필수
      theme: ThemeData(fontFamily: "NotoSans"),
      debugShowCheckedModeBanner: false, //이건 디버그모양 배너 삭제
      home: SplashScreen(),
    );
  }
}
