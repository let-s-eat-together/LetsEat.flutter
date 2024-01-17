import 'package:flutter/material.dart';
import 'package:lets_eat/screen/login/login.dart';

import '../../component/build_button.dart';
import '../../component/build_textfield.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? password;
  String? username;

  int? userNumber;

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
                  SizedBox(
                    height: 150.0,
                  ),
                  Text(
                    'Hey, there',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
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
                  _Nickname(
                    onSaved: (String? val) {
                      password = val;
                    },
                  ),
                  SizedBox(height: 50.0),
                  BuildButton(
                    width: 300.0,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                    text: '시작하기',
                    onPressed: trySignup,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void trySignup() {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      bool isSignupSuccess = true;
      print('회원가입 api 진행');
      if (isSignupSuccess) {
        print('회원가입 성공');
        print('이어서 로그인 api 진행');
        // email, password로 tryAPI_Login()
        Navigator.of(context).pushNamed('/home');
      } else {
        print('회원가입 실패');
        // 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
        print('~가 틀렸습니다');
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
      hintText: "이메일 주소",
      icon: Icon(
        Icons.email_outlined,
        color: Color(0xff7e7d7d),
      ),
      textType: 0,
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
      hintText: "비밀번호를 입력해주세요",
      icon: Icon(
        Icons.lock_outline,
        color: Color(0xff7e7d7d),
      ),
      textType: 1,
      onSaved: onSaved,
    );
  }
}

class _Nickname extends StatelessWidget {
  final FormFieldSetter<String> onSaved;

  const _Nickname({
    required this.onSaved,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hintText: "닉네임을 입력해주세요",
      icon: Icon(
        Icons.star,
        color: Color(0xff7e7d7d),
      ),
      textType: 2,
      onSaved: onSaved,
    );
  }
}
