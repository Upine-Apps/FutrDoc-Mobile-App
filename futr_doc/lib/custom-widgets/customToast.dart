import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

class CustomToast {
  static showDialog(String msg, BuildContext context) {
    showToastWidget(
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: DefaultTextStyle(
            style: TextStyle(
                fontFamily: 'Share',
                fontSize: 20,
                color: Theme.of(context).primaryColor),
            child: Text(msg,
                style: TextStyle(
                    fontFamily: 'Share',
                    fontSize: 16,
                    color: Theme.of(context).primaryColor))),
      ),
      duration: Duration(seconds: 5),
      position: ToastPosition.center,
    );
  }

  static showStaticDialog(String msg, BuildContext context) {
    showToast(msg,
        duration: Duration(seconds: 5),
        position: ToastPosition.center,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        textStyle: TextStyle(
            fontFamily: 'Share',
            fontSize: 16,
            color: Theme.of(context).primaryColor),
        textAlign: TextAlign.center,
        radius: 10);
  }
}
