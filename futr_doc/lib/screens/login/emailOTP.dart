import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/screens/login/profileSetup.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:oktoast/oktoast.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customToast.dart';

class EmailOTP extends StatefulWidget {
  final String phone_number;
  final String password;
  EmailOTP({required this.phone_number, required this.password});
  @override
  _EmailOTPState createState() => _EmailOTPState();
}

final TextEditingController _emailCodeController = TextEditingController();
final _emailOTPKey = GlobalKey<FormState>();

class _EmailOTPState extends State<EmailOTP> {
  String code = '';
  bool isSpinner = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await UserService.instance
          .getEmailCode(widget.phone_number, widget.password, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: OKToast(
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
                      key: _emailOTPKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .1,
                          ),
                          Text(
                            'Sweet! Last one I promise, let\'s verify your email.',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width * .05),
                          Text(
                            'Enter the code we just sent to your email',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .5,
                          ),
                          CustomCodeField(
                            onEditingComplete: () {},
                            labelText: 'CODE',
                            controller: _emailCodeController,
                            onChanged: (val) {
                              setState(() {
                                code = val!;
                              });
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .1,
                          ),
                          CustomElevatedButton(
                            onPressed: () async {
                              if (_emailOTPKey.currentState!.validate()) {
                                setState(() {
                                  isSpinner = true;
                                });
                                var response = await UserService.instance
                                    .validateEmail(
                                        widget.phone_number, code, context);
                                if (response['status'] == false) {
                                  setState(() {
                                    isSpinner = false;
                                  });
                                  CustomToast.showDialog(
                                      'Wrong code provided', context);
                                } else if (response['status'] == true) {
                                  setState(() {
                                    isSpinner = false;
                                  });
                                  _emailCodeController.clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProfileSetup()));
                                }
                              }
                            },
                            text: 'Continue',
                            width: MediaQuery.of(context).size.width * .75,
                            height: MediaQuery.of(context).size.height * .05,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .025,
                          ),
                          CustomTextButton(
                              onPressed: () async {
                                await UserService.instance.getEmailCode(
                                    widget.phone_number,
                                    widget.password,
                                    context);
                                CustomToast.showDialog(
                                    'Just sent you an email!', context);
                              },
                              text: 'Resend code')
                        ],
                      ),
                    ))
              ],
            ))))));
  }
}
