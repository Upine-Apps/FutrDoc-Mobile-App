import 'package:flutter/material.dart';
import 'package:futr_doc/custom-widgets/customDropDown.dart';
import 'package:futr_doc/theme/appColor.dart';

class ShadowingDuration extends StatefulWidget {
  @override
  _ShadowingDurationState createState() => _ShadowingDurationState();
}

class _ShadowingDurationState extends State<ShadowingDuration> {
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
              'How long did you shadow?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                width: MediaQuery.of(context).size.width * .3,
                height: MediaQuery.of(context).size.height * .17,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .04,
                      decoration: BoxDecoration(
                          color: AppColors.lighterBlue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Center(
                        child: Text(
                          'HOURS',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width * .175,
                        height: MediaQuery.of(context).size.height * .125,
                        child: Center(
                          child: CustomDropDown(
                            textStyle: Theme.of(context).textTheme.headline2,
                            initialValue: '00',
                            items: [
                              '00',
                              '01',
                              '02',
                              '03',
                              '04',
                            ],
                            labelText: '',
                            onChanged: (val) => {print(val)},
                          ),
                        )),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(width: 20, height: 30),
                  Container(
                    width: 20,
                    height: 70,
                    child: Center(
                      child: Text(
                        ':',
                        style: TextStyle(fontFamily: 'Share', fontSize: 34),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      color: AppColors.lightGrey,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  width: MediaQuery.of(context).size.width * .3,
                  height: MediaQuery.of(context).size.height * .17,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .04,
                        decoration: BoxDecoration(
                            color: AppColors.lighterBlue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Center(
                          child: Text(
                            'MINUTES',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width * .175,
                        height: MediaQuery.of(context).size.height * .125,
                        child: Center(
                          child: CustomDropDown(
                            textStyle: Theme.of(context).textTheme.headline2,
                            initialValue: '00',
                            items: [
                              '00',
                              '15',
                              '30',
                              '45',
                            ],
                            labelText: '',
                            onChanged: (val) => {print(val)},
                          ),
                        ),
                      )
                    ],
                  )),
            ])
          ],
        ),
      ),
    );
  }
}
