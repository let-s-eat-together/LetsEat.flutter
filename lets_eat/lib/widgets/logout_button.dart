import 'package:flutter/material.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      // Adjust the left padding as needed
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            // Implement logout logic here
          },
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, backgroundColor: Colors.transparent, // Text color
          ),
          child: const Text(
            '로그아웃',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
