import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../company_signup_screen.dart';
import '/res/colors.dart';
import '/res/styles.dart';
import 'components/auth_button.dart';
import 'package:http/http.dart' as http;
import 'components/text_input_field.dart';
import '../company-home/nav_bar.dart';
import 'package:smart_grocery_map/global.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  IconData suffixIcon = Icons.visibility_off;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _validate() {
    if (_usernameController.text.isEmpty && _passwordController.text.isEmpty) {
      _showSnackbar('Please enter your username and password');
    } else if (_usernameController.text.isEmpty) {
      _showSnackbar('Please enter your username');
    } else if (_passwordController.text.isEmpty) {
      _showSnackbar('Please enter your password');
    } else {
      _doLogin();
    }
  }

  void _doLogin() async {
    try {
      // Url: http://localhost:8000/api/company/login
      // For emulator: http://10.0.2.2:8000/api/company/login
      // var uri = Uri.parse('http://localhost:8000/api/company/login');
      var uri = Uri.parse('http://10.0.2.2:8000/api/company/login');
      var request = http.MultipartRequest('POST', uri)
        ..fields['username'] = _usernameController.text
        ..fields['password'] = _passwordController.text;
      http.Response response =
          await http.Response.fromStream(await request.send());
      if (response.statusCode == 200) {
        // Success
        //_showSnackbar('Success');
        Globals.companyUsername = _usernameController.text;
        Navigator.push(
            context, new MaterialPageRoute(builder: (context) => new NavBar()));
      } else if (response.statusCode == 400) {
        _showSnackbar('username/password incorrect');
      } else {
        _showSnackbar('Failed to login');
      }
    } catch (e) {
      _showSnackbar(e.toString());
    }
  }

  Icon backIconChoice() {
    if (kIsWeb) {
      return const Icon(Icons.arrow_back);
    } else {
      if (Platform.isAndroid) {
        return const Icon(Icons.arrow_back);
      } else {
        return const Icon(Icons.arrow_back_ios);
      }
    }
  }

  void _navigateAndDisplaySelection() async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CompanySignUpScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    if (result != "back") {
      _showSnackbar(result);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                navblue,
                appAccent,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Company Sign In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      TextInputField(
                        controller: _usernameController,
                        label: 'Username',
                        hintText: 'Enter your Username',
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 30.0),
                      TextInputField(
                        controller: _passwordController,
                        label: 'Password',
                        hintText: 'Enter your Password',
                        textInputAction: TextInputAction.done,
                        icon: Icons.lock,
                        obscureText:
                            suffixIcon == Icons.visibility_off ? true : false,
                        suffixIcon: suffixIcon,
                        onEyePressed: () {
                          setState(() {
                            suffixIcon = suffixIcon == Icons.visibility
                                ? Icons.visibility_off
                                : Icons.visibility;
                          });
                        },
                      ),
                      _buildForgotPasswordBtn(),
                      AuthButton(
                        onPressed: _validate,
                        text: 'Sign in',
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
                Positioned(
                  child: SafeArea(
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: backIconChoice(),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {},
        padding: const EdgeInsets.only(right: 0.0),
        child: const Text(
          'Forgot Password?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don\'t have an Account?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        TextButton(
          onPressed: _navigateAndDisplaySelection,
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
