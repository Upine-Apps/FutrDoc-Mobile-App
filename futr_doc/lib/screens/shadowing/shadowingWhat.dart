import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:provider/provider.dart';

import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';

class ShadowingWhat extends StatefulWidget {
  @override
  _ShadowingWhatState createState() => _ShadowingWhatState();
}

class _ShadowingWhatState extends State<ShadowingWhat> {
  @override
  void initState() {
    setState(() {
      bool isSelected1 = false;
      bool isSelected2 = false;
      bool isSelected3 = false;
      bool isSelected4 = false;
    });
  }

  saveActivity(String activity) {
    Shadowing lastShadowing = context.read<ShadowingProvider>().lastShadowing;
    lastShadowing.activity = activity;
    context.read<ShadowingProvider>().setLastShadowing(lastShadowing);
  }

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  String button1Text = 'Observed';
  String button2Text = 'Reviewed';
  String button3Text = 'Discussed';
  String button4Text = 'Documented';

//Configure all of this in the backend and get with a call ^^

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
              color: isSelected1 == true ? AppColors.lighterBlue : null,
              onPressed: () {
                setState(() {
                  isSelected1 = true;
                  isSelected2 = false;
                  isSelected3 = false;
                  isSelected4 = false;
                });
                saveActivity(button1Text);
              },
              text: button1Text,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
              width: MediaQuery.of(context).size.width * .75,
              height: MediaQuery.of(context).size.height * .05,
              color: isSelected2 == true ? AppColors.lighterBlue : null,
              onPressed: () {
                setState(() {
                  isSelected2 = true;
                  isSelected1 = false;
                  isSelected3 = false;
                  isSelected4 = false;
                });
                saveActivity(button2Text);
              },
              text: button2Text,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                color: isSelected3 == true ? AppColors.lighterBlue : null,
                onPressed: () {
                  setState(() {
                    isSelected3 = true;
                    isSelected1 = false;
                    isSelected2 = false;
                    isSelected4 = false;
                  });
                  saveActivity(button3Text);
                },
                text: button3Text),
            SizedBox(height: MediaQuery.of(context).size.height * .025),
            CustomElevatedButton(
                width: MediaQuery.of(context).size.width * .75,
                height: MediaQuery.of(context).size.height * .05,
                color: isSelected4 == true ? AppColors.lighterBlue : null,
                onPressed: () {
                  setState(() {
                    isSelected4 = true;
                    isSelected1 = false;
                    isSelected2 = false;
                    isSelected3 = false;
                  });
                  saveActivity(button1Text);
                },
                text: button4Text),
          ],
        ),
      ),
    );
  }
}
