import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/add_eod.dart';
import './task_card.dart';
import '../../../models/eod_model.dart';

class DayCell extends StatefulWidget {
  final DateTime date;
  final DateTime currentMonth;

  const DayCell({super.key, required this.date, required this.currentMonth});

  @override
  State<DayCell> createState() => _DayCellState();
}

class _DayCellState extends State<DayCell> {
  bool isHovering = false;
  List<Eod> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String formattedDate =
        "${widget.date.year}-${widget.date.month.toString().padLeft(2, '0')}-${widget.date.day.toString().padLeft(2, '0')}";
    String? id = prefs.getString("token");
    if (id == null) return;
    final url = Uri.parse(
      "https://eod-backend-ykjw.onrender.com/api/Eod/user/$id/date/${formattedDate}",
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Eod> loadedTasks = (data as List).map((item) {
        return Eod(
          id: item['id'],
          topic: item['topic'],
          expectedTime: item['expectedTime'],
          actualTime: item['actualTime'],
          description: item['description'],
          status: item['status'],
        );
      }).toList();
      setState(() {
        tasks = loadedTasks;
      });
    } else {
      print("Failed to load user");
    }
  }

  void showAddEodEntry(BuildContext context, DateTime date) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(width: 500, child: AddEodEntryForm(date: date)),
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
            color: isHovering
                ? isCurrentMonth
                      ? Color.fromARGB(255, 255, 237, 215)
                      : const Color.fromARGB(30, 158, 158, 158)
                : Colors.transparent,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.date.day.toString(),
                        style: TextStyle(
                          color: isCurrentMonth ? Colors.black : Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      if (isHovering)
                        Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Color(0xffF47C20),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: tasks.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            child: Column(
                              children: tasks.map((task) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: TaskCard(
                                    task: task,
                                    onTap: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                            child: Material(
                                              borderRadius: BorderRadius.circular(16),
                                              child: SizedBox(
                                                width: 500,
                                                child: AddEodEntryForm(
                                                  date: widget.date,
                                                  existingTask: task,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                      if (result == true) {
                                        loadTasks();
                                      }
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
