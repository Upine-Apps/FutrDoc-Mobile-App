import 'package:flutter/material.dart';
import 'appColor.dart';

class AppTheme {
  get darkTheme => ThemeData(
      unselectedWidgetColor: AppColors.primaryDARK,
      canvasColor: AppColors.darkGrey,
      primaryColor: AppColors.primaryDARK,
      secondaryHeaderColor: AppColors.offWhite,
      dividerColor: AppColors.grey,
      scaffoldBackgroundColor: AppColors.primaryDARK,
      brightness: Brightness.dark,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 10,
        primary: AppColors.darkButtonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      )),
      cardTheme: CardTheme(color: AppColors.offWhite),
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
          headline1: TextStyle(
              color: AppColors.white, fontSize: 60, fontFamily: 'Share'),
          bodyText1: TextStyle(
              color: AppColors.white, fontSize: 20, fontFamily: 'Share'),
          headline2: TextStyle(
              color: AppColors.white, fontSize: 40, fontFamily: 'Share'),
          headline3: TextStyle(
              color: AppColors.white, fontSize: 30, fontFamily: 'Share'),
          headline5: TextStyle(
              color: AppColors.primaryDARK, fontSize: 16, fontFamily: 'Share'),
          headline6: TextStyle(
              color: AppColors.darkGrey, fontSize: 16, fontFamily: 'Share'),
          headline4: TextStyle(
              color: AppColors.primaryDARK, fontSize: 30, fontFamily: 'Share'),
          button:
              TextStyle(color: Colors.white, fontSize: 16, fontFamily: 'Share'),
          bodyText2: TextStyle(
              color: AppColors.white, fontSize: 16, fontFamily: 'Share'),
          caption: TextStyle(
              color: AppColors.offWhite, fontSize: 40, fontFamily: 'Share')),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: TextStyle(
            color: AppColors.offWhite, fontFamily: 'Share', fontSize: 16),
        errorStyle: TextStyle(
          color: Color(0xFFCF6679),
        ),
        border: UnderlineInputBorder(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ));

  get lightTheme => ThemeData(
        unselectedWidgetColor: AppColors.primaryDARK,
        canvasColor: AppColors.lightGrey,
        primaryColor: AppColors.offWhite,
        secondaryHeaderColor: AppColors.primaryDARK,
        dividerColor: AppColors.lightGrey,
        scaffoldBackgroundColor: AppColors.offWhite,
        brightness: Brightness.light,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 10,
          primary: AppColors.primaryDARK,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )),
        cardTheme: CardTheme(color: AppColors.primaryDARK),
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
            headline1: TextStyle(
                color: AppColors.primaryDARK,
                fontSize: 60,
                fontFamily: 'Share'),
            bodyText1: TextStyle(
                color: AppColors.primaryDARK,
                fontSize: 20,
                fontFamily: 'Share'),
            bodyText2: TextStyle(
                color: AppColors.primaryDARK,
                fontSize: 16,
                fontFamily: 'Share'),
            headline2: TextStyle(
                color: AppColors.primaryDARK,
                fontSize: 40,
                fontFamily: 'Share'),
            headline3: TextStyle(
                color: AppColors.primaryDARK,
                fontSize: 30,
                fontFamily: 'Share'),
            button: TextStyle(
              color: AppColors.primaryDARK,
              fontSize: 16,
              fontFamily: 'Share',
            ),
            headline5: TextStyle(
                color: AppColors.offWhite, fontSize: 16, fontFamily: 'Share'),
            headline6: TextStyle(
                color: AppColors.darkGrey, fontSize: 16, fontFamily: 'Share'),
            headline4: TextStyle(
                color: AppColors.offWhite, fontSize: 30, fontFamily: 'Share'),
            caption: TextStyle(
                color: AppColors.darkGrey, fontSize: 40, fontFamily: 'Share')),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
              color: AppColors.primaryDARK, fontFamily: 'Share', fontSize: 16),
          border: UnderlineInputBorder(),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      );
}
