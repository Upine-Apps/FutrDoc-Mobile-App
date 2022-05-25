import 'package:flutter/material.dart';

class CustomPasswordFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;

  CustomPasswordFormField(
      {Key? key,
      required this.onEditingComplete,
      required this.labelText,
      required this.controller,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        decoration: InputDecoration(labelText: labelText),
        onEditingComplete: onEditingComplete,
        style: Theme.of(context).textTheme.bodyText2,
        controller: controller,
        validator: (String? val) {
          if (val!.isEmpty) {
            return 'Field cannot be empty';
          } else if (val.length < 6) {
            return 'Invalid password, length must be more than 6';
          }
          return null;
        },
        obscureText: true,
        onChanged: onChanged);
  }
}
