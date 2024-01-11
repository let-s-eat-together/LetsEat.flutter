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
            Container(
              width: 300.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orange,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black;
                    }
                    return Colors.white;
                  }),
                ),
                child: Text(
                  '로그인',
                ),
              ),
            ),
            Container(
              width: 300.0,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.orangeAccent,
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.black;
                    }
                    return Colors.white;
                  }),
                ),
                child: Text(
                  '회원가입',
                ),
              ),
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
