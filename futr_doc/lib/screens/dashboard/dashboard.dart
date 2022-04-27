import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import "package:flutter/material.dart";
import 'package:futr_doc/screens/dashboard/createGraph.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../custom-widgets/buttons/customElevatedButton.dart';
import '../../custom-widgets/customToast.dart';
import '../../models/ICD.dart';
import '../../models/types/Shadowing/DataDashboardBody.dart';
import '../../service/shadowingService.dart';
import '../../service/utils.dart';
import '../../theme/appColor.dart';
import '../../theme/colors.dart';
import 'legend_widget.dart';

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
          await ShadowingService.instance.getDataDashboard(context, {
        "start_date": '',
        "end_date": '',
        "clinic_name": '',
        "patient_type": '',
        "icd10": json.encode([]),
      });
      var filterDataResult =
          await ShadowingService.instance.getFilterData(context);
      // print(filterDataResult);
      setState(() {
        textData =
            DataDashboardBody.jsonToDataDashboard(textDataResult['body']);
        totalDuration = durationToString(textData.totalDuration);
        var dateString =
            '${textData.firstShadowingMonth} 1, ${textData.firstShadowingYear}';
        DateFormat format = new DateFormat('MMMM dd, yyyy');
        earliestDate = format.parse(dateString);
        // set filter data
        clinicNames = filterDataResult['body']['clinicName'];
        patientTypes = filterDataResult['body']['patientType'];
        addIcdToList(filterDataResult['body']['icd']);
      });
    });
  }

  addIcdToList(var icdList) {
    for (var x = 0; x < icdList.length; x++) {
      setState(() {
        icd10s.add(icdList[x]);
        icd10s[x]['isSelected'] = false;
      });
    }
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
  List<dynamic> selectedIcd10s = [];
  Map<String, dynamic> dashboardData = {};
  double maxYrange = 1000;
  String displayClinicname = '';

  // graph shit
  static const pilateColor = Color(0xff632af2);
  static const cyclingColor = Color(0xffffb3ba);
  static const quickWorkoutColor = Color(0xff578eff);
  static const betweenSpace = 0.2;

  var icd;
  DateTime earliestDate = DateTime.now();

  List<dynamic> icd10s = [];

  List<dynamic> clinicNames = [];

  List<dynamic> patientTypes = [];

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
                          'Since ${textData.firstShadowingMonth} ${textData.firstShadowingYear}, you completed a total of ${totalDuration} of Shadowing Hours, nice!',
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
                                              elevation: 0,
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
                                                          if (selectedStartDate !=
                                                                  '' &&
                                                              selectedEndDate !=
                                                                  '') {}
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
                                              elevation: 0,
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
                                              elevation: 0,
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
                                                elevation: 0,
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
                                                          Expanded(
                                                            child: Text(
                                                              icd10s[index]
                                                                  ['name'],
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .primaryDARK,
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      'Share'),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                          ),
                                                          Text(
                                                              icd10s[index]
                                                                  ['icd'],
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
                            ).whenComplete(() async {
                              List<Map<String, String>> jsonIcds = [];
                              List<dynamic> dynamicIcds = icd10s
                                  .where((icd10) => icd10['isSelected'] == true)
                                  .toList();
                              for (var x = 0; x < dynamicIcds.length; x++) {
                                dynamicIcds[x].removeWhere(
                                    (key, value) => key == 'isSelected');
                              }
                              ;
                              var result = await ShadowingService.instance
                                  .getDataDashboard(context, {
                                "start_date": selectedStartDate,
                                "end_date": selectedEndDate,
                                "clinic_name": selectedClinicName,
                                "patient_type": selectedPatientType,
                                "icd10": json.encode(dynamicIcds),
                              });
                              for (var i = 0; i < icd10s.length; i++) {
                                setState(() {
                                  icd10s[i]['isSelected'] = false;
                                });
                              }
                              setState(() {
                                if (selectedClinicName == '') {
                                  displayClinicname = selectedClinicName!;
                                } else {
                                  displayClinicname = selectedClinicName!;
                                }

                                selectedClinicName = '';
                                selectedPatientType = '';
                                selectedStartDate = '';
                                selectedEndDate = '';
                                dashboardData =
                                    result['body']['filteredDashboardData'];
                                maxYrange = result['body']['totalDuration'] + 500;
                              });
                            });
                          },
                          elevation: 0,
                          text: 'Filter',
                          width: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .035,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .025,
                      ),
                      dashboardData.isEmpty
                          ? Text('Select a filter to generate a chart')
                          : Container(
                              // height: MediaQuery.of(context).size.height * .5,
                              // width: MediaQuery.of(context).size.width * 1,
                              child: Card(
                                 color: 
                                    AppColors.lightGrey,
                                    
                               
                                elevation: 4,
                                 shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                      'Shadowing Data in Minutes',
                                      style: Theme.of(context).textTheme.headline5,
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * .025),
                                      Row(
                                      children: [
                                        Text(
                                      'Clinic: ',
                                      style: Theme.of(context).textTheme.headline5,
                                        ),
                                        Expanded(child: Text(
                                      displayClinicname == ''
                                          ? 'All'
                                          : displayClinicname.split(',')[0],
                                      style: Theme.of(context).textTheme.headline5,
                                        ))
                                      ],
                                      ),
                                      
                                      SizedBox(height: MediaQuery.of(context).size.height * .025),
                                      LegendsListWidget(
                                        legends: createGraph
                                            .getLegendList(dashboardData),
                                        //Legend(String, color)
                                        // {status: true, body: {filteredDashboardData: {April: {Adult: 180}, March: {Adolescent: 420, Adult: 120}}, firstShadowingMonth: March, firstShadowingYear: 2022, totalDuration: 1830}}
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * .075),
                                      AspectRatio(
                                        aspectRatio:1.5,
                                        child: BarChart(
                                          BarChartData(
                                              alignment: BarChartAlignment
                                                  .spaceEvenly,
                                              titlesData: FlTitlesData(
                                                leftTitles: AxisTitles(),
                                                rightTitles: AxisTitles(),
                                                topTitles: AxisTitles(),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitlesWidget:
                                                        createGraph
                                                            .bottomTitles,
                                                    reservedSize: 22,
                                                  ),
                                                ),
                                              ),
                                              barTouchData: BarTouchData(
                                                  enabled: false),
                                              borderData:
                                                  FlBorderData(show: false),
                                              gridData:
                                                  FlGridData(show: false),
                                              barGroups:
                                                  createGraph.generateBarData(
                                                      dashboardData),
                                              maxY: maxYrange),
                                        ),
                                      ),
                                    ],
                                  ),
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
