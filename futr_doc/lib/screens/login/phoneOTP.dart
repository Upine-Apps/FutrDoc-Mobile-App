import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/service/userService.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customToast.dart';

class PhoneOTP extends StatefulWidget {
  final String phone_number;
  final String password;
  PhoneOTP({required this.phone_number, required this.password});
  @override
  _PhoneOTPState createState() => _PhoneOTPState();
}

final TextEditingController _phoneCodeController = TextEditingController();
final _phoneOTPKey = GlobalKey<FormState>();

class _PhoneOTPState extends State<PhoneOTP> {
  String code = '';
  bool isSpinner = false;
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
                    key: _phoneOTPKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .1,
                        ),
                        Text(
                          'Let\'s verify your phone number',
                          style: Theme.of(context).textTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.width * .05),
                        Text('Enter the code we just sent to your phone',
                            style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * .5,
                        ),
                        CustomCodeField(
                          onEditingComplete: () {
                            node.nextFocus();
                          },
                          labelText: 'CODE',
                          controller: _phoneCodeController,
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
                              if (_phoneOTPKey.currentState!.validate()) {
                                setState(() {
                                  isSpinner = true;
                                });
                                var response = await UserService.instance
                                    .validateSms(widget.phone_number, code);
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
                                  _phoneCodeController.clear();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EmailOTP(
                                              phone_number: widget.phone_number,
                                              password: widget.password)));
                                }
                              }
                            },
                            text: 'Continue',
                            width: MediaQuery.of(context).size.width * .75,
                            height: MediaQuery.of(context).size.height * .05,
                            spinner: isSpinner),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .025,
                        ),
                        CustomTextButton(
                            onPressed: () async {
                              var response = await UserService.instance
                                  .resendSms(widget.phone_number);
                              if (response['status'] == false) {
                                CustomToast.showDialog(
                                    'Error sending SMS code', context);
                              } else if (response['status'] == true) {
                                CustomToast.showDialog(
                                    'Just sent you a message!', context);
                              }
                            },
                            text: 'Resend code')
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
