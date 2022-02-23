import 'package:flutter/material.dart';
import 'appColor.dart';

class AppTheme {
  get darkTheme => ThemeData(
      dividerColor: AppColors.grey,
      scaffoldBackgroundColor: AppColors.primaryDARK,
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: AppColors.accentDARK,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      )),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all<Color>(AppColors.white),
        fillColor: MaterialStateProperty.all<Color>(AppColors.grey),
      ),
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          buttonColor: AppColors.accentDARK),
      textTheme: TextTheme(
          headline1: TextStyle(color: AppColors.white, fontSize: 40),
          bodyText1: TextStyle(color: AppColors.white, fontSize: 20),
          headline2: TextStyle(color: AppColors.white, fontSize: 16),
          button: TextStyle(
              color: Colors.white,
              fontSize: 16,
              decoration: TextDecoration.underline),
          bodyText2: TextStyle(color: AppColors.white, fontSize: 12)),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.white),
          border: OutlineInputBorder(),
          hintStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(
            color: Color(0xFFCF6679),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFCF6679)),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCF6679))),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          )));

  get lightTheme => ThemeData(
        dividerColor: AppColors.black,
        scaffoldBackgroundColor: AppColors.offWhite,
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 10,
          primary: AppColors.accentDARK,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all<Color>(AppColors.black),
          fillColor: MaterialStateProperty.all<Color>(AppColors.grey),
        ),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            buttonColor: AppColors.accentDARK),
        textTheme: TextTheme(
            headline1: TextStyle(color: AppColors.black, fontSize: 40),
            bodyText1: TextStyle(color: AppColors.black, fontSize: 20),
            bodyText2: TextStyle(color: AppColors.black, fontSize: 12),
            headline2: TextStyle(color: AppColors.black, fontSize: 16),
            button: TextStyle(
                color: Colors.black,
                fontSize: 16,
                decoration: TextDecoration.underline)),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(color: AppColors.black),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      );
}
