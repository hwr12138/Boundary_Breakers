import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smart_grocery_map/company_create_item/company_create_item_button.dart';
import 'package:smart_grocery_map/res/colors.dart';
import 'package:http/http.dart' as http;

//import 'components/inventory_item.dart';
import './company_delete_item.dart';
import 'package:smart_grocery_map/global.dart';

Future<Commodities> _getData() async {
  // Url: http://localhost:8000/api/company/inventory/query
  // For emulator: http://10.0.2.2:8000/api/company/inventory/query
  var uri =
      Uri.parse('http://10.0.2.2:8000/api/company/inventory/query');
  var request = http.MultipartRequest('POST', uri)
    ..fields['company_username'] = Globals.companyUsername;
  http.Response response =
      await http.Response.fromStream(await request.send());
  if (response.statusCode == 201) {
    var itemIdList = [];
    var itemNameList = [];
    var priceList = [];
    for (var item in jsonDecode(response.body)['items']) {
      itemIdList.add(item[0]);
      itemNameList.add(item[2]);
      priceList.add(item[5]);
    }
    return Commodities.construct(itemIdList, itemNameList, priceList);
  } else {
    throw Exception('Fail to load items');
  }
  /* if (response.statusCode == 201) {
    print('Success----------->\n ${response.body}');
    return response.body;
  } else {
    Map dataMap = jsonDecode(response.body);
    print('Error----------->\n ${response.body}');
    _showSnackbar(dataMap['status']);
    return "error";
  } */
}

class Commodities {
  List<dynamic> itemIdList;
  List<dynamic> itemNameList;
  List<dynamic> priceList;

  Commodities({
    required this.itemIdList,
    required this.itemNameList,
    required this.priceList,
  });

  factory Commodities.construct(
      List<dynamic> itemIdList, List<dynamic> itemNameList, List<dynamic> priceList) {
    return Commodities(
      itemIdList: itemIdList,
      itemNameList: itemNameList,
      priceList: priceList,
    );
  }
}

class CompanyInventoryScreen extends StatefulWidget {
  const CompanyInventoryScreen({Key? key}) : super(key: key);

  @override
  _CompanyInventoryScreenState createState() => _CompanyInventoryScreenState();
}

class _CompanyInventoryScreenState extends State<CompanyInventoryScreen> {
  late Future<Commodities> futureList;

  Widget createItem(var id, var price, var itemName) {
    return Container(
      decoration: BoxDecoration(
        /* image: const DecorationImage(
          image: NetworkImage(''),
          fit: BoxFit.cover,
        ), */
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: const [
        //   BoxShadow(color: Colors.grey, spreadRadius: 1, blurRadius: 3)
        // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
              color: navblue.withOpacity(0.9),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    itemName,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 2.0),
                  GestureDetector(
                    child: Container(
                      width: 300,
                      height: 20,
                      child: const Icon(Icons.delete_outline),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyDeleteItem(id: id)));
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Widget _body = Container();

  Widget build(BuildContext context) {
    this.futureList =
        _getData().whenComplete(() {
          setState(() => _body = body());
        });
    _body = body();
    return _body;
  }

  Widget body() {
    return Scaffold(
      /* extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ), */
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: navblue,
        centerTitle: true,
        title: const Text('Title here'),
      ),
      floatingActionButton: const CompanyCreateItemFloatingActionButton(),
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
                      "Items in Your Store",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                for (int i = 0; i < snapshot.data!.priceList.length; i++) {
                  a
                    ..add(
                      SizedBox(
                        height: 50.0,
                      )
                    );
                  a
                    ..add(
                      GestureDetector(
                        onTap: () {},
                        child: createItem(snapshot.data!.itemIdList[i], snapshot.data!.priceList[i], snapshot.data!.itemNameList[i]),
                      ),
                    );
                }
                return SingleChildScrollView(child: Column(children: a));
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: navblue,
        centerTitle: true,
        title: const Text('Title here'),
      ),
      floatingActionButton: const CompanyCreateItemFloatingActionButton(),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 12),
        child: GridView.builder(
            itemCount: 10,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.85,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: const InventoryItem(),
              );
            }),
      ),
    );
  } */