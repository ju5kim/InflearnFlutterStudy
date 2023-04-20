import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  const CustomTextFormField({Key? key, this.hintText}) : super(key: key);
  //생성자 생성시 객체로 감싸고 넣어야 위젯을 사용할 때 양식으로 값이 나온다.

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      onChanged: (inputedvalue) {},
      maxLines: 1,
      cursorColor: PRIMARY_COLOR, //인풋에 깜빡이는 커서의 색깔
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20), hintText: "이메일을 입력하세요"),
    );
  }
}
