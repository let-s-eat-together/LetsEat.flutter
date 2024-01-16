import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? password;

  String? token;
  int? userNumber;
  String? username;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 로고 or 인사말 넣기
                  SizedBox(
                    width: 300.0,
                    height: 300.0,
                  ),
                  _Email(
                    onSaved: (String? val) {
                      email = val;
                    },
                  ),
                  SizedBox(height: 8.0),
                  _Password(
                    onSaved: (String? val) {
                      password = val;
                    },
                  ),
                  SizedBox(height: 8.0),
                  _BuildButton(
                    width: 300.0,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                    text: '로그인',
                    onPressed: tryLogin,
                  ),
                  _BuildButton(
                    width: 300.0,
                    backgroundColor: Colors.orangeAccent,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                    text: '회원가입',
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void tryLogin() {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      bool isLoginSuccess = true;
      print('로그인 api 진행');
      if (isLoginSuccess) {
        print('로그인 성공');
        Navigator.of(context).pushNamed('/planlist');
      } else {
        print('로그인 실패');
        // id & pw 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
        print('잠시후 다시 시도해 주세요');
      }
    } else {
      print('포맷에러');
    }
  }
}

class _Email extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Email({
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _BuildTextField(
      hintText: "Email",
      icon: Icon(
        Icons.email_outlined,
        color: Color(0xff7e7d7d),
      ),
      isPW: false,
      onSaved: onSaved,
    );
  }
}

class _Password extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Password({
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _BuildTextField(
      hintText: "Password",
      icon: Icon(
        Icons.lock_outline,
        color: Color(0xff7e7d7d),
      ),
      isPW: true,
      onSaved: onSaved,
    );
  }
}

class _BuildTextField extends StatefulWidget {
  final Icon icon;
  final String hintText;
  final bool isPW;
  final FormFieldSetter<String> onSaved;

  const _BuildTextField({
    required this.icon,
    required this.hintText,
    required this.isPW,
    required this.onSaved,
    super.key,
  });

  @override
  State<_BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<_BuildTextField> {
  bool pwVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        onSaved: widget.onSaved,
        validator: (String? val) {
          if (val == null || val.isEmpty) {
            return '값을 입력해주세요';
          }
          if (widget.isPW) {
            // pw 포맷
          } else {
            // email 포멧
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

class _BuildButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final Color pressedTextColor;
  final String text;
  final VoidCallback onPressed;

  const _BuildButton({
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.pressedTextColor,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            backgroundColor,
          ),
          foregroundColor:
              MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return pressedTextColor;
            }
            return textColor;
          }),
        ),
        child: Text(
          text,
        ),
      ),
    );
  }
}
