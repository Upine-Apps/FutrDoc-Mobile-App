import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/theme/appColor.dart';

class ShadowingPatientType extends StatefulWidget {
  @override
  _ShadowingPatientTypeState createState() => _ShadowingPatientTypeState();
}

class _ShadowingPatientTypeState extends State<ShadowingPatientType> {
  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Text(
              'What type of patient?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            CustomElevatedButton(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .05,
              onPressed: () {},
              text: 'Pediatric',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Adolescence',
                color: AppColors.lighterBlue),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Adult'),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Geriatric'),
          ],
        ),
      ),
    );
  }
}
