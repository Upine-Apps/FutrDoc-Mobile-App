import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/theme/appColor.dart';

class ShadowingWhat extends StatefulWidget {
  @override
  _ShadowingWhatState createState() => _ShadowingWhatState();
}

class _ShadowingWhatState extends State<ShadowingWhat> {
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
              'What did you do?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .1),
            CustomElevatedButton(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .05,
              onPressed: () {},
              text: 'Observed',
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Reviewed',
                color: AppColors.lighterBlue),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Discussed'),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                onPressed: () {},
                text: 'Documented'),
          ],
        ),
      ),
    );
  }
}
