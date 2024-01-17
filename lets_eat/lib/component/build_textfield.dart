import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final bool isPW;
  final FormFieldSetter<String> onSaved;

  const BuildTextField({
    required this.icon,
    required this.hintText,
    required this.isPW,
    required this.onSaved,
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
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: (String? val) {
          if (val == null || val.isEmpty) {
            return '값을 입력해주세요.';
          }
          if (!widget.isPW) {
            // email 포멧
            if (!RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+")
                .hasMatch(val)) {
              return '유효하지 않은 이메일입니다.';
            }
          }
          return null;
        },
        obscureText: widget.isPW ? !pwVisible : false,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            borderSide: BorderSide.none,
          ),
          prefixIcon: widget.icon,
          hintText: widget.hintText,
          filled: true,
          fillColor: Color(0xffefefef),
          suffixIcon: widget.isPW
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
      width: 300.0,
    );
  }
}
