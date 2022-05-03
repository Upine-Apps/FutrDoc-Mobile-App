import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Shadowing.dart';
import 'legend_widget.dart';

class CreateGraph {
  BuildContext context;
  CreateGraph({required this.context});

  BarChartGroupData generateGroupData(int x, double pediatric,
      double adolescent, double adult, double geriatric) {
    var betweenSpace = 0;
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      showingTooltipIndicators: [
        // pediatric, adolescent, adult, geriatric
        3
      ],
      barsSpace: 20,
      barRods: [
        BarChartRodData(
          //Pediatric
          toY: pediatric, //hours
          color: AppColors.futrdocGreen,
          width: 5,
        ),
        BarChartRodData(
          //Adolescent
          fromY: pediatric + betweenSpace,
          toY: pediatric + betweenSpace + adolescent,
          color: AppColors.lighterBlue,
          width: 5,
        ),
        BarChartRodData(
          //Adult
          fromY: pediatric + betweenSpace + adolescent + betweenSpace,
          toY: pediatric + betweenSpace + adolescent + betweenSpace + adult,
          color: AppColors.futrdocPurple,
          width: 5,
        ),
        BarChartRodData(
          //Geriatric
          fromY: pediatric +
              betweenSpace +
              adolescent +
              betweenSpace +
              adult +
              betweenSpace,
          toY: pediatric +
              betweenSpace +
              adolescent +
              betweenSpace +
              adult +
              betweenSpace +
              geriatric,
          color: AppColors.offWhite,
          width: 5,
        ),
        BarChartRodData(
          //Geriatric
          fromY: pediatric +
              betweenSpace +
              adolescent +
              betweenSpace +
              adult +
              betweenSpace,
          toY: pediatric +
              betweenSpace +
              adolescent +
              betweenSpace +
              adult +
              betweenSpace +
              geriatric,
          color: AppColors.futrdocRed,
          width: 5,
        ),
      ],
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = "JAN";
        break;
      case 1:
        text = "FEB";
        break;
      case 2:
        text = "MAR";
        break;
      case 3:
        text = "APR";
        break;
      case 4:
        text = "MAY";
        break;
      case 5:
        text = "JUN";
        break;
      case 6:
        text = "JUL";
        break;
      case 7:
        text = "AUG";
        break;
      case 8:
        text = "SEP";
        break;
      case 9:
        text = "OCT";
        break;
      case 10:
        text = "NOV";
        break;
      case 11:
        text = "DEC";
        break;
      default:
        text = "";
    }
    return Padding(
      child: Text(
        text,
        style: TextStyle(
            color: AppColors.primaryDARK, fontSize: 14, fontFamily: 'Share'),
      ),
      padding: const EdgeInsets.only(
        top: 4,
      ),
    );
  }

  List<Legend> getLegendList(Map<String, dynamic> dashboardData) {
    List<Legend> legendList = [];
    List<String> patientList = [];
    Map<String, Color> legendColors = {
      'Pediatric': AppColors.futrdocGreen,
      'Adolescent': AppColors.lighterBlue,
      'Adult': AppColors.futrdocPurple,
      'Geriatric': AppColors.futrdocRed,
    };
    var isPediatric = false;
    Set<String> patientTypes = Set();
    for (var month in dashboardData.keys) {
      for (var patientType in dashboardData[month].keys) {
        if (patientType == 'Pediatric') isPediatric = true;
        patientTypes.add(patientType);
      }
    }
    patientList = patientTypes.toList();
    patientList.sort();
    if (isPediatric) {
      var sortedPatientList = [
        "Pediatric",
        ...patientList.sublist(0, patientList.length - 1)
      ];
      patientList = sortedPatientList;
    }

    for (var i = 0; i < patientList.length; i++) {
      legendList.add(Legend(patientList[i], legendColors[patientList[i]]!));
    }
    return (legendList);
  }

  List<BarChartGroupData> generateBarData(Map<String, dynamic> dashboardData) {
    List<BarChartGroupData> barGroups = [];
    List<Map<String, dynamic>> monthData = [];
    double pediatric = 0;
    double adolescent = 0;
    double adult = 0;
    double geriatric = 0;
    for (var month in dashboardData.keys) {
      pediatric = 0;
      adolescent = 0;
      adult = 0;
      geriatric = 0;
      for (var patientType in dashboardData[month].keys) {
        if (patientType == 'Pediatric')
          pediatric = dashboardData[month][patientType].toDouble();
        if (patientType == 'Adolescent')
          adolescent = dashboardData[month][patientType].toDouble();
        if (patientType == 'Adult')
          adult = dashboardData[month][patientType].toDouble();
        if (patientType == 'Geriatric')
          geriatric = dashboardData[month][patientType].toDouble();
      }
      monthData.add({
        'Month': getMonthIndex(month),
        'Pediatric': pediatric,
        'Adolescent': adolescent,
        'Adult': adult,
        'Geriatric': geriatric
      });
    }
    monthData.sort((a, b) => a['Month'].compareTo(b['Month']));
    for (var month in monthData) {
      barGroups.add(generateGroupData(month['Month'], month['Pediatric'],
          month['Adolescent'], month['Adult'], month['Geriatric']));
    }
    // {month: apr, ped: 0, ado: 4, adu: 6, ger: 0}
    return barGroups;
  }

  int getMonthIndex(String month) {
    int x = 0;
    switch (month) {
      case 'January':
        x = 0;
        return x;
      case 'February':
        x = 1;
        return x;
      case 'March':
        x = 2;
        return x;
      case 'April':
        x = 3;
        return x;
      case 'May':
        x = 4;
        return x;
      case 'June':
        x = 5;
        return x;
      case 'July':
        x = 6;
        return x;
      case 'August':
        x = 7;
        return x;
      case 'September':
        x = 8;
        return x;
      case 'October':
        x = 9;
        return x;
      case 'November':
        x = 10;
        return x;
      case 'December':
        x = 11;
        return x;
      default:
        x = 0;
        return x;
    }
  }
}
