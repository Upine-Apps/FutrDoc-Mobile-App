import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/models/types/LoginBody.dart';
import 'package:futr_doc/models/types/VerifyAttributeBody.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/screens/login/profileSetup.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customToast.dart';
import '../../custom-widgets/text-field/customPhoneField.dart';
import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';

class ShadowingWho extends StatefulWidget {
  ShadowingWho();
  @override
  _ShadowingWhoState createState() => _ShadowingWhoState();
}

final TextEditingController _phonenumberController = TextEditingController();

class _ShadowingWhoState extends State<ShadowingWho> {
  String phone_number = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Text(
              'Who did you shadow with?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            CustomPhoneField(
              onEditingComplete: () {},
              labelText: 'PHONE NUMBER',
              controller: _phonenumberController,
              onChanged: (val) {
                setState(() {
                  phone_number = val!;
                });
                Shadowing lastShadowing =
                    context.read<ShadowingProvider>().lastShadowing;
                lastShadowing.phone_number = phone_number;
                context
                    .read<ShadowingProvider>()
                    .setLastShadowing(lastShadowing);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
