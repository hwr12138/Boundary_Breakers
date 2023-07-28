import 'package:flutter/material.dart';
import '/screens/auxiliary/CompanyLogout.dart';
import '../../company_signup_screen.dart';
import '/res/colors.dart';
import '/res/styles.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {

    final DescriptionBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'You can see your description for your store here!',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final avg_reviewBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '5(out of 5)',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final open_timeBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '9:00AM',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final close_timeBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '5:00PM',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final contact_phoneBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '111-111-1111',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final contact_email = FlatButton(
      child: Text('Email:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
      onPressed: () {},
    );

    final contact_emailBox = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'yourstorename@gmail.com',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    final websiteBox= TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'https://www.yourstorewebsite.com',
      decoration: InputDecoration(
          hintText: 'To revise it: ',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0)
          )
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        Container(
          color: Colors.white,
        ),
        SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(height: 70.0),
              Text('Your description for the store:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              DescriptionBox,
              SizedBox(height: 8.0,),
              Text('Your store is estiamted by customers:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              avg_reviewBox,
              SizedBox(height: 8.0,),
              Text('Your store opens at:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              open_timeBox,
              SizedBox(height: 8.0,),
              Text('Your store closes at:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              close_timeBox,
              SizedBox(height: 8.0,),
              Text('Phone number:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              contact_phoneBox,
              SizedBox(height: 8.0,),
              Text('Email:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              contact_emailBox,
              SizedBox(height: 8.0,),
              Text('website:', style: TextStyle(color: Colors.black54, fontSize: 18.0),),
              SizedBox(height: 4.0,),
              websiteBox,
              SizedBox(height: 40.0,),
            ])
        ),

        new Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            title: Text('Profile:'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back_ios, color: Colors.grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),),
      ]),
    );
  }
}