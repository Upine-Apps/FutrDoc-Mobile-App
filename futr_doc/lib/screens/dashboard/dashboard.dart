import "package:flutter/material.dart";

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../theme/appColor.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<String> clinicNames = [
    'Apple Bees'
        'Chilis',
    'Lubys',
    'On The Border'
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
            body: Align(
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * .1,
                            ),
                            Text(
                              'Since January 2022, you completed a total of 100 Shadowing Hours, nice!',
                              style: Theme.of(context).textTheme.headline3,
                              textAlign: TextAlign.center,
                            )
                          ],
                        )),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    // Filter Box
                    Container(
                        width: MediaQuery.of(context).size.width * .9,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: CustomElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: EdgeInsets.all(20),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1,
                                        color: Theme.of(context).primaryColor,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Clinic Name',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                child: Card(
                                                  color: AppColors.lightGrey,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: ListView.builder(
                                                       physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.all(0),
                                                      itemCount:
                                                          clinicNames.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CheckboxListTile(
                                                          value: false,
                                                          onChanged: (val) {},
                                                          title: Text(
                                                              clinicNames[index],
                                                              style: Theme.of(context).textTheme.bodyText2),
                                                        );
                                                      },
                                                    )),
                                              ),
                                              SizedBox(height: 10,),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Clinic Name',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                child: Card(
                                                  color: AppColors.lightGrey,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.all(0),
                                                      itemCount:
                                                          clinicNames.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CheckboxListTile(
                                                          value: false,
                                                          onChanged: (val) {},
                                                          title: Text(
                                                              clinicNames[index],
                                                              style: Theme.of(context).textTheme.bodyText2),
                                                        );
                                                      },
                                                    )),
                                              ),
                                              SizedBox(height: 10,),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  'Clinic Name',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1,
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    1,
                                                child: Card(
                                                  color: AppColors.lightGrey,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    elevation: 10,
                                                    child: ListView.builder(
                                                       physics: NeverScrollableScrollPhysics(),
                                                      padding: EdgeInsets.all(0),
                                                      itemCount:
                                                          clinicNames.length,
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return CheckboxListTile(
                                                          value: false,
                                                          onChanged: (val) {},
                                                          title: Text(
                                                              clinicNames[index],
                                                              style: Theme.of(context).textTheme.bodyText2),
                                                        );
                                                      },
                                                    )),
                                              ),
                                              SizedBox(height: 10,),
                                              CustomElevatedButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                text: 'Done',
                                                elevation: 0,
                                                width: MediaQuery.of(context).size.width * .2,
                                                height:
                                                  MediaQuery.of(context).size.height * .025,
                                        
                                              ),
                                              SizedBox(height: 30,),
                                             
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                elevation: 0,
                                text: 'Filter',
                                width: MediaQuery.of(context).size.width * .2,
                                height:
                                    MediaQuery.of(context).size.height * .025,
                              ),
                            )
                          ],
                        )),
                  ],
                )))));
  }
}
