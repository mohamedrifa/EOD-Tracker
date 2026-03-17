import 'package:flutter/material.dart';
import 'day_cell.dart';

class CalendarGrid extends StatelessWidget {

  final DateTime currentMonth;

  const CalendarGrid({super.key, required this.currentMonth});

  List<DateTime> generateCalendarDays() {

    DateTime firstDayOfMonth =
        DateTime(currentMonth.year, currentMonth.month, 1);

    int weekday = firstDayOfMonth.weekday;

    DateTime firstCalendarDay =
        firstDayOfMonth.subtract(Duration(days: weekday - 1));

    return List.generate(
      42,
      (index) => firstCalendarDay.add(Duration(days: index)),
    );
  }

  @override
  Widget build(BuildContext context) {

    List<DateTime> days = generateCalendarDays();

    return Column(
      children: [

        /// Week header
        Row(
          children: const [
            _WeekText("Monday"),
            _WeekText("Tuesday"),
            _WeekText("Wednesday"),
            _WeekText("Thursday"),
            _WeekText("Friday"),
            _WeekText("Saturday"),
            _WeekText("Sunday"),
          ],
        ),

        Expanded(
          child: GridView.builder(
            itemCount: days.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
            ),
            itemBuilder: (context, index) {

              return DayCell(
                date: days[index],
                currentMonth: currentMonth,
              );
            },
          ),
        )

      ],
    );
  }
}

class _WeekText extends StatelessWidget {

  final String text;

  const _WeekText(this.text);

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 237, 215),
          border: Border.all(
            color: const Color.fromARGB(66, 255, 111, 0),
            width: 0.5,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Color(0xffF47C20),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}