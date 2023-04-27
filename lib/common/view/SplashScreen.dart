import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/common/const/data.dart';
import 'package:flutter_study_feat_infrun/common/layout/default_layout.dart';
import 'package:flutter_study_feat_infrun/common/view/root_tab.dart';
import 'package:flutter_study_feat_infrun/user/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkedToken();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundcolor: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: AssetImage("asset/img/logo/logo.png"),
              width: MediaQuery.of(context).size.width / 2,
              alignment: Alignment.center,
            ),
            CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 16.0,
            ),
          ],
        ),
      ),
    );
  }

  void checkedToken() async {
    final readStorageAceessToken =
        await SECURE_STORAGE.read(key: ACCESS_TOKEN_LOCAL_KEY);
    print(readStorageAceessToken);
    final readStorageReflashToken =
        await SECURE_STORAGE.read(key: REFRESH_TOKEN_LOCAL_KEY);
    print(readStorageReflashToken);
    final ip;

    if (Platform.isIOS) {
      ip = simulatorIp;
    } else if (Platform.isAndroid) {
      ip = emulatorIp;
    } else {
      ip = simulatorIp;
    }
    try {
      final respon = await dio.post(
        "http://$ip/auth/token",
        options: Options(headers: {
          "authorization": "Bearer $readStorageReflashToken"

          /// 후 더더더덜 소문자로 basic 써서 30분 넘게 해매다니....
        }),
      );
      //위에서 갱신만 하고 있었지 새로발급 받은 access 토큰을 저장하지 않았다.
      //
      print("splash화면에서 리플레쉬 토큰 전송 후 받은 access token :::" +
          respon.data.toString());
      await SECURE_STORAGE.write(
          key: ACCESS_TOKEN_LOCAL_KEY, value: respon.data['accessToken']);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
    } catch (e) {
      print(e);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }

    // if (readStorageReflashToken == null || readStorageAceessToken == null) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    // } else {
    //   Navigator.pushAndRemoveUntil(context,
    //       MaterialPageRoute(builder: (_) => RootTab()), (route) => false);
    // }
  }
}
