import 'package:flutter/material.dart';
import '../widgets/calendar_header.dart';
import '../widgets/calendar_grid.dart';
import '../../../widgets/eod_appbar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  DateTime currentMonth = DateTime.now();

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: EodAppBar(),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
        children: [

          CalendarHeader(
            currentMonth: currentMonth,
            onNext: nextMonth,
            onPrevious: previousMonth,
          ),

          Container(
            width: double.infinity,
            height: 3,
            color: Colors.red,
          ),

          Expanded(
            child: CalendarGrid(
              currentMonth: currentMonth,
            ),
          )

        ],
      ),
      )
    );
  }
}