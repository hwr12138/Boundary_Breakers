import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const AuthButton({
    Key? key,
    required this.text,
    this.color = Colors.white,
    this.textColor = const Color(0xFF527DAA),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        elevation: 5.0,
        onPressed: onPressed,
        padding: const EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
