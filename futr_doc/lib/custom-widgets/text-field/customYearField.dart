import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class CustomYearField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;

  const CustomYearField(
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
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
      ],
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        } else if (int.parse(val) > 20) {
          return 'You\'re in school for that long????';
        }
        return null;
      },
    );
  }
}
