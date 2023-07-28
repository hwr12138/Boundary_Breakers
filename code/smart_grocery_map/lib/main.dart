import 'package:flutter/material.dart';
import '/screens/auth/welcome_screen.dart';
//import '/screens/home/NavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Grocery',
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}
