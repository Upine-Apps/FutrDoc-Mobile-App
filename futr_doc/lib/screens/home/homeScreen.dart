import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
import 'package:futr_doc/custom-widgets/text-field/customCodeField.dart';
import 'package:futr_doc/models/Shadowing.dart';
import 'package:futr_doc/models/types/Shadowing/OverviewBody.dart';
import 'package:futr_doc/providers/ShadowingProvider.dart';
import 'package:futr_doc/screens/account_recovery/resetPassword.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/screens/login/signUp.dart';
import 'package:futr_doc/screens/home/shadowingListScreen.dart';
import 'package:futr_doc/service/userService.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customImage.dart';
import '../../models/User.dart';
import '../../providers/UserProvider.dart';
import '../../service/shadowingService.dart';
import '../../service/utils.dart';
import '../../theme/appColor.dart';
import '../dashboard/dashboard.dart';
import '../settings/settings.dart';
import '../shadowing/shadowingScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String code = '';
  Shadowing recentShadowing = Shadowing.emptyShadowingObject();
  String hours = '';
  OverviewBody overview = OverviewBody.emptyOverviewBody();
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var shadowingJson =
          await ShadowingService.instance.getRecentShadowing(context);
      print(shadowingJson);
      setState(() {
        recentShadowing = Shadowing.jsonToShadowing(shadowingJson['body']);
      });
      var overviewResult = await ShadowingService.instance.getOverview(context);
      setState(() {
        overview = OverviewBody.jsonToOverview(overviewResult['body']);
      });

      hours = durationToString(int.parse(recentShadowing.duration!));
    });
  }

//add user context read to a post-frame callback

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
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
                            final Shadowing shadowing =
                                Shadowing.emptyShadowingObject();
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
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShadowingListScreen()));
                      },
                      child: Card(
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
                                  hours + ' Hours',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .01,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    'Completed on ${recentShadowing.date} at \n${recentShadowing.clinic_name?.split(',')[0]}',
                                    style:
                                        Theme.of(context).textTheme.headline5),
                              )
                            ],
                          ),
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
                          onPressed: () {
                            print(context.read<ShadowingProvider>().shadowings);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
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
                                        child: Text(
                                            durationToString(
                                                overview.totalDuration),
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
                                        child: Text(
                                            durationToString(
                                                overview.monthlyDuration),
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
                                        child: Text(
                                            overview.totalSpecialties
                                                .toString(),
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
                                        child: Text(
                                            overview.totalShadowingCount
                                                .toString(),
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
                                      child: Text('Total Shadowing Sessions',
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
                        color: AppColors.lighterBlue),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {},
                        text: 'Find Opportunities',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.lighterBlue),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        elevation: 0,
                        onPressed: () {},
                        text: 'Resources',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.lighterBlue),
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
                    CustomElevatedButton(
                        onPressed: () {},
                        elevation: 0,
                        text: 'Blog Posts',
                        width: MediaQuery.of(context).size.width * .75,
                        height: MediaQuery.of(context).size.height * .05,
                        color: AppColors.lighterBlue),
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
                        color: AppColors.lighterBlue),
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
