import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/screens/account_recovery/recoveryCode.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/text-field/customPhoneField.dart';
import '../login/signUp.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
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
  String phone_number = '';

  final _forgotPasswordKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Scaffold(
              body: SingleChildScrollView(
                  child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .075,
              ),
              Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .05),
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Form(
                  key: _forgotPasswordKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                      CustomImage(
                        imagePath: theme == 'Dark'
                            ? 'assets/images/forgot-password-dark.png'
                            : 'assets/images/forgot-password-light.png',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Text('Forgot your password?',
                          style: Theme.of(context).textTheme.headline3),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      Text(
                        'It happens, let us know your number & we\'ll send you a code to reset it',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CustomPhoneField(
                        onEditingComplete: () {},
                        labelText: 'PHONE NUMBER',
                        controller: _phoneController,
                        onChanged: (val) {
                          setState(() {
                            phone_number = val!;
                          });
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CustomElevatedButton(
                        onPressed: () async {
                          if (_forgotPasswordKey.currentState!.validate()) {
                            var response = await UserService.instance
                                .startForgotPassword(phone_number);
                            if (response['status'] == true) {
                              Navigator.of(context).push(_createRoute(true));
                            } // do we need to put else statement?
                          }
                        },
                        text: 'Submit',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
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
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          )))),
    );
  }

  Route _createRoute(first) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => first == true
          ? ResetPassword(
              phone_number: phone_number,
            )
          : SignUp(),
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
