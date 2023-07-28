import 'package:flutter/material.dart';
import '../auxiliary/custLogout.dart';
import 'package:http/http.dart' as http;
import '/global.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfilePage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();

  void _validate() {
    if (_username.text.isEmpty ||
        _firstName.text.isEmpty ||
        _lastName.text.isEmpty ||
        _email.text.isEmpty) {
      _showSnackbar('Please fill in the required boxes');
    } else {
      _doLogin();
    }
  }

  void _doLogin() async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/customer/editprofile');
      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = Globals.customerUsername
        ..fields['newusername'] = _username.text
        ..fields['firstname'] = _firstName.text
        ..fields['lastname'] = _lastName.text
        ..fields['email'] = _email.text;

      if (_password.text.isNotEmpty) {
        request.fields['newpassword'] = _password.text;
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        // Success
        _showSnackbar('Success');
        Globals.customerUsername = _username.text;
      } else {
        _showSnackbar(
            jsonDecode(await response.stream.bytesToString())['status']);
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

  Widget descriptionInput(TextEditingController c) {
    return TextFormField(
      controller: c,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      //initialValue: 'Please input to revise',
      decoration: InputDecoration(
          hintText: 'Please input to revise',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
  }

  Widget createSaveButton() {
    return (TextButton(
      onPressed: _validate,
      child: Text('Save'),
      style: TextButton.styleFrom(
        primary: Colors.black,
        textStyle: const TextStyle(fontSize: 20),
      ),
    ));
  }

  bool firstEdit = true;
  String _oldUsername = "";
  String _oldFirstname = "";
  String _oldLastname = "";
  String _oldEmail = "";

  Future _getProfile() async {
    try {
      var uri = Uri.parse('http://10.0.2.2:8000/api/customer/getprofile');
      var request = http.MultipartRequest('POST', uri)
        ..fields['customer_username'] = Globals.customerUsername;
      var response = await request.send();
      if (response.statusCode == 200) {
        var profile =
            jsonDecode(await response.stream.bytesToString())['profile'];

        setState(() {
          firstEdit = false;
          _oldUsername = profile['username'];
          _oldFirstname = profile['firstname'];
          _oldLastname = profile['lastname'];
          _oldEmail = profile['email'];
        });
      } else {
        _showSnackbar('Failed to get profile');
      }
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (firstEdit) {
      _getProfile();
    }

    _username.text = _oldUsername;
    _firstName.text = _oldFirstname;
    _lastName.text = _oldLastname;
    _email.text = _oldEmail;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Text(
              'Username: (*)',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: 4.0,
            ),
            descriptionInput(_username),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Password:',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: 4.0,
            ),
            descriptionInput(_password),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'First Name: (*)',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: 4.0,
            ),
            descriptionInput(_firstName),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Last Name: (*)',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: 4.0,
            ),
            descriptionInput(_lastName),
            SizedBox(
              height: 8.0,
            ),
            Text(
              'Email: (*)',
              style: TextStyle(color: Colors.black54, fontSize: 18.0),
            ),
            SizedBox(
              height: 4.0,
            ),
            descriptionInput(_email),
            SizedBox(
              height: 4.0,
            ),
            createSaveButton(),
          ],
        ),
      ),
    );
  }
}
