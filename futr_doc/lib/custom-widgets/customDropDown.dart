import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String initialValue;
  final Function(String?) onChanged;
  final List<String> items;
  final String labelText;

  const CustomDropDown(
      {Key? key,
      required this.initialValue,
      required this.onChanged,
      required this.items,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: labelText,
      ),
      style: Theme.of(context).textTheme.bodyText2,
      isDense: true,
      isExpanded: false,
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
            value: value,
            child: Text(value, style: Theme.of(context).textTheme.bodyText2));
      }).toList(),
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
