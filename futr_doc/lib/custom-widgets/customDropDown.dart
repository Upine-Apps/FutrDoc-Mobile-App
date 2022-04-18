import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String initialValue;
  final Function(String?) onChanged;
  final List<String> items;
  final String labelText;
  final TextStyle? textStyle;

  const CustomDropDown(
      {Key? key,
      required this.initialValue,
      required this.onChanged,
      required this.items,
      required this.labelText,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      menuMaxHeight: MediaQuery.of(context).size.height * .3,
      itemHeight: 75,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      style:
          textStyle == null ? Theme.of(context).textTheme.bodyText2 : textStyle,
      isDense: true,
      isExpanded: true,
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
            alignment: Alignment.center,
            value: value,
            child: Text(
              value,
              style: textStyle == null
                  ? Theme.of(context).textTheme.bodyText2
                  : textStyle,
            ));
      }).toList(),
      onChanged: onChanged,
      value: initialValue,
    );
  }
}
