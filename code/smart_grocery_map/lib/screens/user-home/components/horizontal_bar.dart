import 'package:flutter/material.dart';

class HorizontalBar extends StatelessWidget {
  final Color color;
  const HorizontalBar({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 120.0,
      color: color,
    );
  }
}
