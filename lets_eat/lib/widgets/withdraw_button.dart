import 'package:flutter/material.dart';

class WithdrawButton extends StatelessWidget {
  const WithdrawButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 4), // Adjust the left padding as needed
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            // Implement withdraw logic here
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.transparent, // Text color
          ),
          child: const Text(
            '탈퇴하기',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
