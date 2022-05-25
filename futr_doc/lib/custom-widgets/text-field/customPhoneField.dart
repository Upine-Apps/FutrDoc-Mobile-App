import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;

  const CustomPhoneField(
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
      style: Theme.of(context).textTheme.bodyText2,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
      ],
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        } else if (val.length != 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }
}
