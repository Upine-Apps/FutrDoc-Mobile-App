import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customImage.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
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
                            child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .15),
                            CustomImage(
                                imagePath: 'assets/images/futrdoc-logo.png',
                                height:
                                    MediaQuery.of(context).size.height * .2),
                            Text('FutrDoc',
                                style: Theme.of(context).textTheme.headline1),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            CustomTextFormField(
                                onEditingComplete: () {},
                                labelText: 'USERNAME'),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .025),
                            CustomTextFormField(
                                onEditingComplete: () {},
                                labelText: 'PASSWORD'),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .05),
                            CustomElevatedButton(
                              onPressed: () {},
                              text: 'LOGIN',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              width: MediaQuery.of(context).size.width * .7,
                              height: MediaQuery.of(context).size.height * .1,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .1),
                            Text(
                              'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                            CustomTextButton(onPressed: () {}, text: 'Sign Up'),
                          ],
                        )))))));
  }
}
