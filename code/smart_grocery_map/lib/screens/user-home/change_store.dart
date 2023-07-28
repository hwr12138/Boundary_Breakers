import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChangeStore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 28.0,
          vertical: 80.0,
        ),
        child: Column(
          
        ),
      ),
    );
  }
}