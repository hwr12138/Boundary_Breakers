import 'package:flutter/material.dart';
import '/screens/auth/welcome_screen.dart';

class CompanyLogout extends StatelessWidget{

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
        "You have logged out！",
        style: new TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    );

    final LogInButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
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
              color: Colors.white
      ),
      child: Column(children: <Widget>[
        thanks, info, LogInButton
      ],),
    );

    return Scaffold(
      body: body,
    );
  }

}