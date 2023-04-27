import 'package:flutter/material.dart';
import 'package:flutter_study_feat_infrun/common/const/CustomColors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {Key? key,
      this.hintText,
      this.errorText,
      required this.obscureText,
      required this.onChanged})
      : super(key: key);

  //생성자 생성시 객체로 감싸고 넣어야 위젯을 사용할 때 양식으로 값이 나온다.

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );

    return TextFormField(
      // 비밀 번호 입력시 땡땡으로 가리는 히든표
      obscureText: obscureText,
      autofocus: false,
      // 타입을 확인하고 생성자로 넘겨 네임드 파라미터로 받게 한다.
      onChanged: onChanged,
      maxLines: 1,
      // 인풋에 깜박이는 커서의 색깔
      cursorColor: PRIMARY_COLOR,
      // 텍스트 폼필드(inputText의 대부부은 decoration 파라미터에서 꾸민다.
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: TextStyle(
          color: BODY_TEXT_COLOR,
          fontSize: 14.0,
        ),
        // border 파라미터는 별도 변수로 빼서 생성했고
        // 변수로 뺀 객채를 copyWith()함수르 써서 복사하면서
        // 복사 객체의 내부 값들은 다시 커스터마이징 했다.
        border: baseBorder,
        focusedBorder: baseBorder.copyWith(
            borderSide: baseBorder.borderSide.copyWith(color: PRIMARY_COLOR)),
        enabledBorder: baseBorder,
        fillColor: INPUT_BG_COLOR,
        filled: true,
      ),
    );
  }
}
