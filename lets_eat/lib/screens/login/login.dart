
import 'package:flutter/material.dart';
import 'package:lets_eat/utils/api_login.dart';

import '../../widgets/build_button.dart';
import '../../widgets/build_textfield.dart';

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
          child: SizedBox(
            width: double.infinity,
            height: height,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  const SizedBox(
                    width: 300.0,
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
                  ),
                  Column(
                    children: [
                      _Email(
                        onSaved: (String? val) {
                          email = val;
                        },
                        nextFocusNode: focusNode,
                      ),
                      const SizedBox(height: 16.0),
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
                        backgroundColor: const Color.fromARGB(255, 187, 157, 211),
                        textColor: Colors.white,
                        pressedTextColor: Colors.black,
                        text: '로그인',
                        onPressed: tryLogin,
                      ),
                      BuildButton(
                        width: 300.0,
                        backgroundColor: const Color.fromARGB(255, 164, 111, 206),
                        textColor: Colors.white,
                        pressedTextColor: Colors.black,
                        text: '회원가입',
                        onPressed: () {
                          Navigator.of(context).pushNamed('/signup');
                        },
                      ),
                      BuildButton(
                        width: 300,
                        backgroundColor: const Color.fromARGB(255, 187, 157, 211),
                        textColor: Colors.white,
                        pressedTextColor: Colors.black,
                        text: 'test',
                        onPressed: (() =>
                            Navigator.of(context).pushNamed('/home')),
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
      loginAPI(email, password, context);
    } else {
      debugPrint('포맷에러');
    }
  }
}

class _Email extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FocusNode nextFocusNode;

  const _Email({
    required this.onSaved,
    required this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hintText: 'Email',
      icon: const Icon(
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
  });

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hintText: 'Password',
      icon: const Icon(
        Icons.lock_outline,
        color: Color(0xff7e7d7d),
      ),
      textType: 1,
      onSaved: onSaved,
      focusNode: focusNode,
    );
  }
}
