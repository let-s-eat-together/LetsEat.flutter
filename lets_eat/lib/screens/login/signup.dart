import 'package:flutter/material.dart';
import 'package:lets_eat/utils/api_signup.dart';
import '../../widgets/build_button.dart';
import '../../widgets/build_textfield.dart';

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
                  const Column(
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
                      const SizedBox(height: 8.0),
                      _Password(
                        onSaved: (String? val) {
                          password = val;
                        },
                        focusNode: focusNode1,
                        nextFocusNode: focusNode2,
                      ),
                      const SizedBox(height: 8.0),
                      _Nickname(
                        onSaved: (String? val) {
                          nickname = val;
                        },
                        focusNode: focusNode2,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      BuildButton(
                        width: 300.0,
                        backgroundColor: Color.fromARGB(255, 164, 111, 206),
                        textColor: Colors.white,
                        pressedTextColor: Colors.black,
                        text: '시작하기',
                        onPressed: trySignup,
                      ),
                      BuildButton(
                        width: 300.0,
                        backgroundColor: Color.fromARGB(255, 187, 157, 211),
                        textColor: Colors.white,
                        pressedTextColor: Colors.black,
                        text: '돌아가기',
                        onPressed: () {
                          Navigator.of(context).pop();
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

  void trySignup() {
    if (formKey.currentState == null) {
      return;
    }

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      signupAPI(email, password, nickname, context);
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
      hintText: '이메일 주소',
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
  final FocusNode nextFocusNode;

  const _Password({
    required this.onSaved,
    required this.focusNode,
    required this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hintText: '비밀번호를 입력해주세요',
      icon: const Icon(
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
  });

  @override
  Widget build(BuildContext context) {
    return BuildTextField(
      hintText: '닉네임을 입력해주세요',
      icon: const Icon(
        Icons.star,
        color: Color(0xff7e7d7d),
      ),
      textType: 2,
      onSaved: onSaved,
      focusNode: focusNode,
    );
  }
}
