import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final VoidCallback onPressed;
  const MyButton({
    super.key,
    required this.buttonName,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: buttonColor,
      child: Text(
        buttonName,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
