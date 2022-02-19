import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPasswordFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  String? Function(String? val)? validator;
  final Function(String?) onChanged;


  CustomPasswordFormField({
    Key? key,
    required this.onEditingComplete,
    required this.labelText,
    required this.controller,
    this.validator,
    required this.onChanged
  }) : super(key: key);

  String? validatePassword(String? value) {
  if(value!.length < 6){
    return 'Invalid password, length must be more than 6';
  }

}
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      onEditingComplete: onEditingComplete,
      controller: controller,
      validator: validatePassword,
      obscureText: true,
      onChanged: onChanged
    );
  }
}
