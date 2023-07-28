import 'package:flutter/material.dart';
import 'change_store.dart';
import 'store_items.dart';

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
                flex: 6,
                child: Text(
                  "Walmart Super Center",
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context, new MaterialPageRoute(builder: (context) => new ChangeStore()));
                  },
                  icon: Icon(Icons.create_sharp),
                  label: Text(
                    "Change Store",
                    style: const TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    onPrimary: Colors.yellow[700],
                    shadowColor: Colors.transparent,
                    alignment: Alignment(0,0),
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
                /* boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black54,
                      blurRadius: 15.0,
                      offset: Offset(3.0, 0.75)
                  ),
                ], */
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Browse This Store's Items",
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
              Navigator.push(context, new MaterialPageRoute(builder: (context) => new StoreItems()));
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
          createRowItem("", "Orange", "Isle 1, Shelf 1"),
          SizedBox(height: 10.0,),
          createRowItem("", "Apple", "Isle 1, Shelf 1"),
          SizedBox(height: 10.0,),
          createRowItem("", "Banana", "Isle 5, Shelf 4"),
          SizedBox(height: 10.0,),
          createRowItem("", "Bread", "Isle 1, Shelf 2"),
          SizedBox(height: 10.0,),
          createRowItem("", "Popcorn", "Isle 4, Shelf 5"),
          SizedBox(height: 10.0,),
          createRowItem("", "Chocolate", "Isle 4, Shelf 2"),
        ],
      ),
    );
  }
}