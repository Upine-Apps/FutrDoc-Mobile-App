import 'package:flutter/material.dart';

class CustomEmailFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;

  const CustomEmailFormField(
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
      controller: controller,
      validator: (String? val) {
        print('bananas');
        print(val == '');
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}
