import 'package:flutter/material.dart';
import 'company_inventory_screen.dart';
import '../../company-home/nav_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CompanyDeleteItem extends StatelessWidget {
  var id;

  CompanyDeleteItem({Key? key, this.id}) : super(key: key);

  void delete(var id) async {
    var uri =
        Uri.parse('http://10.0.2.2:8000/api/company/inventory/delete');
    var request = http.MultipartRequest('POST', uri)
      ..fields['id'] = id.toString();
    http.Response response =
        await http.Response.fromStream(await request.send());
  }

  /* void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  } */

  @override
  Widget build(BuildContext context) {
    final info = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "Do you confirm to delete this item and its information?",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );

    final DeleteButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            delete(this.id);
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => NavBar()));
          },
          color: Colors.yellow,
          child: Text(
            'Delete',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    final UndoButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => NavBar()));
          },
          color: Colors.yellow,
          child: Text(
            'Undo',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 4.0,),
            info,
            SizedBox(height: 4.0,),
            DeleteButton,
            SizedBox(width: 50,),
            UndoButton,
          ],
        ),
      ),
    );
  }
}
