import 'package:flutter/material.dart';
import 'package:futr_doc/screens/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customImage.dart';
import '../../custom-widgets/text-field/customPasswordFormField.dart';

class ResetPasswod extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPasswod> {
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
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _resetPasswordKey = GlobalKey<FormState>();

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
                      key: _resetPasswordKey,
                      child: Column(
                        children: [
                          SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                        CustomImage(
                           imagePath: theme == 'Dark'
                            ? 'assets/images/reset-password-dark.png'
                            : 'assets/images/reset-password-light.png',
                        ),
                        SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      Text('Reset your password!',
                          style: Theme.of(context).textTheme.headline3),
                          SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CustomPasswordFormField(
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          labelText: 'PASSWORD',
                          controller: _newPasswordController,
                          onChanged: (val) {}),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomPasswordFormField(
                          onEditingComplete: () {},
                          labelText: 'CONFIRM PASSWORD',
                          controller: _confirmPasswordController,
                          onChanged: (val) {}),
                          SizedBox(
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                      CustomElevatedButton(
                        onPressed: () {
                          if (_resetPasswordKey.currentState!.validate()) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          }
                        },
                        text: 'Submit',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      ),
                        ],
                      )
                    )
                  )
                  ],
                )
              )
            )
            
            ));
  }
}
