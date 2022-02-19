import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../custom-widgets/buttons/customElevatedButton.dart';
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
      theme = prefs.getString('Theme')!;
    });
  }

  String theme = '';
  bool terms = false;
  final _signUpFormKey = GlobalKey<FormState>();
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
                    key: _signUpFormKey,
                    child: Column(children: <Widget>[
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .075),
                      CustomImage(
                          imagePath: theme == 'Dark'
                              ? 'assets/images/sign-up-logo.png'
                              : 'assets/images/sign-up-logo-light.png',
                          height: MediaQuery.of(context).size.height * .035),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .05),
                      CustomTextFormField(
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          labelText: 'FIRST NAME'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextFormField(
                          onEditingComplete: () { node.nextFocus();}, labelText: 'LAST NAME'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      CustomTextFormField(
                          onEditingComplete: () { node.nextFocus();}, labelText: 'EMAIL'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextFormField(
                          onEditingComplete: () { node.nextFocus();}, labelText: 'PASSWORD'),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextFormField(
                          onEditingComplete: () {},
                          labelText: 'CONFIM PASSWORD'),
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
                        onPressed: () {},
                        text: 'Sign Up',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        width: MediaQuery.of(context).size.width * .7,
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      Text(
                        'Already have an account? ',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      CustomTextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          text: 'Login'),
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                    ]),
                  ),
                )),
          ))),
    );
  }
}
