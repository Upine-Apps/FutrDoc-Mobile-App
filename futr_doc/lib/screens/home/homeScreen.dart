import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/service/userService.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customImage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final TextEditingController _codeController = TextEditingController();
final _HomeScreenKey = GlobalKey<FormState>();

class _HomeScreenState extends State<HomeScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
                appBar: AppBar(
                  // AppBar takes a Text Widget
                  // in it's title parameter
                  title: Text('UpineApps'),
                ),
                body: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .125),
                  CustomImage(
                    imagePath: 'assets/images/daddy.png',
                  ),
                  Center(child: Text('Daddy Chill')),
                ]))));
  }
}
