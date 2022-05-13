import 'package:flutter/material.dart';
import 'package:futr_doc/models/types/ForgotPasswordBody.dart';
import 'package:futr_doc/screens/login/login.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/buttons/customTextButton.dart';
import '../../custom-widgets/customImage.dart';
import '../../custom-widgets/customToast.dart';
import '../../custom-widgets/text-field/customCodeField.dart';
import '../../custom-widgets/text-field/customPasswordFormField.dart';
import '../../models/types/UnauthenticatedUserBody.dart';
import '../../theme/appColor.dart';

class ResetPassword extends StatefulWidget {
  final String phone_number;
  ResetPassword({required this.phone_number});
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
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
  String code = '';
  String password = '';
  String confirmPassword = '';
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _resetPasswordKey = GlobalKey<FormState>();
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
                      icon: Icon(Icons.arrow_back_ios, color: theme == 'Dark' ? AppColors.offWhite : AppColors.black,),
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
                          height: MediaQuery.of(context).size.height * .025,
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
                        CustomPasswordFormField(
                            onEditingComplete: () {
                              node.nextFocus();
                            },
                            labelText: 'PASSWORD',
                            controller: _newPasswordController,
                            onChanged: (val) {
                              setState(() {
                                password = val!;
                              });
                            }),
                        CustomPasswordFormField(
                            onEditingComplete: () {},
                            labelText: 'CONFIRM PASSWORD',
                            controller: _confirmPasswordController,
                            onChanged: (val) {
                              setState(() {
                                confirmPassword = val!;
                              });
                            }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .05,
                        ),
                        CustomElevatedButton(
                            onPressed: () async {
                              if (_resetPasswordKey.currentState!.validate()) {
                                if (confirmPassword != password) {
                                  CustomToast.showDialog(
                                      'Passwords do not match', context, false);
                                } else {
                                  setState(() {
                                    isSpinner = true;
                                  });
                                  var response = await UserService.instance
                                      .completeForgotPassword(
                                          ForgotPasswordBody(
                                              username: widget.phone_number,
                                              code: code,
                                              password: password));
                                  if (response['status'] == false) {
                                    setState(() {
                                      isSpinner = false;
                                    });
                                    CustomToast.showDialog(
                                        'Wrong code provided', context, false);
                                  } else if (response['status'] == true) {
                                    setState(() {
                                      isSpinner = false;
                                    });
                                    _clearAllController();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()));
                                  }
                                }
                              }
                            },
                            text: 'Submit',
                            width: MediaQuery.of(context).size.width * .75,
                            height: MediaQuery.of(context).size.height * .05,
                            spinner: isSpinner),
                        CustomTextButton(
                            onPressed: () async {
                              var response = await UserService.instance
                                  .resendSms(UnauthenticatedUserBody(
                                      username: widget.phone_number));
                              if (response['status'] == true) {
                                CustomToast.showDialog('Code resent!', context, false);
                              } else {
                                CustomToast.showDialog(
                                    response['message'], context, false);
                              }
                            },
                            text: 'Resend code')
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearAllController() {
    _codeController.clear();
    _newPasswordController.clear();
    _confirmPasswordController.clear();
  }
}
