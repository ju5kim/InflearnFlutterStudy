import 'dart:convert';
import 'dart:io';
import 'dart:ui' hide Codec;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';
import 'package:flutter_study_feat_infrun/common/const/data.dart';
import 'package:flutter_study_feat_infrun/common/layout/default_layout.dart';
import 'package:flutter_study_feat_infrun/common/view/root_tab.dart';

import '../../common/component/CustomTextFormField.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userId = '';
  String userPw = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final simulatorIp = "127.0.0.1:3000";
    final emulatorIp = "10.0.2.2:3000";
    final ip;

    if (Platform.isIOS) {
      ip = simulatorIp;
    } else if (Platform.isAndroid) {
      ip = emulatorIp;
    } else {
      ip = simulatorIp;
    }

    return DefaultLayout(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          child: Column(
            // 컬럼의 크로스니까 row 이고 여기서 스트레치
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Title(),
              const SizedBox(
                height: 16.0,
              ),
              _SubTitle(),
              Image(
                image: AssetImage("asset/img/misc/logo.png"),

                /// 화면 사이즈를 가지고 와서 해당 조건에 맞게 적용
                /// MediaQuery.of(context).size             //앱 화면 크기 size  Ex> Size(360.0, 692.0)
                /// MediaQuery.of(context).size.height      //앱 화면 높이 double Ex> 692.0
                /// MediaQuery.of(context).size.width       //앱 화면 넓이 double Ex> 360.0
                /// MediaQuery.of(context).devicePixelRatio //화면 배율    double Ex> 4.0
                /// MediaQuery.of(context).padding.top      //상단 상태 표시줄 높이 double Ex> 24.0
                ///  window.physicalSize                    //앱 화면 픽셀 크기 size Ex> Size(1440.0, 2768.0)
                width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              CustomTextFormField(
                hintText: "이메일을 입력하세요.",
                obscureText: false,
                onChanged: (String inputvalue) {
                  userId = inputvalue;
                },
              ),
              const SizedBox(
                height: 16.0,
              ),
              CustomTextFormField(
                hintText: "비밀번호를 입력하세요.",
                obscureText: true,
                onChanged: (String inputvalue) {
                  userPw = inputvalue;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  /// 코덱 및 base64 사용해서
                  /// http header에다가 authorization 셋업 해서 request
                  final rawUserString = "$userId:$userPw";
                  Codec<String, String> base64Codec = utf8.fuse(base64);
                  String convertedbasictoken =
                      base64Codec.encode(rawUserString);
                  print("http://$ip/auth/login");
                  final respon = await dio.post(
                    "http://$ip/auth/login",
                    options: Options(headers: {
                      "authorization": "Basic $convertedbasictoken"

                      /// 후 더더더덜 소문자로 basic 써서 30분 넘게 해매다니....
                    }),
                  );
                  print(respon.data);
                  final temp_access_token = respon.data['accessToken'];
                  print("access = " + temp_access_token);
                  final temp_refresh_token = respon.data['refreshToken'];
                  print("refresh = " + temp_refresh_token);
                  await SECURE_STORAGE.write(
                      key: ACCESS_TOKEN_LOCAL_KEY, value: temp_access_token);

                  await SECURE_STORAGE.write(
                      key: REFRESH_TOKEN_LOCAL_KEY, value: temp_refresh_token);
                  //로그인이 에러가 나지 않았다면 실행될 화면전환 코드
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => RootTab()),
                  );

                  print(respon.data);
                },
                style: ElevatedButton.styleFrom(primary: PRIMARY_COLOR),
                child: Text("로그인"),
              ),
              TextButton(
                onPressed: () async {},
                style: TextButton.styleFrom(primary: Colors.black),
                child: Text("회원가입"),
              )
            ],
          ),
        ),
      ),
    ));
  }
}

class _Title extends StatelessWidget {
  const _Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "환영합니다.!",
      style: TextStyle(
          fontFamily: "NotoSans", fontSize: 32, fontWeight: FontWeight.w500),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      " 안녕하세요. \"여기뭐야\"에 오신 것을 \n환영합니다.\n 오늘도 안전하고 즐거운 하루 되세요.:) ",
      style: TextStyle(
          fontFamily: "NotoSans",
          fontWeight: FontWeight.w200,
          fontSize: 20,
          color: BODY_TEXT_COLOR),
    );
  }
}
