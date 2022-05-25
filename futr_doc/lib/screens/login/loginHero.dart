import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/screens/account_recovery/forgotPassword.dart';
import 'package:futr_doc/screens/login/login.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginHero extends StatefulWidget {
  @override
  _LoginHeroState createState() => _LoginHeroState();
}

class _LoginHeroState extends State<LoginHero> {
  @override
  void initState() {
    super.initState();
    getTheme();
  }

  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('Theme') ?? 'Light';
    });
  }

  String theme = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: MediaQuery.of(context).size.width * (.75),
                  child: SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * .2),
                      CustomImage(
                        height: MediaQuery.of(context).size.height * .15,
                        imagePath: theme == 'Dark'
                            ? 'assets/images/futrdoc-logo-dark.png'
                            : 'assets/images/futrdoc-logo-light.png',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .01),
                      Text('FutrDoc',
                          style: Theme.of(context).textTheme.headline1),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      Container(
                        width: MediaQuery.of(context).size.width * 1,
                        alignment: Alignment.center,
                        child: Text(
                          'Tracking your shadowing\nand volunteer hours\njust got easier',
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        text: 'Log In',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        text: 'Register',
                        textColor: AppColors.offWhite,
                        color: AppColors.lighterBlue,
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPassword()));
                          },
                          text: 'Forgot your password?'),
                      CustomTextButton(onPressed: () {}, text: 'Learn more!')
                    ],
                  ))))),
    );
  }
}
