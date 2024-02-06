import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final Color pressedTextColor;
  final String text;
  final VoidCallback onPressed;

  const BuildButton({
    required this.width,
    required this.backgroundColor,
    required this.textColor,
    required this.pressedTextColor,
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
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
