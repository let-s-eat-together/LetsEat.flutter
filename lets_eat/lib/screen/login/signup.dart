import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
  String? nickname;

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  int? userNumber;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: height,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Column(
                    children: [
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
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      _Email(
                        onSaved: (String? val) {
                          email = val;
                        },
                        nextFocusNode: focusNode1,
                      ),
                      SizedBox(height: 8.0),
                      _Password(
                        onSaved: (String? val) {
                          password = val;
                        },
                        focusNode: focusNode1,
                        nextFocusNode: focusNode2,
                      ),
                      SizedBox(height: 8.0),
                      _Nickname(
                        onSaved: (String? val) {
                          nickname = val;
                        },
                        focusNode: focusNode2,
                      ),
                    ],
                  ),
                  BuildButton(
                    width: 300.0,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                    pressedTextColor: Colors.black,
                    text: '시작하기',
                    onPressed: trySignup,
                  ),
                  SizedBox(height: bottomInset),
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
      singupAPI();
    } else {
      print('포맷에러');
    }
  }

  void singupAPI() async {
    final url = Uri.parse('');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, String> body = {
      'id': email!,
      'password': password!,
      'username': nickname!,
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        // email, password로 loginAPI 시도
        loginAPI();
      } else {
        print('회원가입 실패');
        // 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
        print('~가 틀렸습니다');
        print('잠시후 다시 시도해 주세요');
        throw Exception('Failed to load data');
      }
    } catch(e) {
      print('http post 실패');
    }
  }

  void loginAPI() async {
    final url = Uri.parse('');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    final Map<String, String> body = {
      'id': email!,
      'password': password!,
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        // token, userNumber, username 넘겨주기
        Navigator.of(context).pushNamed(
          '/home',
          arguments: {
            'token': data['token'],
            'userNumber': data['userNumber'],
            'username': data['username'],
          },
        );
      } else {
        print('로그인 실패');
        // id & pw 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
        print('id or pw가 틀렸습니다');
        print('잠시후 다시 시도해 주세요');
        throw Exception('Failed to load data');
      }
    } catch(e) {
      print('http post 실패');
    }
  }
}

class _Email extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FocusNode nextFocusNode;

  const _Email({
    required this.onSaved,
    required this.nextFocusNode,
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
      nextFocusNode: nextFocusNode,
    );
  }
}

class _Password extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  const _Password({
    required this.onSaved,
    required this.focusNode,
    required this.nextFocusNode,
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
      focusNode: focusNode,
      nextFocusNode: nextFocusNode,
    );
  }
}

class _Nickname extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FocusNode focusNode;

  const _Nickname({
    required this.onSaved,
    required this.focusNode,
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
      focusNode: focusNode,
    );
  }
}
