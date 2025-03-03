import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/buttons/customTextButton.dart';
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
import '../../custom-widgets/customToast.dart';
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
  Shadowing recentShadowing = Shadowing.emptyShadowingObject();
  String hours = '0';
  OverviewBody overview = OverviewBody.emptyOverviewBody();
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var shadowingJson =
          await ShadowingService.instance.getRecentShadowing(context);
      if (shadowingJson['status'] == true) {
        setState(() {
          recentShadowing = Shadowing.jsonToShadowing(shadowingJson['body']);
          hours = durationToString(int.parse(recentShadowing.duration!));
        });
      }
      var overviewResult = await ShadowingService.instance.getOverview(context);
      if (overviewResult['body'] != null) {
        setState(() {
          overview = OverviewBody.jsonToOverview(overviewResult['body']);
        });
      }
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
                    SizedBox(height: MediaQuery.of(context).size.height * .025),
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
                        if (hours != '0') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShadowingListScreen()));
                        } else {
                          CustomToast.showDialog(
                              'Add a shadowing first', context);
                        }
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
                                  hours,
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
                                    hours != '0'
                                        ? 'Completed on ${recentShadowing.date} at \n${recentShadowing.clinic_name?.split(',')[0]}'
                                        : 'No shadowing sessions completed',
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
                            if (hours != '0') {
                              print(
                                  context.read<ShadowingProvider>().shadowings);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Dashboard()));
                            } else {
                              CustomToast.showDialog(
                                  'Add a shadowing first', context);
                            }
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
                                      child: Text('Total Hours Completed',
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
                                      child: Text('Monthly Hours',
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
                                            overview.topClinic.length > 20
                                                ? '${overview.topClinic.substring(0, 20)}...'
                                                : overview.topClinic,
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
                                      child: Text('Top Clinic',
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settings()));
                        },
                        elevation: 0,
                        text: 'Settings',
                        textColor: AppColors.offWhite,
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
