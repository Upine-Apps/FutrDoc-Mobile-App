import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:futr_doc/theme/appColor.dart';

import '../../models/Shadowing.dart';

class CreateGraph {
  BuildContext context;
  CreateGraph({required this.context});

  List<BarChartGroupData> getBarGroups() {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 8,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [
          BarChartRodData(
            toY: 10,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [
          BarChartRodData(
            toY: 14,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 3,
        barRods: [
          BarChartRodData(
            toY: 15,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 4,
        barRods: [
          BarChartRodData(
            toY: 13,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
      BarChartGroupData(
        x: 5,
        barRods: [
          BarChartRodData(
            toY: 10,
            gradient: getBarGradient(),
          )
        ],
        showingTooltipIndicators: [0],
      ),
    ];
  }

  BarTouchData getBarTouchData() => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(rod.toY.round().toString(),
                Theme.of(context).textTheme.bodyText2!);
          },
        ),
      );

  LinearGradient getBarGradient() {
    return LinearGradient(
      colors: [Theme.of(context).secondaryHeaderColor, AppColors.lighterBlue],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
    );
  }

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  FlTitlesData getTitlesData() => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Jan';
        break;
      case 1:
        text = 'Feb';
        break;
      case 2:
        text = 'Mar';
        break;
      case 3:
        text = 'Apr';
        break;
      case 4:
        text = 'May';
        break;
      case 5:
        text = 'Jun';
        break;
      case 6:
        text = 'Jul';
        break;
      case 7:
        text = 'Aug';
        break;
      case 8:
        text = 'Sep';
        break;
      case 9:
        text = 'Oct';
        break;
      case 10:
        text = 'Nov';
        break;
      case 11:
        text = 'Dec';
        break;
      default:
        text = '';
        break;
    }
    return Center(
        child: Text(text, style: Theme.of(context).textTheme.headline6));
  }

  double calculateHeight(int monthlyHours, int totalHours, int maxHeight) {
    return ((monthlyHours / totalHours) * maxHeight);
  }
}
