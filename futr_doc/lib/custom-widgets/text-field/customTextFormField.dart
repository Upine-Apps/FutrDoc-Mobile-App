import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final Widget? prefixIcon;
  final bool? enabled;

  const CustomTextFormField({
    Key? key,
    required this.onEditingComplete,
    required this.labelText,
    required this.controller,
    required this.onChanged,
    this.prefixIcon,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      decoration: InputDecoration(labelText: labelText, prefixIcon: prefixIcon),
      onEditingComplete: onEditingComplete,
      controller: controller,
      onChanged: onChanged,
      // inputFormatters: <TextInputFormatter>[
      //   FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\-\ ]"))
      // ],
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }
}
