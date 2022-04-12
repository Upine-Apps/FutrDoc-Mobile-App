import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/custom-widgets/customToast.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';
import 'package:futr_doc/custom-widgets/text-field/customYearField.dart';
import 'package:futr_doc/models/types/UserUpdateBody.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/screens/login/walkthrough.dart';
import 'package:provider/provider.dart';

import '../../models/Shadowing.dart';
import '../../models/User.dart';
import '../../providers/ShadowingProvider.dart';
import '../../providers/UserProvider.dart';
import '../../service/userService.dart';
import '../../theme/appColor.dart';

class ShadowingRecap extends StatefulWidget {
  @override
  _ShadowingRecapState createState() => _ShadowingRecapState();
}

class _ShadowingRecapState extends State<ShadowingRecap> {
  final _profileSetupFormKey = GlobalKey<FormState>();
  final TextEditingController _locationController =
      TextEditingController(text: 'Hope Family Health Center');
  final TextEditingController _durationController =
      TextEditingController(text: '1:25');
  final TextEditingController _activityController =
      TextEditingController(text: 'Reviewed');
  final TextEditingController _patientTypeController =
      TextEditingController(text: 'Adolescence');

  bool isSpinner = false;

  var experience = ['Cavity Assessment', 'Tooth Extraction', 'Tooth Cleaning'];

  @override
  Widget build(BuildContext context) {
    final Shadowing lastShadowing =
        context.read<ShadowingProvider>().lastShadowing;
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text(
                    'Recap',
                    style: Theme.of(context).textTheme.headline2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  CustomTextFormField(
                    controller: _locationController,
                    enabled: false,
                    onEditingComplete: () {},
                    onChanged: (val) {},
                    labelText: lastShadowing.clinic_name!,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  CustomTextFormField(
                      controller: _durationController,
                      enabled: false,
                      onEditingComplete: () {},
                      onChanged: (val) {},
                      labelText: '${lastShadowing.duration} mins'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .025,
                  ),
                  CustomTextFormField(
                      enabled: false,
                      controller: _activityController,
                      onEditingComplete: () {},
                      onChanged: (val) {},
                      labelText: lastShadowing.activity!),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  CustomTextFormField(
                    enabled: false,
                    controller: _patientTypeController,
                    onEditingComplete: () {},
                    onChanged: (val) {},
                    labelText: lastShadowing.patient_type!,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .025),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text('EXPERIENCE',
                          style: Theme.of(context).textTheme.bodyText2,
                          textAlign: TextAlign.left)),
                  SizedBox(height: MediaQuery.of(context).size.height * .01),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.all(0),
                      itemCount: experience.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          dense: true,
                          title: Text(
                            experience[index],
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearControllers() {
    _locationController.clear();
    _durationController.clear();
    _activityController.clear();
    _patientTypeController.clear();
  }
}
