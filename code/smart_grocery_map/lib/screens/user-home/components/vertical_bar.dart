import 'package:flutter/material.dart';
import 'package:smart_grocery_map/models/map_item.dart';

class VerticalBar extends StatelessWidget {
  final List<MapItem> items;
  final Color color;
  const VerticalBar({
    Key? key,
    this.color = Colors.brown,
    required this.items,
  }) : super(key: key);

  bool _getItemAtPosition(int position) {
    if (items.isNotEmpty) {
      List<MapItem> list =
          items.where((element) => element.position == position).toList();
      if (list.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50.0,
          color: color,
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: _getItemAtPosition(1) ? Colors.yellow : color,
          ),
        ),
        Container(
          height: 50.0,
          color: color,
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: _getItemAtPosition(2) ? Colors.yellow : color,
          ),
        ),
        Container(
          height: 50.0,
          color: color,
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: _getItemAtPosition(3) ? Colors.yellow : color,
          ),
        ),
        Container(
          height: 50.0,
          color: color,
          alignment: Alignment.center,
          child: CircleAvatar(
            radius: 4.0,
            backgroundColor: _getItemAtPosition(4) ? Colors.yellow : color,
          ),
        ),
      ],
    );
  }
}
