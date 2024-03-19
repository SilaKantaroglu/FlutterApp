import 'package:flutter/material.dart';
import 'package:staj_case/components/colors.dart';
//import 'package:staj_case/pages/calendarPage/calendar_detail.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('tr_TR', null);
  }

  DateTime first = DateTime.utc(2000, 6, 15);
  DateTime now = DateTime.now();
  DateTime last = DateTime.utc(2080, 6, 15);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Column(
        children: [
          Center(
            child: Transform.scale(
              scale: 0.9,
              child: TableCalendar(
                locale: "tr_TR",
                firstDay: first,
                focusedDay: now,
                rowHeight: 35,
                lastDay: last,
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  todayTextStyle: TextStyle(color: ColorUtility.white),
                  weekNumberTextStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  outsideDaysVisible: false,
                  cellMargin: EdgeInsets.all(2),
                  todayDecoration: BoxDecoration(
                    color: ColorUtility.darkBabyBlueButton,
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(weekdayStyle: _myTextStyle(), weekendStyle: _myTextStyle()),
                headerStyle: HeaderStyle(
                  leftChevronVisible: false,
                  rightChevronVisible: false,
                  titleTextStyle: _myHeaderStyle(),
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  TextStyle _myHeaderStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    );
  }

  TextStyle _myTextStyle() {
    return const TextStyle(
      fontSize: 15,
      color: ColorUtility.darkBabyBlue,
      fontWeight: FontWeight.w500,
    );
  }
}
