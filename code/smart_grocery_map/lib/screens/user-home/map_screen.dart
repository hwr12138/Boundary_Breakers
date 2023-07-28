import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_grocery_map/global.dart';
import 'package:smart_grocery_map/models/map_item.dart';
import 'package:smart_grocery_map/screens/user-home/components/cashier.dart';
import 'package:smart_grocery_map/screens/user-home/components/entry_exit.dart';
import 'package:smart_grocery_map/screens/user-home/components/vertical_bar.dart';
import 'package:http/http.dart' as http;
import 'package:smart_grocery_map/screens/user-home/routeplanningdistance.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  List<MapItem> items = [];
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 3), () {
    //   setState(() {
    //     items = MapItem.getDummyList();
    //   });
    // });
    _getShoppingList();
  }



  void _getShoppingList() async {
    try {
      // Url: http://10.0.2.2:8000/api/customer/getItemLocations
      Uri uri = Uri.parse('http://10.0.2.2:8000/api/customer/getItemLocations');
      var request = http.MultipartRequest('POST', uri)
        ..fields['customer_username'] = Globals.customerUsername;
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        Map dataMap = jsonDecode(response.body);
        dataMap['customer_items'].forEach((element) {
          MapItem mapItem = MapItem(
            productName: element['product_name'],
            aisle: element['aisle'],
            position: element['shelf'],
          );
          items.add(mapItem);
        });
        setState(() {});
      } else {
        Map dataMap = jsonDecode(response.body);
        _showSnackbar(dataMap['status']);
      }
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  Widget createRowItem(var quantity, var itemName, var position) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey[300],
              child: Text(
                quantity,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 10,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey[300],
              child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        itemName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        position,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    )
                  ]
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  List<MapItem> _getSpecifiedAisleItems(int aisle) {
    if (items.isNotEmpty) {
      List<MapItem> list =
          items.where((element) => element.aisle == aisle).toList();
      if (list.isNotEmpty) {
        return list;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {

    var routeplanningDistanceButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 50.0,
          height: 42.0,
          onPressed: () => /*routeplanningdistance(),*/ Navigator.push(context, new MaterialPageRoute(builder: (context) => new routeplanningdistance())),
          color: Colors.green,
          child: Text('distance', style: TextStyle(color: Colors.white, fontSize: 10),),
        ),
      ),
    );

    var count=5;

    Widget showRow() {
      if(count>=5){
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              createRowItem(" 12 Items ", " Walmart Super Center","You are currently here "),
              SizedBox(height: 10.0,),
              createRowItem(" 8 Items ", " Costco Wholesale",""),
              SizedBox(height: 10.0,),
              createRowItem(" 4 Items ", " Target", ""),
              SizedBox(height: 10.0,),
              createRowItem(" 1 Item ", " Panera Bakery",""),
            ],
          ),
        );
      }
      if(count>=4){
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              createRowItem(" 8 Items ", " Costco Wholesale","You are currently here "),
              SizedBox(height: 10.0,),
              createRowItem(" 4 Items ", " Target", ""),
              SizedBox(height: 10.0,),
              createRowItem(" 1 Item ", " Panera Bakery",""),
            ],
          ),
        );
      }
      if(count>=3){
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              createRowItem(" 4 Items ", " Target", "You are currently here "),
              SizedBox(height: 10.0,),
              createRowItem(" 1 Item ", " Panera Bakery",""),
            ],
          ),
        );
      }
      if(count>=2){
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
              createRowItem(" 1 Item ", " Panera Bakery","You are currently here "),
            ],
          ),
        );
      }
      else{
        return Container(
          child: Column(
            children: [
              SizedBox(height: 10.0,),
            ],
          ),
        );
      }

    }

    void bottomModal(context) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: const EdgeInsets.all(24), // here is it
            child: Column(
              children: [
                showRow(),
                TextButton(
                  onPressed: () {
                    count=count-1;
                  },
                  child: Text('Next Store'),
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    textStyle: const TextStyle(fontSize: 16),
                    backgroundColor: Colors.yellow,
                    alignment: Alignment.center,
                    minimumSize: Size(double.infinity, 30),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    var routebyStoreButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 50.0,
          height: 42.0,
          onPressed: () {
            bottomModal(context);
          },
          color: Colors.green,
          child: Text('stores', style: TextStyle(color: Colors.white, fontSize: 10),),
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                      child: VerticalBar(items: _getSpecifiedAisleItems(1)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(2)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(3)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(4)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(5)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(6)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                  ],
                ),
                // Center(
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 30.0),
                //     child: SizedBox(
                //       height: 250.0,
                //       child: ListView.builder(
                //         shrinkWrap: true,
                //         scrollDirection: Axis.horizontal,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: 6,
                //         itemBuilder: (context, index) {
                //           return const Padding(
                //             padding: EdgeInsets.only(right: 30.0),
                //             child: VerticalBar(),
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(7)),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      child: VerticalBar(items: _getSpecifiedAisleItems(8)),
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
                    // Column(
                    //   children: const [
                    //     FruitsAndVeg(text: 'Veg', color: Colors.lightGreen),
                    //     FruitsAndVeg(text: 'Fruits', color: Colors.pink),
                    //   ],
                    // ),
                    // const Cashier(),
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
                      routeplanningDistanceButton,
                      routebyStoreButton,
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
      ),
    );
  }
}
