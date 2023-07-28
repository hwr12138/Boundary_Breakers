import 'package:flutter/material.dart';
import 'package:smart_grocery_map/res/styles.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final IconData? suffixIcon;
  final VoidCallback? onEyePressed;

  const TextInputField({
    Key? key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.textInputType,
    this.textInputAction,
    this.suffixIcon,
    this.onEyePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: kLabelStyle,
        ),
        const SizedBox(height: 14.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: controller,
            keyboardType: textInputType,
            textInputAction: textInputAction,
            obscureText: obscureText,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(icon, color: Colors.white),
              hintText: hintText,
              hintStyle: kHintTextStyle,
              suffixIcon: suffixIcon == null
                  ? null
                  : InkWell(
                      onTap: onEyePressed,
                      child: Icon(suffixIcon, color: Colors.white),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
