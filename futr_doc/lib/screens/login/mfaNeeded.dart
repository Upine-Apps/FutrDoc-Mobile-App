import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customToast.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/service/userService.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../models/types/UnauthenticatedUserBody.dart';
import '../../models/types/VerifyAttributeBody.dart';

class MfaNeeded extends StatefulWidget {
  final String phone_number;
  final String password;
  MfaNeeded({required this.phone_number, required this.password});
  @override
  _MfaNeededState createState() => _MfaNeededState();
}

final TextEditingController _codeController = TextEditingController();
final _recoveryCodeKey = GlobalKey<FormState>();

class _MfaNeededState extends State<MfaNeeded> {
  String code = '';
  bool isSpinner = false;
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
                      key: _recoveryCodeKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .1,
                          ),
                          Text(
                            'Enter the six digit code:',
                            style: Theme.of(context).textTheme.headline3,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width * .5,
                          ),
                          CustomCodeField(
                            onEditingComplete: () {},
                            labelText: 'CODE',
                            controller: _codeController,
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
                                if (_recoveryCodeKey.currentState!.validate()) {
                                  setState(() {
                                    isSpinner = true;
                                  });
                                  var response = await UserService.instance
                                      .validateSms(VerifyAttributeBody(
                                          username: widget.phone_number,
                                          code: code));
                                  if (response['status'] == true) {
                                    setState(() {
                                      isSpinner = false;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EmailOTP(
                                            phone_number: widget.phone_number,
                                            password: widget.password),
                                      ),
                                    );
                                  } else {
                                    setState(() {
                                      isSpinner = false;
                                    });
                                    CustomToast.showDialog('Incorrect code',
                                        context); // do we need to put else statement?
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
                                    .resendSms(UnauthenticatedUserBody(
                                        username: widget.phone_number));
                                if (response['status'] == true) {
                                  CustomToast.showDialog(
                                      'Code resent!', context);
                                } else {
                                  CustomToast.showDialog(
                                      response['message'], context);
                                }
                              },
                              text: 'Resend code')
                        ],
                      ),
                    ))
              ],
            )))));
  }
}
