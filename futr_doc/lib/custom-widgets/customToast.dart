import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static showDialog(String msg, context, var location) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Theme.of(context).colorScheme.secondaryVariant,
        backgroundColor: Theme.of(context).primaryColor,
        fontSize: 16.0);
  }
}
