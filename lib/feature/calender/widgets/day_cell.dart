import 'package:flutter/material.dart';
import '../widgets/add_eod.dart';

class DayCell extends StatefulWidget {
  final DateTime date;
  final DateTime currentMonth;

  const DayCell({
    super.key,
    required this.date,
    required this.currentMonth,
  });

  @override
  State<DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<DayCell> {

  bool isHovering = false;

  void showAddEodEntry(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              width: 500,
              child: AddEodEntryForm(date: date),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    bool isCurrentMonth = widget.date.month == widget.currentMonth.month;

    DateTime today = DateTime.now();

    bool isToday =
        widget.date.day == today.day &&
        widget.date.month == today.month &&
        widget.date.year == today.year;

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovering = false;
        });
      },

      child: InkWell(
        onTap: () {
          showAddEodEntry(context, widget.date);
        },  
        child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isHovering ? isCurrentMonth ? Color.fromARGB(255, 255, 237, 215) : const Color.fromARGB(30, 158, 158, 158) : Colors.transparent,
          border: Border.all(
            color: isToday
                ? const Color(0xffF47C20)
                : const Color(0xffE4C9A8),
            width: isToday ? 2 : 0.5,
          ),
        ),

        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.date.day.toString(),
                  style: TextStyle(
                    color: isCurrentMonth
                        ? Colors.black
                        : Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                  ),
                ),
              ]
            ),

            /// Hover Add Button
            if (isHovering)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    color: Color(0xffF47C20),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0,2),
                      )
                    ]
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),

          ],
        ),
      ),
      ),
    );
  }
}