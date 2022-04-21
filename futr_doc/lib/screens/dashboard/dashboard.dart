import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:futr_doc/screens/dashboard/createGraph.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customToast.dart';
import '../../models/types/Shadowing/DataDashboardBody.dart';
import '../../service/shadowingService.dart';
import '../../service/utils.dart';
import '../../theme/appColor.dart';
import '../../theme/colors.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  void initState() {
    super.initState();
    getTheme();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var textDataResult =
          await ShadowingService.instance.getDataDashboard(context, {});
      setState(() {
        textData =
            DataDashboardBody.jsonToDataDashboard(textDataResult['body']);
        totalDuration = durationToString(textData.totalDuration);
        var dateString =
            '${textData.firstShadowingMonth} 1, ${textData.firstShadowingYear}';
        DateFormat format = new DateFormat('MMMM dd, yyyy');
        earliestDate = format.parse(dateString);
      });
    });
    print(textData);
  }

  getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      theme = prefs.getString('Theme') ?? 'Light';
    });
  }

  String theme = '';
  DataDashboardBody textData = DataDashboardBody.emptyDataDashboardBody();
  String? start_date = '';
  String? end_date = '';
  String? patient_type = '';
  String? clinic_name = '';
  String? totalDuration = '';

  String? selectedClinicName = '';
  String? selectedPatientType = '';
  String selectedStartDate = '';
  String selectedEndDate = '';

  var icd;
  DateTime earliestDate = DateTime.now();

  List<dynamic> icd10s = [
    {"name": "Tuberculosis of heart", "code": "A18.84", "isSelected": false},
    {"name": "Precordial pain", "code": "R07.2", "isSelected": false},
    {"name": "Bone graft failure", "code": "M62.81", "isSelected": false},
  ];

  List<String> clinicNames = [
    'CareNow Urgent Care',
    'Baylor Scott & White',
    'Harris Methodist Hospital',
    'Houston Methodist Hospital',
  ];

  List<String> patientTypes = [
    'Pediatric',
    'Adolescent',
    'Adult',
    'Geriatric',
  ];

  @override
  Widget build(BuildContext context) {
    CreateGraph createGraph = new CreateGraph(context: context);
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .075,
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .05),
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios,
                          color: Theme.of(context).secondaryHeaderColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Container(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          'Since ${textData.firstShadowingMonth} ${textData.firstShadowingYear}, you completed a total of ${totalDuration} Shadowing Hours, nice!',
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
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    height:
                                        MediaQuery.of(context).size.height * 1,
                                    color: Theme.of(context).primaryColor,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                'Date Range',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              )),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Card(
                                              elevation: 10,
                                              color: AppColors.lightGrey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.all(20),
                                                child: Column(children: [
                                                  Row(children: [
                                                    Text('Start Date',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryDARK,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Share')),
                                                    Spacer(),
                                                    Text('End Date',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryDARK,
                                                            fontSize: 16,
                                                            fontFamily:
                                                                'Share')),
                                                  ]),
                                                  Row(children: [
                                                    CustomElevatedButton(
                                                      color:
                                                          AppColors.lighterBlue,
                                                      textColor:
                                                          AppColors.offWhite,
                                                      elevation: 0,
                                                      onPressed: () async {
                                                        DateTime? date =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    earliestDate,
                                                                lastDate:
                                                                    DateTime
                                                                        .now());
                                                        if (selectedEndDate !=
                                                                '' &&
                                                            DateTime.parse(
                                                                    selectedEndDate)
                                                                .isBefore(
                                                                    date!)) {
                                                          CustomToast
                                                              .showDialog(
                                                            "Your start date must be before your end date",
                                                            context,
                                                          );
                                                        } else {
                                                          setState(() {
                                                            selectedStartDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        date!);
                                                          });
                                                        }
                                                      },
                                                      text: selectedStartDate ==
                                                              ''
                                                          ? 'Select Start Date'
                                                          : selectedStartDate
                                                              .split(' ')[0],
                                                    ),
                                                    Spacer(),
                                                    CustomElevatedButton(
                                                      color:
                                                          AppColors.lighterBlue,
                                                      textColor:
                                                          AppColors.offWhite,
                                                      elevation: 0,
                                                      onPressed: () async {
                                                        DateTime? date =
                                                            await showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    DateTime
                                                                        .now(),
                                                                firstDate:
                                                                    earliestDate,
                                                                lastDate:
                                                                    DateTime
                                                                        .now());
                                                        if (selectedStartDate !=
                                                                '' &&
                                                            DateTime.parse(
                                                                    selectedStartDate)
                                                                .isAfter(
                                                                    date!)) {
                                                          CustomToast
                                                              .showDialog(
                                                            "Your end date must be after your start date",
                                                            context,
                                                          );
                                                        } else {
                                                          setState(() {
                                                            selectedEndDate =
                                                                DateFormat(
                                                                        'yyyy-MM-dd')
                                                                    .format(
                                                                        date!);
                                                          });
                                                        }
                                                      },
                                                      text: selectedEndDate ==
                                                              ''
                                                          ? 'Select End Date'
                                                          : selectedEndDate
                                                              .split(' ')[0],
                                                    ),
                                                  ]),
                                                ]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Clinic Name',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Card(
                                              elevation: 10,
                                              color: AppColors.lightGrey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  ...clinicNames.map(
                                                    (clinicName) {
                                                      return RadioListTile<
                                                          String>(
                                                        activeColor: AppColors
                                                            .primaryDARK,
                                                        title: Text(clinicName,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryDARK,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Share')),
                                                        groupValue:
                                                            selectedClinicName,
                                                        value: clinicName,
                                                        onChanged: (newValue) {
                                                          setState(
                                                            () {
                                                              selectedClinicName =
                                                                  newValue;
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ).toList(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Patient Type',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Card(
                                              elevation: 10,
                                              color: AppColors.lightGrey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  ...patientTypes.map(
                                                    (patientType) {
                                                      return RadioListTile<
                                                          String>(
                                                        activeColor: Theme.of(
                                                                context)
                                                            .secondaryHeaderColor,
                                                        title: Text(patientType,
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryDARK,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Share')),
                                                        groupValue:
                                                            selectedPatientType,
                                                        value: patientType,
                                                        onChanged: (newValue) {
                                                          setState(
                                                            () {
                                                              selectedPatientType =
                                                                  newValue;
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ).toList(),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Experiences',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            child: Card(
                                                color: AppColors.lightGrey,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                elevation: 10,
                                                child: ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  padding: EdgeInsets.all(0),
                                                  itemCount: icd10s.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return CheckboxListTile(
                                                      activeColor:
                                                          AppColors.primaryDARK,
                                                      checkColor:
                                                          AppColors.offWhite,
                                                      side: BorderSide(
                                                          color: AppColors
                                                              .primaryDARK,
                                                          width: 2),
                                                      controlAffinity:
                                                          ListTileControlAffinity
                                                              .leading,
                                                      value: icd10s[index]
                                                          ['isSelected'],
                                                      onChanged: (val) {
                                                        setState(() {
                                                          icd10s[index][
                                                                  'isSelected'] =
                                                              !icd10s[index][
                                                                  'isSelected'];
                                                        });
                                                      },
                                                      title: Row(
                                                        children: [
                                                          Text(
                                                            icd10s[index]
                                                                ['name'],
                                                            style: TextStyle(
                                                                color: AppColors
                                                                    .primaryDARK,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Share'),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                              icd10s[index]
                                                                  ['code'],
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .primaryDARK,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Share')),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                )),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          CustomElevatedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            text: 'Done',
                                            elevation: 0,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .035,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                            );
                          },
                          elevation: 0,
                          text: 'Filter',
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .035,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .015,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width * 1,
                        child: Card(
                          color: theme == 'Dark'
                              ? AppColors.transparentGray
                              : AppColors.lightGrey,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: BarChart(
                            BarChartData(
                                barTouchData: createGraph.getBarTouchData(),
                                titlesData: createGraph.getTitlesData(),
                                borderData: createGraph.borderData,
                                barGroups: createGraph.getBarGroups(),
                                gridData: FlGridData(show: false),
                                alignment: BarChartAlignment.spaceAround,
                                maxY: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
