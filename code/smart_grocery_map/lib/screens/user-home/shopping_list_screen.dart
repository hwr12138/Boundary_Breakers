import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '/global.dart';
import 'package:smart_grocery_map/screens/user-home/filter_by_item.dart';

Future<Commodities> getCompanyItems(var input) async {
  try {
    var uri = Uri.parse('http://10.0.2.2:8000/api/customer/usercart/query');
    var request = http.MultipartRequest('POST', uri)
      ..fields['username'] = Globals.customerUsername;
    http.Response response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 201) {
      var itemNameList = [];
      var quantityList = [];
      for (var item in jsonDecode(response.body)['items']) {
        itemNameList.add(item[3]);
        quantityList.add(item[4]);
      }
      return Commodities.construct(itemNameList, quantityList);
    } else {
      throw Exception('Fail to load items');
    }
  } catch (e) {
    throw Exception(e.toString);
  }
}

class Commodities {
  List<dynamic> itemNameList;
  //List<dynamic> priceList;
  List<dynamic> quantityList;

  Commodities({
    required this.itemNameList,
    //required this.priceList,
    required this.quantityList,
  });

  factory Commodities.construct(List<dynamic> itemNameList/* , List<dynamic> priceList */, List<dynamic> quantityList) {
    return Commodities(
      itemNameList: itemNameList,
      //priceList: priceList,
      quantityList: quantityList,
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  ShoppingListScreen({Key? key, this.title = 'grocery list'}) : super(key: key);

  final String title;

  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  var companyUsername = "hello";
  late Future<Commodities> futureList;

  void _addItems(var itemName, var quantity, var i) async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/customer/usercart/modify');
      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = Globals.customerUsername
        ..fields['company_username'] = companyUsername
        ..fields['product_name'] = itemName
        ..fields['quantity'] = quantity.toString();
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // Success
        _showSnackbar('Success');
      } else if (response.statusCode == 400) {
        _showSnackbar('username/password incorrect');
      } else {
        _showSnackbar('Failed to login');
      }
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget createRowItem(var quantity, var itemName, int i) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 30,
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text(
                quantity.toString(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          flex: 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 30,
              alignment: Alignment.center,
              color: Colors.grey[300],
              child: Text(
                itemName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5.0,
        ),
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 30,
              color: Colors.grey[300],
              child: Row(children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      quantity++;
                      _addItems(itemName, quantity, i);
                    },
                    child: Text('+'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      if (quantity > 1) {
                        quantity--;
                        _addItems(itemName, quantity, i);
                      } else if (quantity == 1) {
                        _addItems(itemName, -1, i);
                      }
                    },
                    child: Text('-'),
                    style: TextButton.styleFrom(
                      primary: Colors.black,
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body = Container();

  @override
  Widget build(BuildContext context) {
    this.futureList = getCompanyItems(companyUsername).whenComplete(() {
      setState(() => _body = body());
    });
    _body = body();
    return _body;
  }

  Widget body() {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 2,bottom: 2,left: 16),
          child: Container(
            height: 35,
            width:  MediaQuery.of(context).size.width-64,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)
            ),
            child: InkWell(
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 10,right: 10),
                      child: Icon(Icons.search,color: Colors.black)),
                  Text("search",style: TextStyle(color: Colors.grey,fontSize: 15),)
                ],
              ),
              onTap: (){
                showSearch(context: context,delegate: filter_by_item());
              },
            ),
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 28.0,
          vertical: 100.0,
        ),
        child: FutureBuilder<Commodities>(
          future: futureList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var a = <Widget>[];
              a
                ..add(
                  Text(
                    "In Your Cart",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              for (int i = 0; i < snapshot.data!.itemNameList.length; i++) {
                try {
                  a..add(SizedBox(height: 10.0,));
                  a..add(createRowItem(snapshot.data!.quantityList[i], snapshot.data!.itemNameList[i], i));
                } catch (e) {
                  throw Exception("err");
                }
              }
              return Column(children: a);
            }
            return const CircularProgressIndicator();
          }
        ),
      ),
    );
  }
}
