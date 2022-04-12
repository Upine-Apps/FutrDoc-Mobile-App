import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/models/Shadowing.dart';
import 'package:futr_doc/providers/ShadowingProvider.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customImage.dart';
import '../../models/User.dart';
import '../../providers/UserProvider.dart';
import '../../theme/appColor.dart';
import '../settings/settings.dart';
import '../shadowing/shadowingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    final shadowing = new Shadowing();
    final User user = context.read<UserProvider>().user;
    return WillPopScope(
      onWillPop: () async => false,
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .1),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Welcome back, \n${user.first_name}!',
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.left),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('You have 5 shadowing hours today',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Row(
                      children: [
                        Text('Shadowing',
                            style: Theme.of(context).textTheme.bodyText1),
                        Spacer(),
                        CustomElevatedButton(
                          elevation: 0,
                          onPressed: () {
                            context
                                .read<ShadowingProvider>()
                                .addToShadowings(shadowing);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShadowingScreen()));
                          },
                          text: 'Add',
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .025,
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1.5,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '3 Hours',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .01,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  'Completed yesterday at \nHope Family Center',
                                  style: Theme.of(context).textTheme.headline5),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Row(
                      children: [
                        Text('Data Dashboard',
                            style: Theme.of(context).textTheme.bodyText1),
                        Spacer(),
                        CustomElevatedButton(
                          onPressed: () {},
                          elevation: 0,
                          text: 'View',
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .025,
                        )
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .01),
                    Row(
                      children: [
                        Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * .3525,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('296',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4)),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          'Total shadowing \nhours completed',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * .3525,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('17',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4)),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Monthly hours',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * .3525,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('2',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4)),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Specialities',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * .3525,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text('5',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4)),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .01,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Differrent shadowing',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {},
                        text: 'FutrDoc Report (PDF)',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.grey),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {},
                        text: 'Find Opportunities',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.grey),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {},
                        text: 'Resources',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.grey),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        onPressed: () {},
                        elevation: 0,
                        text: 'Blog Posts',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.grey),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        elevation: 0,
                        text: 'Settings',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.grey),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
