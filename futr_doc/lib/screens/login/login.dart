import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/custom-widgets/halfCircle.dart';
import 'package:futr_doc/custom-widgets/text-field/customPasswordFormField.dart';
import 'package:futr_doc/screens/account_recovery/forgotPassword.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/text-field/customEmailFormField.dart';
import '../../custom-widgets/text-field/emailWithDropdown.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String dropdownValue = '@utrgv.edu';

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async => false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * .2,
                          left: MediaQuery.of(context).size.width * .2),
                      color: Theme.of(context).secondaryHeaderColor,
                      child: Column(
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .125),
                          CustomImage(
                            imagePath: theme == 'Dark'
                                ? 'assets/images/futrdoc-logo-light.png'
                                : 'assets/images/futrdoc-logo-dark.png',
                          ),
                          Text(
                            'FutrDoc',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 60,
                                fontFamily: 'Share'),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Tracking your shadowing and volunteer hours just got easier',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontFamily: 'Share'),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .05),
                        ],
                      )),
                  MyArc(
                    width: MediaQuery.of(context).size.width ,
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        children: [
                          EmailWithDropdown(
                              onEditingComplete: () {
                                node.nextFocus();
                              },
                              labelText: 'EMAIL',
                              controller: _emailController,
                              onChanged: (val) {},
                              onChangedDropdown: (value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              dropdownValue: dropdownValue),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .025),
                          CustomPasswordFormField(
                            onEditingComplete: () {},
                            labelText: 'PASSWORD',
                            controller: _passwordController,
                            onChanged: (val) {},
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .05),
                          CustomElevatedButton(
                            onPressed: () {
                              if (_loginFormKey.currentState!.validate()) {}
                            },
                            text: 'Login',
                            width: MediaQuery.of(context).size.width * .75,
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .025),
                              CustomTextButton(
                              onPressed: () {
                                Navigator.of(context).push(_createRoute(true));
                              },
                              text: 'Forgot your password?'),
                          Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                            'Don\'t have an account? ',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          CustomTextButton(
                              onPressed: () {
                                Navigator.of(context).push(_createRoute(false));
                              },
                              text: 'Register here!'),
                          ],),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Route _createRoute(first) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => first == true ? ForgotPassword() : SignUp(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.decelerate;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
