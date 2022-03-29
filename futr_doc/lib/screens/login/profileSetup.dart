import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customElevatedButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customTextFormField.dart';
import 'package:futr_doc/custom-widgets/text-field/customYearField.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/screens/login/walkthrough.dart';

import '../../service/userService.dart';

class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final _profileSetupFormKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _schoolYearController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();

  String first_name = '';
  String last_name = '';
  String school_year = '';
  String degree = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          body: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              child: SingleChildScrollView(
                child: Form(
                  key: _profileSetupFormKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      Text(
                        'Tell me about yourself!',
                        style: Theme.of(context).textTheme.headline2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * .05,
                      ),
                      Text(
                        'C\'mon, don\'t be shy!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * .1),
                      CustomTextFormField(
                        controller: _firstNameController,
                        onEditingComplete: () {},
                        onChanged: (val) {
                          setState(() {
                            first_name = val!;
                          });
                        },
                        labelText: 'FIRST NAME',
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      CustomTextFormField(
                          controller: _lastNameController,
                          onEditingComplete: () {},
                          onChanged: (val) {
                            setState(() {
                              last_name = val!;
                            });
                          },
                          labelText: 'LAST NAME'),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      CustomYearField(
                        controller: _schoolYearController,
                        onEditingComplete: () {},
                        onChanged: (val) {
                          setState(() {
                            school_year = val!;
                          });
                        },
                        labelText: 'YEAR IN SCHOOL',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .025),
                      CustomTextFormField(
                        controller: _degreeController,
                        onEditingComplete: () {},
                        onChanged: (val) {
                          setState(() {
                            degree = val!;
                          });
                        },
                        labelText: 'DEGREE',
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * .15),
                      CustomElevatedButton(
                        onPressed: () async {
                          if (_profileSetupFormKey.currentState!.validate()) {
                            var response = await UserService.instance
                                .updateUser(first_name, last_name, school_year,
                                    degree, context);
                            if (response['status'] == true) {
                              clearControllers();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Walkthrough()));
                            } // do we need to put else statement?
                          }
                        },
                        text: 'Complete',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void clearControllers() {
    _firstNameController.clear();
    _lastNameController.clear();
    _degreeController.clear();
    _schoolYearController.clear();
  }
}
