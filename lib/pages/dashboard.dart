import 'package:flutter/material.dart';
import '../widgets/dashboard/calendar_header.dart';
import '../widgets/dashboard/calendar_grid.dart';
import '../widgets/dashboard/eod_appbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {

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