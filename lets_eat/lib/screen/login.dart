import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 300.0,
              height: 300.0,
            ),
            _BuildTextField(
              hintText: "Email",
              icon: Icon(
                Icons.email_outlined,
                color: Color(0xff7e7d7d),
              ),
            ),
            SizedBox(height: 8.0),
            _BuildTextField(
              hintText: "Password",
              icon: Icon(
                Icons.lock_outline,
                color: Color(0xff7e7d7d),
              ),
            ),
            SizedBox(height: 8.0),
            _BuildButton(
              width: 300.0,
              backgroundColor: Colors.orange,
              textColor: Colors.white,
              pressedTextColor: Colors.black,
              text: '로그인',
            ),
            _BuildButton(
              width: 300.0,
              backgroundColor: Colors.orangeAccent,
              textColor: Colors.white,
              pressedTextColor: Colors.black,
              text: '회원가입',
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildTextField extends StatelessWidget {
  final Icon icon;
  final String hintText;

  const _BuildTextField({
    required this.icon,
    required this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xffefefef),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: icon,
            hintText: hintText,
          ),
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

  const _BuildButton({
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.pressedTextColor,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: () {},
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
