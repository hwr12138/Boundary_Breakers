import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:smart_grocery_map/global.dart';

List itemlist=[];

class routeplanningdistancepaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    void getitemList() async {
      try {
        Uri uri = Uri.parse('http://10.0.2.2:8000/api/customer/getPath');
        var request = http.MultipartRequest('POST', uri)
          ..fields['customer_username'] = Globals.customerUsername;
        http.Response response = await http.Response.fromStream(await request.send());
        if (response.statusCode == 200) {
          itemlist = jsonDecode(response.body)['customer_items'];
        }else {
          throw Exception('Fail to load items');
        }
      } catch (e) {
        throw Exception(e.toString);
      }
    }


    getitemList();
    var paint = Paint();
    paint.strokeWidth = 5;
    paint.style = PaintingStyle.stroke;
    paint.color = Colors.blue;

    var path = Path();

    int shelfmax = 4;
    int aislemax = 6;
    double aislebetweendistance = 65;
    double shelfbetweendistance = 50;

    int curraisle = itemlist[0][0];
    int currshelf = itemlist[0][1];

    //start from entry point
    path.moveTo(50, 585);

    if (curraisle <= 6 ){
      path.lineTo(shelfbetweendistance, 295);
      path.lineTo((curraisle.toDouble()) * aislebetweendistance - 15, shelfmax * 55 + 75);
    }

    //first 6 aisle
    var item;
    for (item in itemlist) {
      if (item[0]<=6) {
        if (curraisle >= aislemax){
          path.lineTo(((curraisle-aislemax).toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance+230);
          path.lineTo(((curraisle-aislemax).toDouble()) * aislebetweendistance - 5, shelfmax * shelfbetweendistance + 90);
          path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + 90);
          path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + shelfbetweendistance);
        }
        //if have interact with other aisle
        if ((item[0] - curraisle) > 1) {
          //in bigger shelf
          if (item[1] > 2) {
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance);
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, shelfmax * shelfbetweendistance + 90);
            path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + 90);
            path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + shelfbetweendistance);
          }
          //in smaller shelf
          if (item[1] <= 2) {
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance);
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, 0 * shelfbetweendistance + 75);
            path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, 0 * shelfbetweendistance + 75);
            //path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, 0 * shelfbetweendistance + shelfbetweendistance);
          }
        }
        path.lineTo(
            (item[0].toDouble()) * aislebetweendistance - 15, (item[1].toDouble()) * shelfbetweendistance + shelfbetweendistance);
        curraisle = item[0];
        currshelf = item[1];
      } else{
        //7-8 aisle go to 1-6 aisle
        if ((item[0] - curraisle) > 1) {
          //in bigger shelf
          if (item[1] > 2) {
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance+230);
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + 90+230);
            path.lineTo(((item[0]-aislemax).toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + 90+230);
            path.lineTo(((item[0]-aislemax).toDouble()) * aislebetweendistance - 15, shelfmax * shelfbetweendistance + shelfbetweendistance+230);
          }
          //in smaller shelf
          if (item[1] <= 2) {
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance);
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance+200);
            path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, 0 * shelfbetweendistance + 75+230);
            path.lineTo(((item[0]-aislemax).toDouble()) * aislebetweendistance - 15, 0 * shelfbetweendistance + 75+230);
            //path.lineTo((item[0].toDouble()) * aislebetweendistance - 15, 0 * shelfbetweendistance + shelfbetweendistance);
          }
        }

        path.lineTo(
            ((item[0]-aislemax).toDouble()) * aislebetweendistance - 15, (item[1].toDouble()) * shelfbetweendistance + shelfbetweendistance+230);
        curraisle = item[0];
        currshelf = item[1];
      }
    }
    //end at cashier and then go to exit
    if (curraisle <= 6){
      path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, (currshelf.toDouble()) * shelfbetweendistance + shelfbetweendistance);
      path.lineTo((curraisle.toDouble()) * aislebetweendistance - 5, shelfmax * shelfbetweendistance + 90);
    }else{
      path.lineTo(((curraisle-aislemax).toDouble()) * aislebetweendistance - 5, shelfmax * shelfbetweendistance + 75+230);
    }

    path.lineTo(355, 410);
    path.lineTo(355, 585);
    //path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

