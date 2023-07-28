import 'package:flutter/material.dart';
import 'package:smart_grocery_map/screens/user-home/map_screen.dart';
import 'package:smart_grocery_map/screens/user-home/nav_bar.dart';
import 'package:smart_grocery_map/screens/user-home/routeplanningdistancepaint.dart';
import 'package:smart_grocery_map/models/map_item.dart';
import 'package:smart_grocery_map/screens/user-home/components/cashier.dart';
import 'package:smart_grocery_map/screens/user-home/components/entry_exit.dart';
import 'package:smart_grocery_map/screens/user-home/components/vertical_bar.dart';
import 'package:smart_grocery_map/screens/user-home/shopping_list_screen.dart';

class routeplanningdistance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var backButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 100.0,
          height: 42.0,
          onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => new NavBar())),
          color: Colors.green,
          child: Text('Move back to Map', style: TextStyle(color: Colors.white, fontSize: 15.0),),
        ),
      ),
    );

    final body=SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),

              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: VerticalBar(items: []),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Expanded(
                    child: Container(),
                  ),

                  const Expanded(
                    flex: 4,
                    child: Cashier(),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  EntryExit(
                    text: Text(
                      'Entry',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    barColor: Colors.green,
                  ),
                  backButton,
                  EntryExit(
                    text: Text(
                      'Exit',
                      style: TextStyle(color: Colors.black, fontSize: 30.0),
                    ),
                    barColor: Colors.red,
                  ),

                ],
              ),
            ],

          ),
        ),
      ),
    );


      return Scaffold(
        backgroundColor: Colors.white,
        body: CustomPaint(
          foregroundPainter: routeplanningdistancepaint(),
          child: Center(
            child: body,
            ),
          ),
        );
  }

}