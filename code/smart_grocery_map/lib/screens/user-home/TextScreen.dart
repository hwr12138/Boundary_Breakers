import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {

  final String s;
  final List info;
  const TextScreen({Key? key, required this.s, required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:  AppBar(
        title: Text("searching result page:"),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child:
            Text("Here, you will look at the information of:    "+s+"\n"
                +"the company for it is:    "+info[1]+"\n"
            +"the prodcut name is:    "+info[2]+"\n"
            +"the product type is:    "+info[3]+"\n"
            +"description is:    "+info[4]+"\n"
            +"price is:    "+info[5].toString()+"\n"
            +"location is in Aisle: "+info[6].toString()+" Shelf: "+info[7].toString()),
          )
      ),
    );
  }
}