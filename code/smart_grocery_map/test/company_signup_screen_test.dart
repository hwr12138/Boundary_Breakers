import 'package:flutter/material.dart';
import 'package:smart_grocery_map/company_signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Smart Grocery Map - Company Sign Up Screen',
      home: NavBar(),
    );
  }
}

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: CompanySignUpScreen(),
    );
  }
}