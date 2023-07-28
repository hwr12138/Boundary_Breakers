import 'package:flutter/material.dart';

Row makeTitleAndBackButton(String titleText, BuildContext context) {
  return Row(children: [
    IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: () {
        Navigator.pop(context, "back");
      },
    ),
    Expanded(
      flex: 1,
      child: Text(
        titleText,
        style: titleTextStyle,
        textAlign: TextAlign.center,
      ),
    )
  ]);
}

const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  );
