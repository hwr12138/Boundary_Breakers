import 'package:flutter/material.dart';
import 'package:smart_grocery_map/screens/company/inventory/company_inventory_screen.dart';
import 'nav_bar.dart';

class StoreScreen extends StatelessWidget {
  static String tag="home_page";

  Widget createRowItem(var quantity, var itemName, var position) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey[300],
              child: Text(
                quantity,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.grey[300],
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Text(
                      itemName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
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

  @override
  Widget build(BuildContext context) {
    //var c = const Colors.grey[300];
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: 28.0,
        vertical: 80.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(Icons.edit_location_alt_outlined),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  "Walmart Super Center",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          MaterialButton(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 160,
              decoration: BoxDecoration(
                //color: Colors.white,
                image: DecorationImage(
                  image:AssetImage("assets/images/Grocery1.jpg"), 
                  fit:BoxFit.cover
                ),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Items in Your Store",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            onPressed:(){
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new CompanyInventoryScreen()));
              //setState(() => NavBarState._pageNumIndex = 1);
            }
          ),
          SizedBox(height: 10.0,),
          Text(
            "Items Found Here",
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0,),
          createRowItem("1x", " Bagels | Kirkland Signature", "Isle 2, Shelf 65"),
          SizedBox(height: 10.0,),
          createRowItem("2x", " 2L Soda | Sprite", "Isle 1, Shelf 13"),
          SizedBox(height: 10.0,),
          createRowItem("2x", " Chicken | Kirkland Signature", "Isle 5, Shelf 5"),
          SizedBox(height: 10.0,),
          createRowItem("1x", " Socks | Kirkland Signature", "Isle 3, Shelf 35"),
        ],
      ),
    );
  }
}