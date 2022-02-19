import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;

  const CustomTextFormField(
      {Key? key, required this.onEditingComplete, required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      onEditingComplete: onEditingComplete,
    );
  }
}
