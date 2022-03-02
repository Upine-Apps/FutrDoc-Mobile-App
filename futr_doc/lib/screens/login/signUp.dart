import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/text-field/customEmailFormField.dart';
import '../../custom-widgets/text-field/customPasswordFormField.dart';
import '../../custom-widgets/text-field/customPhoneField.dart';
import '../../custom-widgets/text-field/emailWithDropdown.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
  bool terms = false;
  final _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String dropdownValue = '@utrgv.edu';
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return WillPopScope(
      onWillPop: () async => true,
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
                    key: _signUpFormKey,
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      CustomImage(
                          imagePath: theme == 'Dark'
                              ? 'assets/images/sign-up-logo.png'
                              : 'assets/images/sign-up-logo-light.png',
                          width: MediaQuery.of(context).size.height * .75),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      CustomTextFormField(
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        labelText: 'FIRST NAME',
                        controller: _firstNameController,
                        onChanged: (val) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextFormField(
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        labelText: 'LAST NAME',
                        controller: _lastNameController,
                        onChanged: (val) {},
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
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
                      CustomPhoneField(
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        labelText: 'PHONE NUMBER',
                        controller: _phoneController,
                        onChanged: (val) {},
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomPasswordFormField(
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          labelText: 'PASSWORD',
                          controller: _passwordController,
                          onChanged: (val) {}),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomPasswordFormField(
                          onEditingComplete: () {},
                          labelText: 'CONFIRM PASSWORD',
                          controller: _passwordConfirmController,
                          onChanged: (val) {}),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: terms,
                              onChanged: (bool? value) {
                                setState(() {
                                  terms = value!;
                                });
                              }),
                          Container(
                            width: MediaQuery.of(context).size.width * .6,
                            child: TextButton(
                              onPressed: () async {
                                await launch('https://google.com');
                              },
                              child: Text(
                                  'I AGREE TO THE PRIVACY POLICY AND TERMS OF SERVICE',
                                  style: Theme.of(context).textTheme.bodyText2),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .035),
                      CustomElevatedButton(
                        onPressed: () {
                          if (_signUpFormKey.currentState!.validate()) {}
                        },
                        text: 'Sign up',
                        fontSize: 30,
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height * .075,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      Text(
                        'Already have an account? ',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          text: 'Login'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                    ]),
                  ),
                )),
          ))),
    );
  }
}
