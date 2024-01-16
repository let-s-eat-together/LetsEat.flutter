import 'package:flutter/material.dart';

import '../component/build_button.dart';
import '../component/build_textfield.dart';

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
                  BuildButton(
                    width: 300.0,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                    text: '로그인',
                    onPressed: tryLogin,
                  ),
                  BuildButton(
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
    return BuildTextField(
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
    return BuildTextField(
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
