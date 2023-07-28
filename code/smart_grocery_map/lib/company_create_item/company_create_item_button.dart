import 'package:flutter/material.dart';

import './company_create_item_form.dart';

class CompanyCreateItemFloatingActionButton extends StatefulWidget {
  const CompanyCreateItemFloatingActionButton({Key? key}) : super(key: key);

  @override
  CompanyCreateItemFloatingActionButtonState createState() {
    return CompanyCreateItemFloatingActionButtonState();
  }
}

class CompanyCreateItemFloatingActionButtonState
    extends State<CompanyCreateItemFloatingActionButton> {
  bool _showButton = true;

  Future<void> _showRemoveCreateButton(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Create Button'),
          content:
              const Text('Would you like to remove the create item button?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  _showButton = false;
                });
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          elevation: 24,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showButton) {
      return GestureDetector(
        onLongPress: () => _showRemoveCreateButton(context),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CompanyCreateItemForm(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      );
    }
    return Container();
  }
}
