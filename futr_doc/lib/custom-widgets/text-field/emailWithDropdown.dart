import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:futr_doc/theme/appTheme.dart';

class EmailWithDropdown extends StatelessWidget {
  final VoidCallback onEditingComplete;
  final String labelText;
  final TextEditingController controller;
  final Function(String?) onChanged;
  final Function(String?) onChangedDropdown;
  final String dropdownValue;

  const EmailWithDropdown(
      {Key? key,
      required this.onEditingComplete,
      required this.labelText,
      required this.controller,
      required this.onChanged,
      required this.onChangedDropdown,
      required this.dropdownValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        suffixIcon: Container(
          height: 25,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: dropdownValue,
              onChanged: onChangedDropdown,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              items: <String>['@utrgv.edu', '@tamu.edu', '@baylor.edu']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: Theme.of(context).textTheme.bodyText2),
                );
              }).toList(),
            ),
          ),
        ),
        labelText: labelText,
      ),
      onEditingComplete: onEditingComplete,
      controller: controller,
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\-\ ]"))
      ],
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
    );
  }
}
