import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import '/global.dart';

Future<Commodities> getCompanyItems(var input, var which, var type) async {
  try {
    var request;
    if (which == null) {
      which = "all";
    }
    if (which == "all") {
      var uri = Uri.parse('http://10.0.2.2:8000/api/company/inventory/query');
      request = http.MultipartRequest('POST', uri)
        ..fields['company_username'] = input;
    } else {
      var uri = Uri.parse(
          'http://10.0.2.2:8000/api/company/inventory/search_item_by_type');
      request = http.MultipartRequest('POST', uri);
      request.fields['company_username'] = input;
      request.fields['product_type'] = type;
    }
    http.Response response =
    await http.Response.fromStream(await request.send());
    if (response.statusCode == 201) {
      var itemNameList = [];
      var priceList = [];
      for (var item in jsonDecode(response.body)['items']) {
        itemNameList.add(item[2]);
        priceList.add(item[5]);
      }
      return Commodities.construct(itemNameList, priceList);
    } else {
      throw Exception('Fail to load items');
    }
  } catch (e) {
    throw Exception(e.toString);
  }
}

class Commodities {
  List<dynamic> itemNameList;
  List<dynamic> priceList;

  Commodities({
    required this.itemNameList,
    required this.priceList,
  });

  factory Commodities.construct(
      List<dynamic> itemNameList, List<dynamic> priceList) {
    return Commodities(
      itemNameList: itemNameList,
      priceList: priceList,
    );
  }
}

class StoreItems extends StatefulWidget {
  StoreItems({Key? key}) : super(key: key);

  @override
  StoreItemsState createState() => StoreItemsState();
}

class StoreItemsState extends State<StoreItems> {
  var which;
  var type;
  var toggle = false;
  var companyUsername = "hello";
  late Future<Commodities> futureList;
  List<dynamic> quantityList = [];

  void change(var w, var t, var tog) {
    setState(() {
      if (toggle == true) {
        which = w;
        type = t;
        toggle = false;
      } else if (toggle == false) {
        which = "all";
        type;
        toggle = true;
      }
    });
  }

  void _addItems(var itemName, var i) async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/customer/usercart/modify');
      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = Globals.customerUsername
        ..fields['company_username'] = companyUsername
        ..fields['product_name'] = itemName
        ..fields['quantity'] = quantityList[i].toString();
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

  void _bottomModal(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          padding: const EdgeInsets.all(24), // here is it
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "fruit", toggle);
                        },
                        child: Text("Fruits", textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "vegtables", toggle);
                        },
                        child: Center(
                          child: Text(
                            "Vegtables",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "meat", toggle);
                        },
                        child: Text("Meat", textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "dairy", toggle);
                        },
                        child: Center(
                          child: Text(
                            "Dairy",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "grains", toggle);
                        },
                        child: Text("Grains", textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      height: 40,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      color: Colors.grey[300],
                      height: 40,
                      child: TextButton(
                        onPressed: () {
                          change("some", "test", toggle);
                        },
                        child: Center(
                          child: Text(
                            "Other",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  
  Widget createRowItem(int quantity, var itemName, int i) {
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
                      quantityList[i]++;
                      _addItems(itemName, i);
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
                      if (quantityList[i] >= 1) {
                        quantityList[i]--;
                        _addItems(itemName, i);
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

  Widget build(BuildContext context) {
    this.futureList =
        getCompanyItems(companyUsername, which, type).whenComplete(() {
          setState(() => _body = body());
        });
    _body = body();
    return _body;
  }

  Widget body() {
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
                      "What We Sell",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                a
                  ..add(
                    TextButton(
                      onPressed: () {
                        _bottomModal(context);
                      },
                      child: Text('View a Category'),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        textStyle: const TextStyle(fontSize: 16),
                        backgroundColor: Colors.yellow,
                        alignment: Alignment.center,
                        minimumSize: Size(double.infinity, 30),
                      ),
                    ),
                  );
                for (int i = 0; i < snapshot.data!.priceList.length; i++) {
                  a
                    ..add(SizedBox(
                      height: 10.0,
                    ));
                  quantityList.add(0);
                  a
                    ..add(createRowItem(this.quantityList[i],
                        snapshot.data!.itemNameList[i], i));
                }
                return Column(children: a);
              }
              return const CircularProgressIndicator();
            }),
      ),
    );
  }
}
