import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../models/Shadowing.dart';
import '../../providers/ShadowingProvider.dart';
import '../../theme/appColor.dart';
import './calendar-utils.dart';

class ShadowingWhen extends StatefulWidget {
  @override
  _ShadowingWhenState createState() => _ShadowingWhenState();
}

class _ShadowingWhenState extends State<ShadowingWhen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Text(
              'When did you shadow?',
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .05),
            Container(
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: TableCalendar(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Shadowing lastShadowing =
                        context.read<ShadowingProvider>().lastShadowing;
                    final isoDate = selectedDay.toIso8601String();
                    final date = isoDate.split('T')[0];
                    lastShadowing.date = date;
                    context
                        .read<ShadowingProvider>()
                        .setLastShadowing(lastShadowing);
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },
                headerStyle: const HeaderStyle(
                  titleTextStyle: TextStyle(
                    color: AppColors.white,
                    fontSize: 20.0,
                    fontFamily: 'Share',
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lighterBlue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(Icons.chevron_left,
                      color: AppColors.white, size: 28),
                  rightChevronIcon: Icon(Icons.chevron_right,
                      color: AppColors.white, size: 28),
                ),
                daysOfWeekVisible: false,
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: false,
                  cellMargin: EdgeInsets.all(4),
                  outsideDaysVisible: false,
                  selectedDecoration: BoxDecoration(
                    color: AppColors.lighterBlue,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Share'),
                  defaultTextStyle: TextStyle(
                      color: AppColors.darkGrey,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Share'),
                  tableBorder: TableBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
