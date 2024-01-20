import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../component/build_button.dart';
import '../../component/build_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey();

  String? email;
  String? password;

  FocusNode focusNode = FocusNode();

  String? token;
  int? userNumber;
  String? username;

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
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '밥 한번 같이\n먹어볼까요? :)',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    width: 300.0,
                  ),
                  Column(
                    children: [
                      _Email(
                        onSaved: (String? val) {
                          email = val;
                        },
                        nextFocusNode: focusNode,
                      ),
                      SizedBox(height: 16.0),
                      _Password(
                        onSaved: (String? val) {
                          password = val;
                        },
                        focusNode: focusNode,
                      ),
                    ],
                  ),
                  Column(
                    children: [
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
                  SizedBox(height: bottomInset),
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
      loginAPI();
    } else {
      print('포맷에러');
    }
  }

  void loginAPI() async {
    final url = Uri.parse('');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'id': email!,
        'password': password!,
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      // token, userNumber, username 넘겨주기
      Navigator.of(context).pushNamed('/home');
    } else {
      print('로그인 실패');
      // id & pw 값이 틀려서 실패 or 다른 요인으로 실패 구분하기
      print('id or pw가 틀렸습니다');
      print('잠시후 다시 시도해 주세요');
      throw Exception('Failed to load data');
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
      hintText: "Email",
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

  const _Password({
    required this.onSaved,
    required this.focusNode,
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
      textType: 1,
      onSaved: onSaved,
      focusNode: focusNode,
    );
  }
}
