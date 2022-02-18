import 'package:flutter/material.dart';
import 'appColor.dart';

class AppTheme {
  
    get darkTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.primaryDARK,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: AppColors.accentDARK,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          )
        ),
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            buttonColor: AppColors.accentDARK),
        textTheme: TextTheme(
            headline1: TextStyle(color: AppColors.white, fontSize: 40),
            bodyText1: TextStyle(color: AppColors.white, fontSize: 20),
            button: TextStyle(
              color: Colors.white,
              fontSize: 20,
              decoration: TextDecoration.underline
            )),
            

        inputDecorationTheme: InputDecorationTheme(
            labelStyle: TextStyle(color: AppColors.white),
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            )));
  

  
    get lightTheme => ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: AppColors.accentDARK,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          )
        ),
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          buttonColor: AppColors.accentDARK),
      textTheme: TextTheme(
          headline1: TextStyle(color: AppColors.black, fontSize: 40),
          bodyText1: TextStyle(color: AppColors.black, fontSize: 20),
           button: TextStyle(
              color: Colors.black,
              fontSize: 20,
              decoration: TextDecoration.underline
            )),
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
