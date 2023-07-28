import 'package:flutter/material.dart';
import 'package:smart_grocery_map/screens/user-home/components/horizontal_bar.dart';

class EntryExit extends StatelessWidget {
  final Text text;
  final Color barColor;
  const EntryExit({
    Key? key,
    required this.text,
    required this.barColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      width: 120.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HorizontalBar(color: barColor),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: text,
          ),
          HorizontalBar(color: barColor),
        ],
      ),
    );
  }
}
