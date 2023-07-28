import 'package:flutter/material.dart';
import '/res/colors.dart';

const kHintTextStyle = TextStyle(
  color: Colors.white54,
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

final kBoxDecorationStyle = BoxDecoration(
  color: navblue,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
