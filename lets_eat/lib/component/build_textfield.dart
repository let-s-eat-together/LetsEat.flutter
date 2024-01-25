import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final int textType;
  final FormFieldSetter<String> onSaved;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  const BuildTextField({
    required this.icon,
    required this.hintText,
    required this.textType,
    required this.onSaved,
    this.focusNode,
    this.nextFocusNode,
    super.key,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  bool pwVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.0,
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: (String? val) {
          if (val == null || val.isEmpty) {
            return '값을 입력해주세요.';
          }
          // textType = { email : 0, password : 1, nickname : 2, }
          if (widget.textType == 0) {
            // email 포멧
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                .hasMatch(val)) {
              return '유효하지 않은 이메일입니다.';
            }
          } else if (widget.textType == 1) {
            // password 포멧
            if (val.length < 8) {
              return '최소 8자리 입니다.';
            }
            if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#%&*~]).+$').hasMatch(val)) {
              return '영문,숫자,특수문자(!@#%&*~)를 포함해야 합니다!';
            }
          } else if (widget.textType == 2) {
            // nickname 포멧
            if (val.length > 12) {
              return '닉네임이 너무 길어요!';
            }
            if (!RegExp(r'^[a-zA-Z0-9가-힣]+$').hasMatch(val)) {
              return '올바르지 않은 닉네임 입니다.';
            }
          }
          return null;
        },
        focusNode: widget.focusNode,
        autofocus: true,
        obscureText: widget.textType == 1 ? !pwVisible : false,
        cursorColor: Colors.black,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (_) =>
            FocusScope.of(context).requestFocus(widget.nextFocusNode),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.icon,
          hintText: widget.hintText,
          filled: true,
          fillColor: Color(0xffefefef),
          suffixIcon: widget.textType == 1
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      pwVisible = !pwVisible;
                    });
                  },
                  icon: Icon(
                    pwVisible
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
