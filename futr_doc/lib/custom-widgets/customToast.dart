import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

import '../theme/appColor.dart';

class CustomToast {
  static showDialog(String msg, BuildContext context, [bool? showCheckIcon]) {
    showToastWidget(
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.lighterBlue,
            border: Border.all(color: AppColors.lighterBlue),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(showCheckIcon == true) ... [
              Icon(Icons.check, color: AppColors.offWhite),
              SizedBox(width: 10),
            ],
            DefaultTextStyle(
              
                style: TextStyle(
                    fontFamily: 'Share',
                    fontSize: 20,
                    color: AppColors.offWhite),
                child: Text(msg,
                    style: TextStyle(
                        fontFamily: 'Share',
                        fontSize: 16,
                        color: AppColors.offWhite))),
          ],
        ),
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
