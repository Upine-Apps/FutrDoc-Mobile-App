import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:provider/provider.dart';

import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';

class ShadowingPatientType extends StatefulWidget {
  @override
  _ShadowingPatientTypeState createState() => _ShadowingPatientTypeState();
}

class _ShadowingPatientTypeState extends State<ShadowingPatientType>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    setState(() {
      bool isSelected1 = false;
      bool isSelected2 = false;
      bool isSelected3 = false;
      bool isSelected4 = false;
    });
  }

  savePatientType(String patientType) {
    Shadowing lastShadowing = context.read<ShadowingProvider>().lastShadowing;
    lastShadowing.patient_type = patientType;
    context.read<ShadowingProvider>().setLastShadowing(lastShadowing);
  }

  bool isSelected1 = false;
  bool isSelected2 = false;
  bool isSelected3 = false;
  bool isSelected4 = false;

  String button1Text = 'Pediatric';
  String button2Text = 'Adolescent';
  String button3Text = 'Adult';
  String button4Text = 'Geriatric';

  @override
  Widget build(BuildContext context) {
    print(DateTime.now());
    super.build(context);
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
              color: isSelected1 == true ? AppColors.lighterBlue : null,
              onPressed: () {
                setState(() {
                  isSelected1 = true;
                  isSelected2 = false;
                  isSelected3 = false;
                  isSelected4 = false;
                });
                final Shadowing? shadowing =
                    context.read<ShadowingProvider>().lastShadowing;
                final List<Shadowing> shadowings =
                    context.read<ShadowingProvider>().shadowings;
                print(shadowing!.clinic_name);
                print(shadowing.date);
                print(shadowing.duration);
                print(shadowing.activity);
                print(shadowing.patient_type);
                print(shadowing.icd10);
                savePatientType(button1Text);
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
                savePatientType(button2Text);
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
                  savePatientType(button3Text);
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
                  savePatientType(button4Text);
                },
                text: button4Text),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
