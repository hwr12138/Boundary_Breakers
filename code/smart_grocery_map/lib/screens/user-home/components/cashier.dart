import 'package:flutter/material.dart';

class Cashier extends StatelessWidget {
  const Cashier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.0,
      color: Colors.yellow,
      alignment: Alignment.center,
      child: const Text(
        'Cashier',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
