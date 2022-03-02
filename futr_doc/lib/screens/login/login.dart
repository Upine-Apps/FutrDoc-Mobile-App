import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/custom-widgets/text-field/customPasswordFormField.dart';
import 'package:futr_doc/screens/login/signUp.dart';

import '../../custom-widgets/text-field/customEmailFormField.dart';
import '../../custom-widgets/text-field/emailWithDropdown.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              child: SingleChildScrollView(
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      CustomImage(
                          imagePath: 'assets/images/sign-up-logo.png',
                          width: MediaQuery.of(context).size.height * .75),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      EmailWithDropdown(
                          onEditingComplete: () {},
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
                          height: MediaQuery.of(context).size.height * .025),
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
                        fontSize: 30,
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .075,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      Text(
                        'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          text: 'Sign Up'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
