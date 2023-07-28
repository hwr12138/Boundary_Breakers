import 'package:flutter/material.dart';
import 'package:smart_grocery_map/res/title_bar.dart';
import '/res/colors.dart';
import 'package:http/http.dart' as http;

// Define a custom Form widget.
class CustomerSignUpScreen extends StatefulWidget {
  const CustomerSignUpScreen({Key? key}) : super(key: key);

  @override
  CustomerSignUpScreenState createState() {
    return CustomerSignUpScreenState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class CustomerSignUpScreenState extends State<CustomerSignUpScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  static const TextStyle titleTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 28.0,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle formFieldTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );
  static TextStyle formFieldHintTextStyle = TextStyle(
    color: Colors.grey[400],
    fontSize: 12.0,
  );
  static const TextStyle formFieldLabelTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);

    return Scaffold(
      body: Container(
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
        height: queryData.size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: queryData.size.width * 0.05,
                vertical: queryData.size.height * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  makeTitleAndBackButton("Customer Signup", context),

                  // Wrap IconButton and TitleBar in a thing
                  // Add TextFormFields and ElevatedButton here.
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.person, color: Colors.white),
                      hintStyle: formFieldHintTextStyle,
                      errorStyle: formFieldHintTextStyle,
                      labelStyle: formFieldLabelTextStyle,
                      hintText: 'Enter your preferred username',
                      labelText: 'Username *',
                    ),
                    style: formFieldTextStyle,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: _obscureText,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.password, color: Colors.white),
                      hintStyle: formFieldHintTextStyle,
                      errorStyle: formFieldHintTextStyle,
                      labelStyle: formFieldLabelTextStyle,
                      hintText: 'Enter your password',
                      labelText: 'Password *',
                      suffixIcon: IconButton(
                          icon: checkObscure(_obscureText), onPressed: _toggle),
                    ),
                    style: formFieldTextStyle,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Please enter at least 8 characters to create '
                            'a strong password';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.email, color: Colors.white),
                        hintStyle: formFieldHintTextStyle,
                        errorStyle: formFieldHintTextStyle,
                        labelStyle: formFieldLabelTextStyle,
                        hintText: 'Enter your email address',
                        labelText: 'Email *',
                      ),
                      style: formFieldTextStyle,
                      // The validator receives the text that the user has entered.
                      validator: validateEmail),

                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.face, color: Colors.white),
                      hintStyle: formFieldHintTextStyle,
                      errorStyle: formFieldHintTextStyle,
                      labelStyle: formFieldLabelTextStyle,
                      hintText: 'Enter the First Name',
                      labelText: 'First Name *',
                    ),
                    style: formFieldTextStyle,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.storefront, color: Colors.white),
                      hintStyle: formFieldHintTextStyle,
                      errorStyle: formFieldHintTextStyle,
                      labelStyle: formFieldLabelTextStyle,
                      hintText: 'Enter the Last Name',
                      labelText: 'Last Name *',
                    ),
                    style: formFieldTextStyle,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        _showSnackbar("Processing Data...");

                        String user = usernameController.text;
                        String pass = passwordController.text;
                        String email = emailController.text;
                        String firstname = firstNameController.text;
                        String lastname = lastNameController.text;

                        // DELETE LATER
                        print("Username: " + user);
                        print("Password: " + pass);
                        print("Email: " + email);
                        print("First Name: " + firstname);
                        print("Last Name: " + lastname);

                        var uri = Uri.parse(
                            'http://10.0.2.2:8000/api/customer/signup');
                        var request = http.MultipartRequest('POST', uri)
                          ..fields['username'] = user
                          ..fields['password'] = pass
                          ..fields['email'] = email
                          ..fields['firstname'] = firstname
                          ..fields['lastname'] = lastname;

                        http.Response response = await http.Response.fromStream(
                            await request.send());

                        if (response.statusCode == 201) {
                          Navigator.pop(context, "Successful Registration");
                        } else if (response.body
                            .contains("username already exists")) {
                          _showSnackbar(
                              'Username already exists! Please choose another one.');
                        } else if (response.body.contains("status")) {
                          _showSnackbar(parseResponse(response.body));
                        } else {
                          _showSnackbar("Unknown Error");
                        }
                      }
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    String? pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }

  String parseResponse(String value) {
    String? pattern = r"'status' : '(\w+)'+";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return "";
    } else if (!regex.hasMatch(value)) {
      return regex.stringMatch(value).toString();
    } else {
      return "";
    }
  }

  Icon checkObscure(bool obscure) {
    if (obscure) {
      return const Icon(Icons.visibility_off, color: Colors.white);
    } else {
      return const Icon(Icons.visibility, color: Colors.white);
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}






// // Testing -- Remove later


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'Smart Grocery Map - User Sign Up Screen',
//       home: NavBar(),
//     );
//   }
// }

// class NavBar extends StatefulWidget {
//   const NavBar({Key? key}) : super(key: key);

//   @override
//   NavBarState createState() => NavBarState();
// }

// class NavBarState extends State<NavBar> {
//   @override
//   Widget build(BuildContext context) {
    
//     return const Scaffold(
//       body: UserSignUpScreen(),
//     );
//   }
// }
