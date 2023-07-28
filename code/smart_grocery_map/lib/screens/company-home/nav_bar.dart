import 'package:flutter/material.dart';
import 'store_screen.dart';
import 'user_screen.dart';
import 'package:smart_grocery_map/screens/company/inventory/company_inventory_screen.dart';

class NavBar extends StatefulWidget {
  NavBar ({Key? key}) : super(key: key);

  @override
  NavBarState createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
  int _pageNumIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget widget = Container();
    switch (_pageNumIndex) {
      case 0:
        widget = StoreScreen();
        break;
      case 1:
        widget = CompanyInventoryScreen();
        break;
      case 2:
        widget = UserScreen();
        break;
    }
    return Scaffold(
      bottomNavigationBar: _bottomTab(),
      body: widget,
    );
  }
  
  Widget _bottomTab() {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40), 
        topRight: Radius.circular(40), 
        bottomLeft: Radius.circular(40),
        bottomRight: Radius.circular(40),
      ),
      child: BottomNavigationBar(
        currentIndex: _pageNumIndex,
        onTap: (int index) => setState(() => _pageNumIndex = index),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        backgroundColor: Colors.grey[850],
        showUnselectedLabels: false,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.local_convenience_store_rounded),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add_check_rounded),
            label: 'Inventory',),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Company',),


          ],
      ),
    );
  }
}
