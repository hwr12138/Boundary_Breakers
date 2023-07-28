import 'package:flutter/material.dart';
import '/screens/auth/welcome_screen.dart';

class CustLogout extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    final thanks=Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Thanks for using our app!',
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );

    final info=Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        "You have logged out at:",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );

    //DateTime dateTime= DateTime.now();
    String year = DateTime.now().year.toString();
    String month = DateTime.now().month.toString();
    String day = DateTime.now().day.toString();
    String hour = DateTime.now().hour.toString();
    String minute = DateTime.now().minute.toString();
    String second= DateTime.now().second.toString();
    final timeInfo= TextFormField(
      keyboardType: TextInputType.datetime,
      autofocus: false,
      initialValue: "$year - $month - $day, $hour:$minute:$second",
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final LogInButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: (){
            Navigator.push(context, new MaterialPageRoute(builder: (context) => new WelcomeScreen()));
          },
          color: Colors.green,
          child: Text('Log In', style: TextStyle(color: Colors.white, fontSize: 20.0),),
        ),
      ),
    );

    final body=Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
              color: Colors.white,
      ),
      child: Column(children: <Widget>[
        thanks, info, timeInfo, LogInButton
      ],),
    );

    return Scaffold(
      body: body,
    );
  }
}