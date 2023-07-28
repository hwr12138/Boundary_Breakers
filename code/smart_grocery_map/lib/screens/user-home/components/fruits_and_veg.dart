import 'package:flutter/material.dart';

class FruitsAndVeg extends StatelessWidget {
  final String text;
  final Color color;
  const FruitsAndVeg({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 140.0,
      color: color,
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
