import 'dart:convert';

import '/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:smart_grocery_map/global.dart';

class CompanyCreateItemForm extends StatefulWidget {
  const CompanyCreateItemForm({Key? key}) : super(key: key);

  @override
  CompanyCreateItemFormState createState() {
    return CompanyCreateItemFormState();
  }
}

class CompanyCreateItemFormState extends State<CompanyCreateItemForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productTypeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _aisleController = TextEditingController();
  final TextEditingController _shelfController = TextEditingController();

  XFile? _image;
  Widget _previewImage = const Icon(
    Icons.image,
    size: 160,
  );

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
    fontSize: 18.0,
  );
  static const TextStyle formFieldLabelTextStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
  );

  @override
  void dispose() {
    super.dispose();
    _productNameController.dispose();
    _productTypeController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _aisleController.dispose();
    _shelfController.dispose();
  }

  TextFormField _productNameFormField() {
    return TextFormField(
      controller: _productNameController,
      decoration: InputDecoration(
        icon: const Icon(Icons.text_fields, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product name',
        labelText: 'Product Name *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _productTypeFormField() {
    return TextFormField(
      controller: _productTypeController,
      decoration: InputDecoration(
        icon: const Icon(Icons.text_fields, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product type',
        labelText: 'Product Type *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _descriptionFormField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        icon: const Icon(Icons.text_fields, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product description',
        labelText: 'Product Description *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _priceFormField() {
    return TextFormField(
      controller: _priceController,
      decoration: InputDecoration(
        icon: const Icon(Icons.attach_money_outlined, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product price',
        labelText: 'Product Price (\$) *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) {
          return 'Please enter a decimal number';
        }
        return null;
      },
    );
  }

  TextFormField _aisleFormField() {
    return TextFormField(
      controller: _aisleController,
      decoration: InputDecoration(
        icon: const Icon(Icons.local_grocery_store, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product aisle',
        labelText: 'Product Aisle *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Please enter a number between 1 and 200';
        }
        return null;
      },
    );
  }

  TextFormField _shelfFormField() {
    return TextFormField(
      controller: _shelfController,
      decoration: InputDecoration(
        icon: const Icon(Icons.local_grocery_store, color: Colors.white),
        hintStyle: formFieldHintTextStyle,
        labelStyle: formFieldLabelTextStyle,
        hintText: 'Enter the product shelf',
        labelText: 'Product Shelf *',
      ),
      style: formFieldTextStyle,
      validator: (value) {
        if (value == null || value.isEmpty || int.tryParse(value) == null) {
          return 'Please enter a number between 1 and 1000';
        }
        return null;
      },
    );
  }

  ElevatedButton _imagePickButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        primary: Colors.white,
        onPrimary: Colors.black,
        textStyle: formFieldTextStyle,
      ),
      child: Row(
        children: const [
          Icon(Icons.image, size: 28),
          SizedBox(width: 16),
          Text('Pick Gallery *')
        ],
      ),
      onPressed: _pickImage,
    );
  }

  ElevatedButton _submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Processing Data'),
              duration: Duration(milliseconds: 500),
            ),
          );
          try {
            _sendRequest();
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        }
      },
      child: const Text('Create product'),
    );
  }

  Future _pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      MediaQueryData queryData = MediaQuery.of(context);

      _previewImage = Padding(
        padding: EdgeInsets.symmetric(
          horizontal: queryData.size.width * 0.05,
          vertical: queryData.size.height * 0.03,
        ),
        child: Image.memory(
          await image.readAsBytes(),
          width: 140,
          height: 140,
          fit: BoxFit.cover,
        ),
      );

      setState(() {
        _image = image;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  Future _sendRequest() async {
    String companyUsername = Globals.companyUsername;
    String productName = _productNameController.text;
    String productType = _productTypeController.text;
    String description = _descriptionController.text;
    String price = _priceController.text;
    String aisle = _aisleController.text;
    String shelf = _shelfController.text;

    var uri = Uri.parse('http://10.0.2.2:8000/api/company/inventory/create');
    // var uri = Uri.parse('http://10.0.2.2:8000/api/company/inventory/create');

    var request = http.MultipartRequest('POST', uri)
      ..fields['company_username'] = companyUsername
      ..fields['product_name'] = productName
      ..fields['product_type'] = productType
      ..fields['description'] = description
      ..fields['price'] = price
      ..fields['aisle'] = aisle
      ..fields['shelf'] = shelf;

    if (_image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image_source', _image!.path));
    }

    var response = await request.send();

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully created product: " + productName),
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(jsonDecode(await response.stream.bytesToString())['status']),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);

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
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Create Product',
                    style: titleTextStyle,
                  ),
                  _productNameFormField(),
                  _productTypeFormField(),
                  _descriptionFormField(),
                  _priceFormField(),
                  _aisleFormField(),
                  _shelfFormField(),
                  const SizedBox(height: 20),
                  _imagePickButton(),
                  _previewImage,
                  const SizedBox(height: 20),
                  _submitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
