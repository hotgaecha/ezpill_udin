import 'package:ezpill/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBarWidget(screentitle: "Calendar"),
      ),
      body: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2023, 1, 1),
        lastDay: DateTime.utc(2033, 12, 31),
        focusedDay: DateTime.now(),
        daysOfWeekHeight: 30,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
      ),
    );
  }
}
